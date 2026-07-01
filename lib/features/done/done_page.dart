import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/state/providers.dart';
import '../../core/state/selectors.dart';
import '../../core/state/ui_providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/util/day_utils.dart';
import '../../l10n/l10n_extensions.dart';
import 'widgets/confetti_dot.dart';
import 'widgets/pop_check.dart';

/// The "all doses taken" celebration screen.
@RoutePage()
class DonePage extends ConsumerWidget {
  const DonePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(dataProvider).valueOrNull;
    final iso = ref.watch(selectedDayProvider);
    if (data == null) {
      return const Scaffold(
        backgroundColor: AppColors.primary,
        body: SizedBox.shrink(),
      );
    }

    final cur = DayUtils.parse(iso);
    final total = data.meds.length;
    final streak = Selectors.streak(data, iso);
    final l10n = context.l10n;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SafeArea(
          child: Stack(
            children: [
              const Positioned(
                top: 96,
                left: 42,
                child: ConfettiDot(
                  size: 9,
                  color: Color(0xFFD69A5A),
                  square: true,
                  angle: 20,
                ),
              ),
              const Positioned(
                top: 150,
                right: 48,
                child: ConfettiDot(size: 8, color: Color(0xFF88E0B8)),
              ),
              const Positioned(
                top: 120,
                left: 64,
                child: ConfettiDot(
                  size: 7,
                  color: Colors.white,
                  square: true,
                  angle: 40,
                ),
              ),
              const Positioned(
                top: 130,
                right: 74,
                child: ConfettiDot(size: 6, color: AppColors.primaryFaint),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const PopCheck(),
                      const SizedBox(height: 28),
                      Text(
                        l10n.doneAllDone,
                        style: AppText.bricolage(size: 27, color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.doneBody(
                          DayUtils.dateLabel(cur, context.localeName),
                        ),
                        textAlign: TextAlign.center,
                        style: AppText.jakarta(
                          size: 14,
                          height: 1.5,
                          color: const Color(0xFFD7DAF7),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _StatChip(
                            value: '$total/$total',
                            label: l10n.doneDosesLabel,
                          ),
                          const SizedBox(width: 10),
                          _StatChip(
                            value: '$streak',
                            label: l10n.doneStreakLabel,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 22,
                right: 22,
                bottom: 26,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        ref.read(selectedDayProvider.notifier).shift(1);
                        context.router.popUntilRoot();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          l10n.doneViewTomorrow,
                          style: AppText.bricolage(
                            size: 15,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 9),
                    GestureDetector(
                      onTap: () => context.router.popUntilRoot(),
                      child: SizedBox(
                        width: double.infinity,
                        height: 44,
                        child: Center(
                          child: Text(
                            l10n.doneBackToToday,
                            style: AppText.jakarta(
                              size: 13,
                              weight: FontWeight.w700,
                              color: const Color(0xFFD7DAF7),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(value, style: AppText.bricolage(size: 22, color: Colors.white)),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppText.jakarta(size: 10, color: const Color(0xFFC3C7F4)),
          ),
        ],
      ),
    );
  }
}
