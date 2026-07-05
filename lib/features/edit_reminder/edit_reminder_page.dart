import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/add_draft.dart';
import '../../core/models/dose_time.dart';
import '../../core/state/providers.dart';
import '../../core/state/selectors.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../l10n/l10n_extensions.dart';
import '../add/widgets/time_slot_card.dart';
import 'edit_reminder_form_provider.dart';

/// Lets the user add new reminder times to an existing medicine. Existing
/// times are shown for context but aren't editable or removable here.
@RoutePage()
class EditReminderPage extends ConsumerWidget {
  const EditReminderPage({super.key, required this.medId});

  final String medId;

  static String _norm(String t) => t.trim().toUpperCase();

  /// Whether any staged slot's resolved time duplicates an existing time or
  /// another staged slot — two identical reminder times on one medicine
  /// would be indistinguishable to the user.
  static bool _hasDuplicate(List<DoseTime> existing, List<DraftTime> staged) {
    final existingNorm = existing.map((t) => _norm(t.time)).toSet();
    final seen = <String>{};
    for (final s in staged) {
      final resolved = s.time.trim().isEmpty
          ? s.period.defaultDisplayTime
          : s.time.trim();
      final key = _norm(resolved);
      if (existingNorm.contains(key) || !seen.add(key)) return true;
    }
    return false;
  }

  Future<void> _save(BuildContext context, WidgetRef ref) async {
    final draft = ref.read(editReminderFormProvider(medId));
    await ref.read(dataProvider.notifier).addReminderTimes(medId, draft);
    if (context.mounted) context.router.maybePop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(dataProvider).valueOrNull;
    final med = data == null ? null : Selectors.medById(data, medId);
    final draft = ref.watch(editReminderFormProvider(medId));
    final form = ref.read(editReminderFormProvider(medId).notifier);
    final l10n = context.l10n;

    if (data == null || med == null) {
      return const Scaffold(
        backgroundColor: AppColors.screenBg,
        body: SizedBox.shrink(),
      );
    }

    final canSave = !_hasDuplicate(med.times, draft);

    return Scaffold(
      backgroundColor: AppColors.screenBg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 6, 18, 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.router.maybePop(),
                    child: Container(
                      width: 36,
                      height: 36,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.surface2,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.close_rounded,
                        size: 20,
                        color: AppColors.ink2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    l10n.editReminderTitle,
                    style: AppText.bricolage(size: 19),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 2, 18, 0),
                children: [
                  _SectionLabel(l10n.editReminderCurrentTimesLabel),
                  for (final t in med.times) ...[
                    _ExistingTimeRow(doseTime: t),
                    const SizedBox(height: 8),
                  ],
                  const SizedBox(height: 10),
                  for (var i = 0; i < draft.length; i++) ...[
                    TimeSlotCard(
                      key: ValueKey('new-time-slot-$i'),
                      index: i,
                      time: draft[i].time,
                      period: draft[i].period,
                      removable: draft.length > 1,
                      onTimeChanged: (v) => form.setTimeAt(i, v),
                      onPeriodChanged: (p) => form.setPeriodAt(i, p),
                      onRemove: () => form.removeTimeSlotAt(i),
                    ),
                    const SizedBox(height: 10),
                  ],
                  GestureDetector(
                    onTap: form.addTimeSlot,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.add_rounded,
                          size: 18,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          l10n.addAnotherTime,
                          style: AppText.jakarta(
                            size: 12.5,
                            weight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                18,
                12,
                18,
                20 + MediaQuery.of(context).padding.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!canSave) ...[
                    Text(
                      l10n.editReminderDuplicateHint,
                      textAlign: TextAlign.center,
                      style: AppText.jakarta(
                        size: 11.5,
                        weight: FontWeight.w600,
                        color: AppColors.muted,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  GestureDetector(
                    onTap: canSave ? () => _save(context, ref) : null,
                    child: Container(
                      height: 52,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: canSave ? AppColors.primary : AppColors.muted3,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: canSave
                            ? [
                                BoxShadow(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.6,
                                  ),
                                  blurRadius: 22,
                                  offset: const Offset(0, 12),
                                  spreadRadius: -8,
                                ),
                              ]
                            : null,
                      ),
                      child: Text(
                        l10n.editReminderSaveButton,
                        style: AppText.bricolage(size: 15, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Text(
        text,
        style: AppText.jakarta(
          size: 11,
          weight: FontWeight.w700,
          color: AppColors.muted,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

/// A single existing reminder time, read-only — no remove/edit affordance.
class _ExistingTimeRow extends StatelessWidget {
  const _ExistingTimeRow({required this.doseTime});

  final DoseTime doseTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: doseTime.period.accent,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            doseTime.time,
            style: AppText.jakarta(size: 14, weight: FontWeight.w700),
          ),
          const Spacer(),
          Text(
            doseTime.period.label(context.l10n),
            style: AppText.jakarta(size: 12, color: AppColors.muted2),
          ),
        ],
      ),
    );
  }
}
