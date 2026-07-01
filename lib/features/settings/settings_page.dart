import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/router/app_router.dart';
import '../../core/state/data_state.dart';
import '../../core/state/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/error_view.dart';
import '../../l10n/l10n_extensions.dart';
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
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 6, 18, 8),
          child: Text(l10n.settingsTitle, style: AppText.bricolage(size: 22)),
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
                          l10n.settingsActiveMedicines(data.meds.length),
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
              _SectionLabel(l10n.settingsPreferences),
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
                      label: l10n.settingsReminderSound,
                      on: settings.sound,
                      onToggle: () => controller.toggleSetting('sound'),
                      showDivider: true,
                    ),
                    _PreferenceRow(
                      label: l10n.settingsVibration,
                      on: settings.vibrate,
                      onToggle: () => controller.toggleSetting('vibrate'),
                      showDivider: true,
                    ),
                    _PreferenceRow(
                      label: l10n.settingsRefillAlerts,
                      on: settings.refill,
                      onToggle: () => controller.toggleSetting('refill'),
                      showDivider: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              _SectionLabel(l10n.settingsLanguage),
              _LanguageSelector(
                current: settings.localeOverride,
                onSelect: controller.setLocaleOverride,
              ),
              const SizedBox(height: 14),
              _SectionLabel(l10n.settingsMedicineRegistry),
              const _MedicineRegistryCard(),
              const SizedBox(height: 14),
              _SectionLabel(l10n.settingsMore),
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
                      label: l10n.settingsHistoryAndAdherence,
                      onTap: () => context.router.push(const HistoryRoute()),
                      showDivider: true,
                    ),
                    _NavRow(
                      label: l10n.navRefills,
                      onTap: () => context.tabsRouter.setActiveIndex(2),
                      showDivider: true,
                    ),
                    _NavRow(
                      label: l10n.navReminders,
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

class _MedicineRegistryCard extends ConsumerWidget {
  const _MedicineRegistryCard();

  Future<void> _import(BuildContext context, WidgetRef ref) async {
    final imported = await ref
        .read(medicineRegistryProvider.notifier)
        .importCsv();
    if (!context.mounted) return;
    if (imported == null) return;
    final l10n = context.l10n;
    final status = ref.read(medicineRegistryProvider).valueOrNull;
    final message = imported && status != null
        ? l10n.registryImportSuccess(status.entryCount)
        : l10n.registryImportFailed;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registry = ref.watch(medicineRegistryProvider);
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppColors.cardShadow,
      ),
      child: Row(
        children: [
          const Icon(
            Icons.medication_outlined,
            color: AppColors.primary,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.registryTitle,
                  style: AppText.jakarta(size: 13.5, weight: FontWeight.w700),
                ),
                registry.when(
                  loading: () => Text(
                    l10n.registryPreparing,
                    style: AppText.jakarta(size: 10.5, color: AppColors.muted2),
                  ),
                  error: (_, _) => Text(
                    l10n.registryImportFailed,
                    style: AppText.jakarta(size: 10.5, color: AppColors.danger),
                  ),
                  data: (status) => Text(
                    '${l10n.registryEntryCount(status.entryCount)} · '
                    '${status.sourceName}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.jakarta(size: 10.5, color: AppColors.muted2),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: registry.isLoading ? null : () => _import(context, ref),
            child: Text(l10n.registryImportButton),
          ),
        ],
      ),
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

class _LanguageSelector extends StatelessWidget {
  const _LanguageSelector({required this.current, required this.onSelect});

  /// The persisted override ("en" / "uk"), or null for "System".
  final String? current;
  final ValueChanged<String?> onSelect;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final options = <(String?, String)>[
      (null, l10n.settingsLanguageSystem),
      ('en', l10n.settingsLanguageEnglish),
      ('uk', l10n.settingsLanguageUkrainian),
    ];
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppColors.cardShadow,
      ),
      child: Row(
        children: [
          for (final (code, label) in options) ...[
            Expanded(
              child: _LanguageOption(
                label: label,
                selected: current == code,
                onTap: () => onSelect(code),
              ),
            ),
            if (code != options.last.$1) const SizedBox(width: 4),
          ],
        ],
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 11),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Text(
          label,
          style: AppText.jakarta(
            size: 12.5,
            weight: FontWeight.w700,
            color: selected ? Colors.white : AppColors.muted,
          ),
        ),
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
