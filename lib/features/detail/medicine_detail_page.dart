import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/medicine.dart';
import '../../core/models/pill_kind.dart';
import '../../core/router/app_router.dart';
import '../../core/state/providers.dart';
import '../../core/state/selectors.dart';
import '../../core/state/ui_providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/pill_shape.dart';
import '../shell/delete_sheet.dart';
import 'widgets/detail_week_row.dart';

/// Detail view for a single medicine.
@RoutePage()
class MedicineDetailPage extends ConsumerWidget {
  const MedicineDetailPage({super.key, required this.medId});

  final String medId;

  Future<void> _toggle(BuildContext context, WidgetRef ref, String iso) async {
    final completed = await ref
        .read(dataProvider.notifier)
        .toggleTaken(iso, medId);
    if (completed && context.mounted) {
      context.router.push(const DoneRoute());
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

    final taken = data.isTaken(iso, med.id);

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
                    _StatsRow(med: med),
                    const SizedBox(height: 16),
                    Text(
                      'LAST 7 DAYS',
                      style: AppText.jakarta(
                        size: 11,
                        weight: FontWeight.w700,
                        color: AppColors.muted,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 9),
                    DetailWeekRow(days: Selectors.detailWeek(data, med, iso)),
                    const SizedBox(height: 16),
                    _ToggleButton(
                      taken: taken,
                      onTap: () => _toggle(context, ref, iso),
                    ),
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
    final kindLabel = med.kind == PillKind.capsule ? 'capsule' : 'tablet';
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
                    '${med.dose} $kindLabel',
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
  const _StatsRow({required this.med});

  final Medicine med;

  @override
  Widget build(BuildContext context) {
    final time = med.time.replaceAll(' AM', '').replaceAll(' PM', '');
    return Row(
      children: [
        Expanded(
          child: _StatCard(label: 'NEXT', value: time),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: _StatCard(
            label: 'FOOD',
            value: med.withFood ? 'With' : 'Empty',
          ),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: _StatCard(
            label: 'LEFT',
            value: '${med.supply}',
            danger: med.isLowSupply,
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
  const _ToggleButton({required this.taken, required this.onTap});

  final bool taken;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: taken ? AppColors.successBg : AppColors.ink,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          taken ? 'Taken today ✓' : 'Mark as taken',
          style: AppText.bricolage(
            size: 14,
            color: taken ? AppColors.success : Colors.white,
          ),
        ),
      ),
    );
  }
}
