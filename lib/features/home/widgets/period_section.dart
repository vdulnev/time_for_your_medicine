import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/dose_status.dart';
import '../../../core/router/app_router.dart';
import '../../../core/state/data_state.dart';
import '../../../core/state/providers.dart';
import '../../../core/state/selectors.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/dose_action_sheet.dart';
import '../../../l10n/l10n_extensions.dart';
import 'medicine_tile.dart';

/// A time-of-day group (Morning / Afternoon / Evening) with its medicines.
class PeriodSectionView extends ConsumerWidget {
  const PeriodSectionView({
    super.key,
    required this.section,
    required this.data,
    required this.iso,
  });

  final PeriodSection section;
  final DataState data;
  final String iso;

  Future<void> _handleTap(
    BuildContext context,
    WidgetRef ref,
    String medName,
    String medId,
    String doseTimeId,
    DoseStatus current,
    bool canTake,
  ) async {
    final action = await showDoseActionSheet(
      context,
      medName: medName,
      current: current,
      canTake: canTake,
    );
    if (action == null || !context.mounted) return;

    final notifier = ref.read(dataProvider.notifier);
    switch (action) {
      case DoseStatus.taken:
        final completed = await notifier.markTaken(iso, medId, doseTimeId);
        if (completed && context.mounted) {
          context.router.push(const DoneRoute());
        }
      case DoseStatus.rejected:
        await notifier.markRejected(iso, medId, doseTimeId);
      case DoseStatus.pending:
        await notifier.revertDose(iso, medId, doseTimeId);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final period = section.period;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 4, 0, 9),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: period.bg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  width: 11,
                  height: 11,
                  decoration: BoxDecoration(
                    color: period.accent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                period.label(context.l10n),
                style: AppText.bricolage(size: 13),
              ),
              const SizedBox(width: 8),
              Text(
                section.time,
                style: AppText.jakarta(
                  size: 11,
                  weight: FontWeight.w600,
                  color: AppColors.muted2,
                ),
              ),
            ],
          ),
        ),
        for (final occ in section.occurrences) ...[
          MedicineTile(
            med: occ.med,
            doseTime: occ.doseTime,
            showTime: occ.med.times.length > 1,
            status: data.statusOf(iso, occ.med.id, occ.doseTime.id),
            onOpen: () =>
                context.router.push(MedicineDetailRoute(medId: occ.med.id)),
            onTap: () => _handleTap(
              context,
              ref,
              occ.med.name,
              occ.med.id,
              occ.doseTime.id,
              data.statusOf(iso, occ.med.id, occ.doseTime.id),
              occ.med.supply >= 1,
            ),
          ),
          const SizedBox(height: 9),
        ],
        const SizedBox(height: 7),
      ],
    );
  }
}
