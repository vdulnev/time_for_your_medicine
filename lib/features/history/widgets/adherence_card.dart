import 'package:flutter/material.dart';

import '../../../core/state/selectors.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../l10n/l10n_extensions.dart';

/// The indigo "7-day adherence" summary card at the top of History.
class AdherenceCard extends StatelessWidget {
  const AdherenceCard({super.key, required this.summary});

  final HistorySummary summary;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.historyAdherence7Day,
            style: AppText.jakarta(size: 12, color: AppColors.primaryFaint),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.historyAdherencePct(summary.adherence),
            style: AppText.bricolage(size: 38, color: Colors.white),
          ),
          const SizedBox(height: 2),
          Text(
            summary.isExcellent
                ? l10n.historyExcellent
                : l10n.historyRoomToImprove,
            style: AppText.jakarta(size: 12, color: AppColors.primaryFaint),
          ),
        ],
      ),
    );
  }
}
