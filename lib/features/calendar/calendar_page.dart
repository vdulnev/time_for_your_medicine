import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/state/data_state.dart';
import '../../core/state/providers.dart';
import '../../core/state/selectors.dart';
import '../../core/state/ui_providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/util/day_utils.dart';
import '../../core/widgets/error_view.dart';
import '../../l10n/l10n_extensions.dart';
import 'widgets/day_agenda.dart';
import 'widgets/month_grid.dart';

/// Month calendar with per-day agenda.
@RoutePage()
class CalendarPage extends ConsumerWidget {
  const CalendarPage({super.key});

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
        data: (data) => _CalendarContent(data: data),
      ),
    );
  }
}

class _CalendarContent extends ConsumerWidget {
  const _CalendarContent({required this.data});

  final DataState data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final month = ref.watch(calendarMonthProvider);
    final iso = ref.watch(selectedDayProvider);
    final cur = DayUtils.parse(iso);
    final locale = context.localeName;
    final l10n = context.l10n;
    final monthCtrl = ref.read(calendarMonthProvider.notifier);
    final agenda = Selectors.dayAgenda(data);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 6, 20, 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DayUtils.monthLabel(month.year, month.month, locale),
                style: AppText.bricolage(size: 20),
              ),
              Row(
                children: [
                  _MonthArrow(
                    icon: Icons.chevron_left_rounded,
                    onTap: monthCtrl.prev,
                  ),
                  const SizedBox(width: 8),
                  _MonthArrow(
                    icon: Icons.chevron_right_rounded,
                    onTap: monthCtrl.next,
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: MonthGrid(
            cells: Selectors.calendarCells(iso, month.year, month.month),
            onSelect: (cellIso) =>
                ref.read(selectedDayProvider.notifier).set(cellIso),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 14),
            children: [
              Text(
                l10n.calendarDateHeading(
                  DayUtils.weekdayFull(cur, locale),
                  DayUtils.dateLabel(cur, locale),
                ),
                style: AppText.bricolage(size: 14),
              ),
              const SizedBox(height: 2),
              Text(
                l10n.calendarReminderCount(Selectors.progress(data, iso).total),
                style: AppText.jakarta(size: 11.5, color: AppColors.muted2),
              ),
              const SizedBox(height: 12),
              DayAgenda(entries: agenda),
              const SizedBox(height: 16),
              _OpenDayButton(onTap: () => context.tabsRouter.setActiveIndex(0)),
            ],
          ),
        ),
      ],
    );
  }
}

class _MonthArrow extends StatelessWidget {
  const _MonthArrow({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.surface2,
          borderRadius: BorderRadius.circular(11),
        ),
        child: Icon(icon, size: 18, color: AppColors.ink2),
      ),
    );
  }
}

class _OpenDayButton extends StatelessWidget {
  const _OpenDayButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          context.l10n.calendarOpenThisDay,
          style: AppText.bricolage(size: 14, color: Colors.white),
        ),
      ),
    );
  }
}
