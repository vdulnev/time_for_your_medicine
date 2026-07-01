import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/state/data_state.dart';
import '../../core/state/providers.dart';
import '../../core/state/ui_providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/util/day_utils.dart';
import '../../core/widgets/error_view.dart';
import '../../l10n/l10n_extensions.dart';
import 'widgets/reminder_tile.dart';

/// Per-medicine reminder toggles.
@RoutePage()
class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({super.key});

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
          data: (data) => _NotificationsContent(data: data),
        ),
      ),
    );
  }
}

class _NotificationsContent extends ConsumerWidget {
  const _NotificationsContent({required this.data});

  final DataState data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final iso = ref.watch(selectedDayProvider);
    final cur = DayUtils.parse(iso);
    final locale = context.localeName;
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
              Text(l10n.remindersTitle, style: AppText.bricolage(size: 19)),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(18, 6, 18, 14),
            children: [
              Text(
                l10n.remindersToday(DayUtils.dateLabel(cur, locale)),
                style: AppText.jakarta(
                  size: 11,
                  weight: FontWeight.w600,
                  color: AppColors.muted,
                ),
              ),
              const SizedBox(height: 10),
              for (final med in data.meds) ...[
                ReminderTile(
                  med: med,
                  on: data.reminderOn(med.id),
                  onToggle: () =>
                      ref.read(dataProvider.notifier).toggleNotif(med.id),
                ),
                const SizedBox(height: 10),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
