import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/router/app_router.dart';
import '../../core/state/data_state.dart';
import '../../core/state/providers.dart';
import '../../core/state/selectors.dart';
import '../../core/state/ui_providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/util/day_utils.dart';
import '../../core/widgets/error_view.dart';
import 'widgets/period_section.dart';
import 'widgets/progress_card.dart';
import 'widgets/week_strip.dart';

/// The main day view: header, week strip, progress, and grouped medicines.
@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(dataProvider);
    return SafeArea(
      bottom: false,
      child: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorView(
          error: error,
          onRetry: () => ref.invalidate(dataProvider),
        ),
        data: (data) => _HomeContent(data: data),
      ),
    );
  }
}

class _HomeContent extends ConsumerWidget {
  const _HomeContent({required this.data});

  final DataState data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final iso = ref.watch(selectedDayProvider);
    final cur = DayUtils.parse(iso);
    final periods = Selectors.periods(data);
    final dayCtrl = ref.read(selectedDayProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 6, 18, 0),
          child: Column(
            children: [
              Row(
                children: [
                  _IconTapButton(
                    icon: Icons.chevron_left_rounded,
                    onTap: () => dayCtrl.shift(-1),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DayUtils.weekdayFull(cur),
                        style: AppText.jakarta(
                          size: 11.5,
                          weight: FontWeight.w500,
                          color: AppColors.muted2,
                        ),
                      ),
                      Text(
                        DayUtils.dateLabel(cur),
                        style: AppText.bricolage(size: 22, height: 1.05),
                      ),
                    ],
                  ),
                  _IconTapButton(
                    icon: Icons.chevron_right_rounded,
                    onTap: () => dayCtrl.shift(1),
                  ),
                  const Spacer(),
                  _HeaderButton(
                    background: AppColors.surface2,
                    icon: Icons.notifications_none_rounded,
                    iconColor: AppColors.ink2,
                    onTap: () =>
                        context.router.push(const NotificationsRoute()),
                  ),
                  const SizedBox(width: 7),
                  _HeaderButton(
                    background: AppColors.surfaceIndigo,
                    icon: Icons.calendar_today_outlined,
                    iconColor: AppColors.primary,
                    onTap: () => context.tabsRouter.setActiveIndex(1),
                  ),
                ],
              ),
              const SizedBox(height: 13),
              const WeekStrip(),
              const SizedBox(height: 12),
              ProgressCard(data: data),
              const SizedBox(height: 12),
            ],
          ),
        ),
        Expanded(
          child: periods.isEmpty
              ? const _EmptyDay()
              : ListView(
                  padding: const EdgeInsets.fromLTRB(18, 2, 18, 14),
                  children: [
                    for (final section in periods)
                      PeriodSectionView(section: section, data: data, iso: iso),
                  ],
                ),
        ),
      ],
    );
  }
}

class _EmptyDay extends StatelessWidget {
  const _EmptyDay();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No medicines yet.\nTap + to add one.',
        textAlign: TextAlign.center,
        style: AppText.jakarta(size: 13, color: AppColors.muted2, height: 1.5),
      ),
    );
  }
}

class _IconTapButton extends StatelessWidget {
  const _IconTapButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      radius: 20,
      child: SizedBox(
        width: 30,
        height: 30,
        child: Icon(icon, size: 22, color: AppColors.ink2),
      ),
    );
  }
}

class _HeaderButton extends StatelessWidget {
  const _HeaderButton({
    required this.background,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  final Color background;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, size: 19, color: iconColor),
      ),
    );
  }
}
