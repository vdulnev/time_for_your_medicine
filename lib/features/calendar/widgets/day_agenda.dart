import 'package:flutter/material.dart';

import '../../../core/state/selectors.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// The list of time-grouped reminders for the selected day.
class DayAgenda extends StatelessWidget {
  const DayAgenda({super.key, required this.entries});

  final List<AgendaEntry> entries;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final entry in entries) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(16),
              boxShadow: AppColors.cardShadow,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 46,
                  child: Text(
                    entry.time,
                    style: AppText.bricolage(size: 13, color: entry.accent),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    entry.names,
                    style: AppText.jakarta(size: 13, weight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 9),
        ],
      ],
    );
  }
}
