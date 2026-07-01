import 'package:flutter/material.dart';

import '../../../core/state/selectors.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// The "last 7 days" dot row on the detail screen.
class DetailWeekRow extends StatelessWidget {
  const DetailWeekRow({super.key, required this.days});

  final List<DetailDay> days;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (final day in days)
            Column(
              children: [
                _Dot(day: day),
                const SizedBox(height: 6),
                Text(
                  day.initial,
                  style: AppText.jakarta(size: 10, color: AppColors.muted),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.day});

  final DetailDay day;

  @override
  Widget build(BuildContext context) {
    if (day.done) {
      return Container(
        width: 24,
        height: 24,
        decoration: const BoxDecoration(
          color: AppColors.successDot,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.check_rounded, size: 14, color: Colors.white),
      );
    }
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: day.isSelectedDay ? AppColors.primary : Colors.transparent,
        border: day.isSelectedDay
            ? null
            : Border.all(color: AppColors.checkBorder, width: 2),
      ),
    );
  }
}
