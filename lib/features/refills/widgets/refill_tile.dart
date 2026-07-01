import 'package:flutter/material.dart';

import '../../../core/state/selectors.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/pill_shape.dart';

/// A single medicine's supply row with a progress bar and order button.
class RefillTile extends StatelessWidget {
  const RefillTile({super.key, required this.item});

  final RefillItem item;

  @override
  Widget build(BuildContext context) {
    final med = item.med;
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
                      item.countLabel,
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
              _OrderButton(low: item.low),
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
  const _OrderButton({required this.low});

  final bool low;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: low ? AppColors.primary : AppColors.successBg,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Text(
        low ? 'Order' : 'OK',
        style: AppText.jakarta(
          size: 12,
          weight: FontWeight.w700,
          color: low ? Colors.white : AppColors.success,
        ),
      ),
    );
  }
}
