import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/add_draft.dart';
import '../models/medicine.dart';
import '../models/pill_kind.dart';
import 'data_state.dart';
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

  /// Toggles a dose; returns whether the day *just* became fully taken.
  Future<bool> toggleTaken(String iso, String id) async {
    final current = _current;
    if (current == null) return false;

    final wasAll = current.meds.every((m) => current.isTaken(iso, m.id));
    final next = !current.isTaken(iso, id);
    final taken = {...current.taken, '$iso|$id': next};
    final updated = current.copyWith(taken: taken);
    state = AsyncData(updated);

    await ref.read(medicineRepositoryProvider).setTaken(iso, id, next);

    final nowAll = updated.meds.every((m) => updated.isTaken(iso, m.id));
    return nowAll && !wasAll;
  }

  Future<void> addMedicine(AddDraft draft) async {
    final current = _current;
    if (current == null || draft.name.trim().isEmpty) return;

    final med = Medicine(
      id: 'm${DateTime.now().millisecondsSinceEpoch}',
      name: draft.name.trim(),
      dose: draft.dose.trim().isEmpty ? '1 dose' : draft.dose.trim(),
      period: draft.period,
      time: draft.time.trim().isEmpty ? '8:00 AM' : draft.time.trim(),
      withFood: draft.withFood,
      kind: PillKind.round,
      c1: 0xFF5566D6,
      soft: 0xFFE7E8FB,
      supply: 30,
      cap: 30,
    );
    state = AsyncData(current.copyWith(meds: [...current.meds, med]));
    await ref.read(medicineRepositoryProvider).addMedicine(med);
  }

  Future<void> deleteMedicine(String id) async {
    final current = _current;
    if (current == null) return;

    final meds = current.meds.where((m) => m.id != id).toList();
    final taken = {...current.taken}..removeWhere((k, _) => k.endsWith('|$id'));
    final notifOff = {...current.notifOff}..remove(id);
    state = AsyncData(
      current.copyWith(meds: meds, taken: taken, notifOff: notifOff),
    );
    await ref.read(medicineRepositoryProvider).deleteMedicine(id);
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
    await ref.read(medicineRepositoryProvider).saveSettings(next);
  }

  /// Sets the user's language override ("en" / "uk"), or `null` to follow
  /// the device locale (see `resolveLocale`).
  Future<void> setLocaleOverride(String? code) async {
    final current = _current;
    if (current == null) return;

    final next = current.settings.copyWith(localeOverride: code);
    state = AsyncData(current.copyWith(settings: next));
    await ref.read(medicineRepositoryProvider).saveSettings(next);
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
    await ref.read(medicineRepositoryProvider).setNotifOff(id, off);
  }
}
