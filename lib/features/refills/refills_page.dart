import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/state/providers.dart';
import '../../core/state/selectors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/error_view.dart';
import '../../l10n/l10n_extensions.dart';
import 'widgets/refill_alert_banner.dart';
import 'widgets/refill_tile.dart';

/// Supply tracking + refill ordering.
@RoutePage()
class RefillsPage extends ConsumerWidget {
  const RefillsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(dataProvider);
    return SafeArea(
      child: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorView(
          error: error,
          onRetry: () => ref.invalidate(dataProvider),
        ),
        data: (data) {
          final refills = Selectors.refills(data);
          final lowName = Selectors.lowSupplyName(data);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 6, 18, 8),
                child: Text(
                  context.l10n.refillsTitle,
                  style: AppText.bricolage(size: 22),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(18, 6, 18, 14),
                  children: [
                    RefillAlertBanner(lowSupplyName: lowName),
                    const SizedBox(height: 14),
                    for (final item in refills) ...[
                      RefillTile(item: item),
                      const SizedBox(height: 10),
                    ],
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
