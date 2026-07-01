import 'package:flutter/material.dart';

import '../../../core/state/selectors.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// The 7-bar adherence chart.
class AdherenceBars extends StatelessWidget {
  const AdherenceBars({super.key, required this.bars});

  final List<HistoryBar> bars;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (final bar in bars) ...[
            Expanded(child: _Bar(bar: bar)),
            if (bar != bars.last) const SizedBox(width: 7),
          ],
        ],
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({required this.bar});

  final HistoryBar bar;

  @override
  Widget build(BuildContext context) {
    final color = bar.full
        ? AppColors.primary
        : (bar.partial ? AppColors.primarySoft : AppColors.ringTrack);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: bar.heightPct / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 7),
        Text(
          bar.initial,
          style: AppText.jakarta(
            size: 10,
            weight: FontWeight.w700,
            color: AppColors.muted2,
          ),
        ),
      ],
    );
  }
}
