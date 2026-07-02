import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/pill_kind.dart';
import '../../../core/state/providers.dart';
import '../../../core/state/selectors.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/pill_shape.dart';
import '../../../l10n/l10n_extensions.dart';
import 'refill_sheet.dart';

/// A single medicine's supply row with a progress bar and a refill button.
class RefillTile extends ConsumerWidget {
  const RefillTile({super.key, required this.item});

  final RefillItem item;

  Future<void> _refill(BuildContext context, WidgetRef ref) async {
    final newSupply = await showRefillSheet(context, item.med);
    if (newSupply == null) return;
    await ref
        .read(dataProvider.notifier)
        .refillMedicine(item.med.id, newSupply);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final med = item.med;
    final l10n = context.l10n;
    final countLabel = med.kind == PillKind.capsule
        ? l10n.refillsCapsulesLeft(med.supply)
        : l10n.refillsTabletsLeft(med.supply);
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(med.soft),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: PillShape.forMedicine(
                  med,
                  capsuleWidth: 20,
                  capsuleHeight: 11,
                  capsuleRadius: 6,
                  roundSize: 15,
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      med.name,
                      style: AppText.jakarta(
                        size: 13.5,
                        weight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      countLabel,
                      style: AppText.jakarta(
                        size: 11.5,
                        weight: FontWeight.w600,
                        color: item.low
                            ? AppColors.alertInk2
                            : AppColors.muted2,
                      ),
                    ),
                  ],
                ),
              ),
              _OrderButton(low: item.low, onTap: () => _refill(context, ref)),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: SizedBox(
              height: 7,
              child: Stack(
                children: [
                  const ColoredBox(color: AppColors.track),
                  FractionallySizedBox(
                    widthFactor: item.pct / 100,
                    child: ColoredBox(
                      color: item.low ? AppColors.alertBar : AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderButton extends StatelessWidget {
  const _OrderButton({required this.low, required this.onTap});

  final bool low;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: low ? AppColors.primary : AppColors.successBg,
          borderRadius: BorderRadius.circular(11),
        ),
        child: Text(
          low ? context.l10n.refillsOrder : context.l10n.ok,
          style: AppText.jakarta(
            size: 12,
            weight: FontWeight.w700,
            color: low ? Colors.white : AppColors.success,
          ),
        ),
      ),
    );
  }
}
