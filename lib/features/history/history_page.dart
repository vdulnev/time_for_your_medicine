import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/router/app_router.dart';
import '../../core/state/providers.dart';
import '../../core/state/selectors.dart';
import '../../core/state/ui_providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/error_view.dart';
import '../../l10n/l10n_extensions.dart';
import 'widgets/adherence_bars.dart';
import 'widgets/adherence_card.dart';

/// 7-day adherence history + chart.
@RoutePage()
class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(dataProvider);
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      body: SafeArea(
        child: async.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => ErrorView(
            error: error,
            onRetry: () => ref.invalidate(dataProvider),
          ),
          data: (data) {
            final iso = ref.watch(selectedDayProvider);
            final summary = Selectors.history(data, iso, context.localeName);
            final l10n = context.l10n;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 6, 18, 8),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.router.maybePop(),
                        child: Container(
                          width: 36,
                          height: 36,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.surface2,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.chevron_left_rounded,
                            size: 20,
                            color: AppColors.ink2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        l10n.historyTitle,
                        style: AppText.bricolage(size: 19),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(18, 6, 18, 14),
                    children: [
                      AdherenceCard(summary: summary),
                      const SizedBox(height: 8),
                      AdherenceBars(bars: summary.bars),
                      const SizedBox(height: 8),
                      _SummaryRow(
                        label: l10n.historyDosesTaken,
                        value: l10n.historyDaysOfSeven(summary.fullDays),
                      ),
                      const SizedBox(height: 9),
                      _SummaryRow(
                        label: l10n.historyCurrentStreak,
                        value: l10n.historyStreakDays(summary.streak),
                        valueColor: AppColors.primary,
                      ),
                      const SizedBox(height: 9),
                      _SummaryRow(
                        label: l10n.historyBestTime,
                        value: l10n.periodMorning,
                      ),
                      const SizedBox(height: 14),
                      _TransactionsNavRow(
                        onTap: () =>
                            context.router.push(const TransactionsRoute()),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _TransactionsNavRow extends StatelessWidget {
  const _TransactionsNavRow({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(14),
          boxShadow: AppColors.cardShadow,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.l10n.historyViewTransactions,
              style: AppText.jakarta(size: 13, weight: FontWeight.w700),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              size: 18,
              color: AppColors.muted3,
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueColor = AppColors.ink,
  });

  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        boxShadow: AppColors.cardShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppText.jakarta(size: 13, weight: FontWeight.w700),
          ),
          Text(value, style: AppText.bricolage(size: 13, color: valueColor)),
        ],
      ),
    );
  }
}
