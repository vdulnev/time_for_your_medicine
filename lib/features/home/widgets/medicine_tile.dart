import 'package:flutter/material.dart';

import '../../../core/models/medicine.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/pill_shape.dart';
import '../../../l10n/l10n_extensions.dart';

/// A single medicine row on the Home list, with a tap-to-toggle check.
class MedicineTile extends StatelessWidget {
  const MedicineTile({
    super.key,
    required this.med,
    required this.taken,
    required this.onOpen,
    required this.onToggle,
  });

  final Medicine med;
  final bool taken;
  final VoidCallback onOpen;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
        boxShadow: AppColors.cardShadow,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onOpen,
            child: Container(
              width: 42,
              height: 42,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(med.soft),
                borderRadius: BorderRadius.circular(13),
              ),
              child: PillShape.forMedicine(
                med,
                capsuleWidth: 25,
                capsuleHeight: 13,
                capsuleRadius: 7,
                roundSize: 18,
              ),
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: GestureDetector(
              onTap: onOpen,
              behavior: HitTestBehavior.opaque,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    med.name,
                    style: AppText.jakarta(size: 14, weight: FontWeight.w700),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    context.l10n.medicineDoseAndFood(
                      med.dose,
                      med.withFood
                          ? context.l10n.foodWithFood
                          : context.l10n.foodEmptyStomach,
                    ),
                    style: AppText.jakarta(size: 11.5, color: AppColors.muted2),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          _CheckButton(
            key: ValueKey('toggle-${med.id}'),
            taken: taken,
            onTap: onToggle,
          ),
        ],
      ),
    );
  }
}

class _CheckButton extends StatelessWidget {
  const _CheckButton({super.key, required this.taken, required this.onTap});

  final bool taken;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: taken ? AppColors.primary : Colors.transparent,
          border: taken
              ? null
              : Border.all(color: AppColors.checkBorder, width: 2),
        ),
        child: taken
            ? const Icon(Icons.check_rounded, size: 16, color: Colors.white)
            : null,
      ),
    );
  }
}
