import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../l10n/l10n_extensions.dart';

/// The orange "X is low — order soon" banner (or the healthy variant).
class RefillAlertBanner extends StatelessWidget {
  const RefillAlertBanner({super.key, required this.lowSupplyName});

  final String lowSupplyName;

  @override
  Widget build(BuildContext context) {
    final hasLow = lowSupplyName.isNotEmpty;
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        color: AppColors.alertBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.alertIcon,
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Icon(
              Icons.error_outline_rounded,
              size: 18,
              color: AppColors.alertInk2,
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hasLow
                      ? l10n.refillsMedicineIsLow(lowSupplyName)
                      : l10n.refillsAllHealthy,
                  style: AppText.jakarta(
                    size: 13,
                    weight: FontWeight.w700,
                    color: AppColors.alertInk,
                  ),
                ),
                if (hasLow)
                  Text(
                    l10n.refillsRunningLow,
                    style: AppText.jakarta(
                      size: 11,
                      color: AppColors.alertInk2,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
