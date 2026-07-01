import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/router/app_router.dart';
import '../../../core/state/data_state.dart';
import '../../../core/state/selectors.dart';
import '../../../core/state/ui_providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import 'progress_ring.dart';

/// The tappable "doses left today" progress card that opens History.
class ProgressCard extends ConsumerWidget {
  const ProgressCard({super.key, required this.data});

  final DataState data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final iso = ref.watch(selectedDayProvider);
    final progress = Selectors.progress(data, iso);

    return GestureDetector(
      onTap: () => context.router.push(const HistoryRoute()),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ProgressRing(
              percent: progress.pct,
              child: Text(
                progress.fraction,
                style: AppText.jakarta(size: 10, weight: FontWeight.w800),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    progress.title,
                    style: AppText.bricolage(size: 13.5, height: 1.2),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    progress.subtitle,
                    style: AppText.jakarta(size: 11, color: AppColors.muted2),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: AppColors.muted3,
            ),
          ],
        ),
      ),
    );
  }
}
