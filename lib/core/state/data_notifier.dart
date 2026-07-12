import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../error/app_exception.dart';
import '../models/add_draft.dart';
import '../models/dose_status.dart';
import '../models/dose_time.dart';
import '../models/medicine.dart';
import '../models/pill_kind.dart';
import 'data_state.dart';
import 'error_notifier.dart';
import 'providers.dart';

/// Loads [DataState] from the repository and applies mutations, writing each
/// change through to the database.
class DataNotifier extends AsyncNotifier<DataState> {
  @override
  Future<DataState> build() async {
    final result = await ref.read(medicineRepositoryProvider).loadAll();
    return result.getOrElse((failure) => throw failure);
  }

  DataState? get _current => state.valueOrNull;

  /// Surfaces a failed background write via [errorNotifierProvider] so a
  /// listener can show it (e.g. a snackbar) — otherwise a write failure
  /// is invisible: the optimistic UI update already applied, and nothing
  /// else indicates the persist never reached disk.
  void _reportIfFailed<T>(Either<AppException, T> result) {
    result.fold(
      (failure) => ref.read(errorNotifierProvider.notifier).report(failure),
      (_) {},
    );
  }

  /// Reconciles the OS notification schedule with the current state.
  /// Fire-and-forget after every mutation that changes what or when to
  /// notify — the service is a no-op in tests and logs (never throws) on
  /// platform failures, so this can't break the mutation it follows.
  void _syncNotifications() {
    final current = _current;
    if (current == null) return;
    unawaited(ref.read(notificationServiceProvider).sync(current));
  }

  /// [supplyByMedId] with [medId]'s supply shifted by [delta], floored at
  /// 0. Mirrors what the repository does in the same call, so the UI
  /// updates immediately rather than waiting on the DB round-trip.
  Map<String, int> _creditSupply(
    Map<String, int> supplyByMedId,
    String medId,
    int delta,
  ) {
    final next = (supplyByMedId[medId] ?? 0) + delta;
    return {...supplyByMedId, medId: next < 0 ? 0 : next};
  }

  /// Marks a dose taken, consuming one pill. Returns whether the day
  /// *just* became fully taken (every scheduled dose of every medicine).
  Future<bool> markTaken(String iso, String medId, String doseTimeId) async {
    final current = _current;
    if (current == null) return false;
    if (current.statusOf(iso, medId, doseTimeId) == DoseStatus.taken) {
      return false;
    }

    final hasMed = current.meds.any((m) => m.id == medId);
    if (!hasMed || current.supplyOf(medId) < 1) return false;

    final wasAll = current.allTaken(iso);
    final key = '$iso|$medId|$doseTimeId';
    final doseStatus = {...current.doseStatus, key: DoseStatus.taken};
    final supplyByMedId = _creditSupply(current.supplyByMedId, medId, -1);
    final updated = current.copyWith(
      doseStatus: doseStatus,
      supplyByMedId: supplyByMedId,
    );
    state = AsyncData(updated);
    _syncNotifications();

    final repo = ref.read(medicineRepositoryProvider);
    _reportIfFailed(
      await repo.setDoseStatus(iso, medId, doseTimeId, DoseStatus.taken),
    );
    _reportIfFailed(
      await repo.recordTake(medId, iso: iso, doseTimeId: doseTimeId),
    );

    return updated.allTaken(iso) && !wasAll;
  }

  /// Marks a dose rejected (deliberately skipped). Doesn't touch supply —
  /// no pill was taken.
  Future<void> markRejected(String iso, String medId, String doseTimeId) async {
    final current = _current;
    if (current == null) return;
    if (current.statusOf(iso, medId, doseTimeId) == DoseStatus.rejected) {
      return;
    }

    final key = '$iso|$medId|$doseTimeId';
    final doseStatus = {...current.doseStatus, key: DoseStatus.rejected};
    state = AsyncData(current.copyWith(doseStatus: doseStatus));
    _syncNotifications();

    _reportIfFailed(
      await ref
          .read(medicineRepositoryProvider)
          .setDoseStatus(iso, medId, doseTimeId, DoseStatus.rejected),
    );
  }

  /// Reverts a taken or rejected dose back to not-touched. If it had been
  /// taken, credits the pill back to supply.
  Future<void> revertDose(String iso, String medId, String doseTimeId) async {
    final current = _current;
    if (current == null) return;
    final prev = current.statusOf(iso, medId, doseTimeId);
    if (prev == DoseStatus.pending) return;

    final key = '$iso|$medId|$doseTimeId';
    final doseStatus = {...current.doseStatus}..remove(key);
    final supplyByMedId = prev == DoseStatus.taken
        ? _creditSupply(current.supplyByMedId, medId, 1)
        : current.supplyByMedId;
    state = AsyncData(
      current.copyWith(doseStatus: doseStatus, supplyByMedId: supplyByMedId),
    );
    _syncNotifications();

    final repo = ref.read(medicineRepositoryProvider);
    _reportIfFailed(
      await repo.setDoseStatus(iso, medId, doseTimeId, DoseStatus.pending),
    );
    if (prev == DoseStatus.taken) {
      _reportIfFailed(
        await repo.recordRevertTake(medId, iso: iso, doseTimeId: doseTimeId),
      );
    }
  }

