import 'package:flutter/material.dart';

import '../../../core/models/medicine.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../shell/widgets/toggle_switch.dart';

/// A single medicine's reminder row with an on/off switch.
class ReminderTile extends StatelessWidget {
  const ReminderTile({
    super.key,
    required this.med,
    required this.on,
    required this.onToggle,
  });

  final Medicine med;
  final bool on;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppColors.cardShadow,
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.surfaceIndigo,
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Icon(
              Icons.notifications_none_rounded,
              size: 19,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  med.name,
                  style: AppText.jakarta(size: 13.5, weight: FontWeight.w700),
                ),
                Text(
                  '${med.time} · ${med.dose}',
                  style: AppText.jakarta(size: 11, color: AppColors.muted2),
                ),
              ],
            ),
          ),
          ToggleSwitch(on: on, onTap: onToggle),
        ],
      ),
    );
  }
}
