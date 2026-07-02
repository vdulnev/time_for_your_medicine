import 'package:flutter/material.dart';

import '../../../core/models/dose_status.dart';
import '../../../core/models/dose_time.dart';
import '../../../core/models/medicine.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/pill_shape.dart';
import '../../../l10n/l10n_extensions.dart';

/// A single medicine row on the Home list, with a tap-to-confirm check.
/// One row per scheduled [doseTime] — a medicine taken several times a day
/// appears once per slot.
class MedicineTile extends StatelessWidget {
  const MedicineTile({
    super.key,
    required this.med,
    required this.doseTime,
    required this.showTime,
    required this.status,
    required this.onOpen,
    required this.onTap,
  });

  final Medicine med;
  final DoseTime doseTime;

  /// Whether to show this slot's time next to the name, to disambiguate
  /// medicines with more than one dose slot per day.
  final bool showTime;
  final DoseStatus status;
  final VoidCallback onOpen;
  final VoidCallback onTap;

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
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          med.name,
                          overflow: TextOverflow.ellipsis,
                          style: AppText.jakarta(
                            size: 14,
                            weight: FontWeight.w700,
                          ),
                        ),
                      ),
                      if (showTime) ...[
                        const SizedBox(width: 6),
                        Text(
                          doseTime.time,
                          style: AppText.jakarta(
                            size: 11,
                            weight: FontWeight.w600,
                            color: AppColors.muted2,
                          ),
                        ),
                      ],
                    ],
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
            key: ValueKey('toggle-${med.id}-${doseTime.id}'),
            status: status,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}

class _CheckButton extends StatelessWidget {
  const _CheckButton({super.key, required this.status, required this.onTap});

  final DoseStatus status;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color bg;
    final Border? border;
    final IconData? icon;
    switch (status) {
      case DoseStatus.pending:
        bg = Colors.transparent;
        border = Border.all(color: AppColors.checkBorder, width: 2);
        icon = null;
      case DoseStatus.taken:
        bg = AppColors.primary;
        border = null;
        icon = Icons.check_rounded;
      case DoseStatus.rejected:
        bg = AppColors.danger;
        border = null;
        icon = Icons.close_rounded;
    }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bg,
          border: border,
        ),
        child: icon == null ? null : Icon(icon, size: 16, color: Colors.white),
      ),
    );
  }
}
