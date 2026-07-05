import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/dose_status.dart';
import '../../core/models/dose_time.dart';
import '../../core/models/medicine.dart';
import '../../core/models/pill_kind.dart';
import '../../core/router/app_router.dart';
import '../../core/state/data_state.dart';
import '../../core/state/providers.dart';
import '../../core/state/selectors.dart';
import '../../core/state/ui_providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/dose_action_sheet.dart';
import '../../core/widgets/pill_shape.dart';
import '../../l10n/l10n_extensions.dart';
import '../shell/delete_sheet.dart';
import 'widgets/detail_week_row.dart';

/// Detail view for a single medicine.
@RoutePage()
class MedicineDetailPage extends ConsumerWidget {
  const MedicineDetailPage({super.key, required this.medId});

  final String medId;

  Future<void> _handleTap(
    BuildContext context,
    WidgetRef ref,
    String medName,
    String iso,
    String doseTimeId,
    DoseStatus current,
    bool canTake,
  ) async {
    final action = await showDoseActionSheet(
      context,
      medName: medName,
      current: current,
      canTake: canTake,
    );
    if (action == null || !context.mounted) return;

    final notifier = ref.read(dataProvider.notifier);
    switch (action) {
      case DoseStatus.taken:
        final completed = await notifier.markTaken(iso, medId, doseTimeId);
        if (completed && context.mounted) {
          context.router.push(const DoneRoute());
        }
      case DoseStatus.rejected:
        await notifier.markRejected(iso, medId, doseTimeId);
      case DoseStatus.pending:
        await notifier.revertDose(iso, medId, doseTimeId);
    }
  }

  Future<void> _delete(BuildContext context, WidgetRef ref, String name) async {
    final confirmed = await showDeleteSheet(context, name);
    if (!confirmed || !context.mounted) return;
    await ref.read(dataProvider.notifier).deleteMedicine(medId);
    if (context.mounted) context.router.maybePop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(dataProvider).valueOrNull;
    final iso = ref.watch(selectedDayProvider);
    final med = data == null ? null : Selectors.medById(data, medId);

    if (data == null || med == null) {
      return const Scaffold(
        backgroundColor: AppColors.primary,
        body: SizedBox.shrink(),
      );
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Column(
          children: [
            _Header(
              med: med,
              onBack: () => context.router.maybePop(),
              onDelete: () => _delete(context, ref, med.name),
            ),
            Expanded(
              child: ColoredBox(
                color: AppColors.screenBg,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
                  children: [
                    _StatsRow(med: med, data: data, iso: iso),
                    const SizedBox(height: 16),
                    Text(
                      context.l10n.detailLast7Days,
                      style: AppText.jakarta(
                        size: 11,
                        weight: FontWeight.w700,
                        color: AppColors.muted,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 9),
                    DetailWeekRow(
                      days: Selectors.detailWeek(
                        data,
                        med,
                        iso,
                        context.localeName,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      context.l10n.detailTodaysDoses,
                      style: AppText.jakarta(
                        size: 11,
                        weight: FontWeight.w700,
                        color: AppColors.muted,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 9),
                    for (final dose in Selectors.medDosesForDay(
                      data,
                      med,
                      iso,
                    )) ...[
                      _ToggleButton(
                        doseTime: dose.doseTime,
                        showTime: med.times.length > 1,
                        status: dose.status,
                        onTap: () => _handleTap(
                          context,
                          ref,
                          med.name,
                          iso,
                          dose.doseTime.id,
                          dose.status,
                          data.supplyOf(med.id) >= 1,
                        ),
                      ),
                      const SizedBox(height: 9),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.med,
    required this.onBack,
    required this.onDelete,
  });

  final Medicine med;
  final VoidCallback onBack;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final kindLabel = med.kind == PillKind.capsule
        ? l10n.kindCapsule
        : l10n.kindTablet;
    return Container(
      width: double.infinity,
      color: AppColors.primary,
      padding: EdgeInsets.fromLTRB(
        20,
        MediaQuery.of(context).padding.top + 8,
        20,
        24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _GlassButton(icon: Icons.chevron_left_rounded, onTap: onBack),
              _GlassButton(icon: Icons.delete_outline_rounded, onTap: onDelete),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Container(
                width: 62,
                height: 62,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: PillShape(
                  kind: med.kind,
                  c1: Colors.white,
                  c2: AppColors.primaryFaint,
                  capsuleWidth: 32,
                  capsuleHeight: 16,
                  capsuleRadius: 9,
                  roundSize: 24,
                ),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    med.name,
                    style: AppText.bricolage(size: 22, color: Colors.white),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    l10n.detailDoseAndKind(med.dose, kindLabel),
                    style: AppText.jakarta(
                      size: 13,
                      color: const Color(0xFFD7DAF7),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GlassButton extends StatelessWidget {
  const _GlassButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, size: 20, color: Colors.white),
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.med, required this.data, required this.iso});

  final Medicine med;
  final DataState data;
  final String iso;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final next = Selectors.nextDoseLabel(data, med, iso);
    return Row(
      children: [
        Expanded(
          child: _StatCard(label: l10n.detailNext, value: next),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: _StatCard(
            label: l10n.detailFood,
            value: med.withFood
                ? l10n.foodWithFoodShort
                : l10n.foodEmptyStomachShort,
          ),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: _StatCard(
            label: l10n.detailLeft,
            value: '${data.supplyOf(med.id)}',
            danger: data.isLowSupply(med.id),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    this.danger = false,
  });

  final String label;
  final String value;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppText.jakarta(size: 9.5, color: AppColors.muted2),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: AppText.bricolage(
              size: 15,
              color: danger ? AppColors.alertInk2 : AppColors.ink,
            ),
          ),
        ],
      ),
    );
  }
}

class _ToggleButton extends StatelessWidget {
  const _ToggleButton({
    required this.doseTime,
    required this.showTime,
    required this.status,
    required this.onTap,
  });

  final DoseTime doseTime;
  final bool showTime;
  final DoseStatus status;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final Color bg;
    final Color fg;
    final String label;
    switch (status) {
      case DoseStatus.pending:
        bg = AppColors.ink;
        fg = Colors.white;
        label = l10n.detailMarkAsTaken;
      case DoseStatus.taken:
        bg = AppColors.successBg;
        fg = AppColors.success;
        label = l10n.detailTakenToday;
      case DoseStatus.rejected:
        bg = AppColors.deleteBg;
        fg = AppColors.danger;
        label = l10n.detailRejectedToday;
    }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          showTime ? '${doseTime.time} · $label' : label,
          style: AppText.bricolage(size: 14, color: fg),
        ),
      ),
    );
  }
}