  Future<void> addMedicine(AddDraft draft) async {
    final current = _current;
    final supply = int.tryParse(draft.supply.trim());
    if (current == null ||
        draft.name.trim().isEmpty ||
        supply == null ||
        supply <= 0) {
      return;
    }

    final slots = draft.times.isEmpty
        ? const [DraftTime(time: '8:00 AM')]
        : draft.times;

    final med = Medicine(
      id: 'm${DateTime.now().millisecondsSinceEpoch}',
      name: draft.name.trim(),
      dose: draft.dose.trim().isEmpty ? '1 dose' : draft.dose.trim(),
      times: [
        for (var i = 0; i < slots.length; i++)
          DoseTime(
            id: 't$i',
            time: slots[i].time.trim().isEmpty
                ? slots[i].period.defaultDisplayTime
                : slots[i].time.trim(),
            period: slots[i].period,
          ),
      ],
      withFood: draft.withFood,
      kind: PillKind.round,
      c1: 0xFF5566D6,
      soft: 0xFFE7E8FB,
    );
    state = AsyncData(
      current.copyWith(
        meds: [...current.meds, med],
        supplyByMedId: {...current.supplyByMedId, med.id: supply},
      ),
    );
    _syncNotifications();
    _reportIfFailed(
      await ref.read(medicineRepositoryProvider).addMedicine(med, supply),
    );
  }

  /// Appends one or more new reminder times to an existing medicine.
  /// Existing times are never touched — this only ever inserts. A no-op if
  /// any [newSlots] entry's resolved time duplicates an existing time or
  /// another entry in the same call, since two identical reminder times on
  /// one medicine would be indistinguishable to the user.
  Future<void> addReminderTimes(String medId, List<DraftTime> newSlots) async {
    final current = _current;
    if (current == null || newSlots.isEmpty) return;
    final medIndex = current.meds.indexWhere((m) => m.id == medId);
    if (medIndex == -1) return;
    final med = current.meds[medIndex];

    String resolve(DraftTime s) =>
        s.time.trim().isEmpty ? s.period.defaultDisplayTime : s.time.trim();
    String norm(String t) => t.trim().toUpperCase();

    final existing = med.times.map((t) => norm(t.time)).toSet();
    final seen = <String>{};
    for (final s in newSlots) {
      final key = norm(resolve(s));
      if (existing.contains(key) || !seen.add(key)) return;
    }

    // Timestamp-based: guaranteed to never collide with any id this
    // medicine has ever had (unlike the `t0`/`t1`/... indices `addMedicine`
    // assigns at creation), so a later addition can't accidentally inherit
    // an unrelated slot's DoseLog/SupplyTransactions history.
    final baseTs = DateTime.now().microsecondsSinceEpoch;
    final added = [
      for (var i = 0; i < newSlots.length; i++)
        DoseTime(
          id: 't${baseTs}_$i',
          time: resolve(newSlots[i]),
          period: newSlots[i].period,
        ),
    ];

    final meds = [...current.meds];
    meds[medIndex] = med.copyWith(times: [...med.times, ...added]);
    state = AsyncData(current.copyWith(meds: meds));
    _syncNotifications();

    _reportIfFailed(
      await ref
          .read(medicineRepositoryProvider)
          .addReminderTimes(medId, added, startSortOrder: med.times.length),
    );
  }

  /// Records a refill: the medicine now has [newSupply] pills.
  Future<void> refillMedicine(String medId, int newSupply) async {
    final current = _current;
    if (current == null || newSupply <= 0) return;

    state = AsyncData(
      current.copyWith(
        supplyByMedId: {...current.supplyByMedId, medId: newSupply},
      ),
    );
    _reportIfFailed(
      await ref
          .read(medicineRepositoryProvider)
          .refillMedicine(medId, newSupply),
    );
  }

  Future<void> deleteMedicine(String id) async {
    final current = _current;
    if (current == null) return;

    final meds = current.meds.where((m) => m.id != id).toList();
    final doseStatus = {...current.doseStatus}
      ..removeWhere((k, _) => k.split('|')[1] == id);
    final notifOff = {...current.notifOff}..remove(id);
    final supplyByMedId = {...current.supplyByMedId}..remove(id);
    state = AsyncData(
      current.copyWith(
        meds: meds,
        doseStatus: doseStatus,
        notifOff: notifOff,
        supplyByMedId: supplyByMedId,
      ),
    );
    _syncNotifications();
    _reportIfFailed(
      await ref.read(medicineRepositoryProvider).deleteMedicine(id),
    );
  }

  Future<void> toggleSetting(String key) async {
    final current = _current;
    if (current == null) return;

    final s = current.settings;
    final next = switch (key) {
      'sound' => s.copyWith(sound: !s.sound),
      'vibrate' => s.copyWith(vibrate: !s.vibrate),
      'refill' => s.copyWith(refill: !s.refill),
      _ => s,
    };
    state = AsyncData(current.copyWith(settings: next));
    // sound/vibrate feed the scheduled notifications' channel settings.
    _syncNotifications();
    _reportIfFailed(
      await ref.read(medicineRepositoryProvider).saveSettings(next),
    );
  }

  /// Sets the user's language override ("en" / "uk"), or `null` to follow
  /// the device locale (see `resolveLocale`).
  Future<void> setLocaleOverride(String? code) async {
    final current = _current;
    if (current == null) return;

    final next = current.settings.copyWith(localeOverride: code);
    state = AsyncData(current.copyWith(settings: next));
    // Scheduled notification text is baked in at schedule time, so a
    // language change means rebuilding the schedules.
    _syncNotifications();
    _reportIfFailed(
      await ref.read(medicineRepositoryProvider).saveSettings(next),
    );
  }

  Future<void> toggleNotif(String id) async {
    final current = _current;
    if (current == null) return;

    final off = !(current.notifOff[id] ?? false);
    final notifOff = {...current.notifOff};
    if (off) {
      notifOff[id] = true;
    } else {
      notifOff.remove(id);
    }
    state = AsyncData(current.copyWith(notifOff: notifOff));
    _syncNotifications();
    _reportIfFailed(
      await ref.read(medicineRepositoryProvider).setNotifOff(id, off),
    );
  }
}
