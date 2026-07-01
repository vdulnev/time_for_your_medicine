import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/router/app_router.dart';
import '../../core/state/data_state.dart';
import '../../core/state/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/error_view.dart';
import '../shell/widgets/toggle_switch.dart';

/// Profile, preference toggles, and navigation rows.
@RoutePage()
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

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
        data: (data) => _SettingsContent(data: data),
      ),
    );
  }
}

class _SettingsContent extends ConsumerWidget {
  const _SettingsContent({required this.data});

  final DataState data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = data.settings;
    final controller = ref.read(dataProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 6, 18, 8),
          child: Text('Settings', style: AppText.bricolage(size: 22)),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(18, 6, 18, 14),
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: AppColors.cardShadow,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: AppColors.surfaceIndigo,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        'AM',
                        style: AppText.bricolage(
                          size: 17,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 13),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Alex Morgan',
                          style: AppText.jakarta(
                            size: 15,
                            weight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          '${data.meds.length} active medicines',
                          style: AppText.jakarta(
                            size: 11.5,
                            color: AppColors.muted2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _SectionLabel('PREFERENCES'),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: AppColors.cardShadow,
                ),
                child: Column(
                  children: [
                    _PreferenceRow(
                      label: 'Reminder sound',
                      on: settings.sound,
                      onToggle: () => controller.toggleSetting('sound'),
                      showDivider: true,
                    ),
                    _PreferenceRow(
                      label: 'Vibration',
                      on: settings.vibrate,
                      onToggle: () => controller.toggleSetting('vibrate'),
                      showDivider: true,
                    ),
                    _PreferenceRow(
                      label: 'Refill alerts',
                      on: settings.refill,
                      onToggle: () => controller.toggleSetting('refill'),
                      showDivider: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              _SectionLabel('MORE'),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: AppColors.cardShadow,
                ),
                child: Column(
                  children: [
                    _NavRow(
                      label: 'History & adherence',
                      onTap: () => context.router.push(const HistoryRoute()),
                      showDivider: true,
                    ),
                    _NavRow(
                      label: 'Refills',
                      onTap: () => context.tabsRouter.setActiveIndex(2),
                      showDivider: true,
                    ),
                    _NavRow(
                      label: 'Reminders',
                      onTap: () =>
                          context.router.push(const NotificationsRoute()),
                      showDivider: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 0, 2, 8),
      child: Text(
        text,
        style: AppText.jakarta(
          size: 11,
          weight: FontWeight.w700,
          color: AppColors.muted,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _PreferenceRow extends StatelessWidget {
  const _PreferenceRow({
    required this.label,
    required this.on,
    required this.onToggle,
    required this.showDivider,
  });

  final String label;
  final bool on;
  final VoidCallback onToggle;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13),
      decoration: BoxDecoration(
        border: showDivider
            ? const Border(bottom: BorderSide(color: AppColors.divider))
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppText.jakarta(size: 13.5, weight: FontWeight.w700),
          ),
          ToggleSwitch(on: on, onTap: onToggle),
        ],
      ),
    );
  }
}

class _NavRow extends StatelessWidget {
  const _NavRow({
    required this.label,
    required this.onTap,
    required this.showDivider,
  });

  final String label;
  final VoidCallback onTap;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          border: showDivider
              ? const Border(bottom: BorderSide(color: AppColors.divider))
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: AppText.jakarta(size: 13.5, weight: FontWeight.w700),
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
