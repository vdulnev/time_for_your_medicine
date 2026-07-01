import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/state/selectors.dart';
import '../../../core/state/ui_providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/util/day_utils.dart';

/// The Mon–Sun day selector strip under the Home header.
class WeekStrip extends ConsumerWidget {
  const WeekStrip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final iso = ref.watch(selectedDayProvider);
    final days = Selectors.weekStrip(iso);

    return Row(
      children: [
        for (final d in days)
          Expanded(
            child: GestureDetector(
              onTap: () => ref
                  .read(selectedDayProvider.notifier)
                  .setDay(DayUtils.parse(d.iso)),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 1.5),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: d.active ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: d.active
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.6),
                            blurRadius: 16,
                            offset: const Offset(0, 9),
                            spreadRadius: -7,
                          ),
                        ]
                      : null,
                ),
                child: Column(
                  children: [
                    Text(
                      d.initial,
                      style: AppText.jakarta(
                        size: 9,
                        weight: FontWeight.w600,
                        color: d.active
                            ? AppColors.primaryFaint
                            : AppColors.muted2,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${d.day}',
                      style: AppText.bricolage(
                        size: 14,
                        color: d.active ? Colors.white : AppColors.ink2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
