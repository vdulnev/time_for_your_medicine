import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/router/app_router.dart';
import '../../../core/state/data_state.dart';
import '../../../core/state/providers.dart';
import '../../../core/state/selectors.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
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

  Future<void> _toggle(BuildContext context, WidgetRef ref, String id) async {
    final completed = await ref
        .read(dataProvider.notifier)
        .toggleTaken(iso, id);
    if (completed && context.mounted) {
      context.router.push(const DoneRoute());
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
        for (final med in section.meds) ...[
          MedicineTile(
            med: med,
            taken: data.isTaken(iso, med.id),
            onOpen: () =>
                context.router.push(MedicineDetailRoute(medId: med.id)),
            onToggle: () => _toggle(context, ref, med.id),
          ),
          const SizedBox(height: 9),
        ],
        const SizedBox(height: 7),
      ],
    );
  }
}
