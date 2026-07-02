import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/state/providers.dart';
import '../../core/state/selectors.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/error_view.dart';
import '../../l10n/l10n_extensions.dart';
import 'widgets/transaction_filter_bar.dart';
import 'widgets/transaction_tile.dart';

/// The supply-transaction ledger, filterable by medicine and date range.
@RoutePage()
class TransactionsPage extends ConsumerWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataAsync = ref.watch(dataProvider);
    final transactionsAsync = ref.watch(transactionsProvider);
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      body: SafeArea(
        child: Column(
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
                    context.l10n.transactionsTitle,
                    style: AppText.bricolage(size: 19),
                  ),
                ],
              ),
            ),
            Expanded(
              child: dataAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => ErrorView(
                  error: error,
                  onRetry: () => ref.invalidate(dataProvider),
                ),
                data: (data) => transactionsAsync.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, _) => ErrorView(
                    error: error,
                    onRetry: () => ref.invalidate(transactionsProvider),
                  ),
                  data: (rows) {
                    final filter = ref.watch(transactionFilterProvider);
                    final controller = ref.read(
                      transactionFilterProvider.notifier,
                    );
                    final entries = Selectors.transactions(
                      rows,
                      data,
                      medId: filter.medId,
                      interval: filter.interval,
                    );
                    return ListView(
                      padding: const EdgeInsets.fromLTRB(18, 0, 18, 14),
                      children: [
                        TransactionFilterBar(
                          meds: data.meds,
                          medId: filter.medId,
                          interval: filter.interval,
                          onMedIdChanged: controller.setMedId,
                          onIntervalChanged: controller.setInterval,
                        ),
                        const SizedBox(height: 14),
                        if (entries.isEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: Center(
                              child: Text(
                                context.l10n.transactionsEmpty,
                                textAlign: TextAlign.center,
                                style: AppText.jakarta(
                                  size: 13,
                                  color: AppColors.muted,
                                ),
                              ),
                            ),
                          )
                        else
                          for (final entry in entries) ...[
                            TransactionTile(entry: entry),
                            const SizedBox(height: 10),
                          ],
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
