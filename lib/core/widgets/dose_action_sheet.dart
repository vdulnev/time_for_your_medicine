import 'package:flutter/material.dart';

import '../../l10n/l10n_extensions.dart';
import '../models/dose_status.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Shows the dose confirmation sheet for [medName]. Resolves to the
/// [DoseStatus] the user chose ([DoseStatus.pending] means "undo"), or
/// `null` if they cancelled. [canTake] hides "Mark as taken" when the
/// medicine has no pills left.
Future<DoseStatus?> showDoseActionSheet(
  BuildContext context, {
  required String medName,
  required DoseStatus current,
  required bool canTake,
}) {
  return showModalBottomSheet<DoseStatus>(
    context: context,
    backgroundColor: Colors.transparent,
    barrierColor: const Color(0x7328253D),
    builder: (context) =>
        _DoseActionSheet(medName: medName, current: current, canTake: canTake),
  );
}

class _DoseActionSheet extends StatelessWidget {
  const _DoseActionSheet({
    required this.medName,
    required this.current,
    required this.canTake,
  });

  final String medName;
  final DoseStatus current;
  final bool canTake;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final (iconBg, icon, iconColor, body) = switch (current) {
      DoseStatus.pending => (
        AppColors.surfaceIndigo,
        Icons.medication_liquid_outlined,
        AppColors.primary,
        canTake ? l10n.doseSheetQuestion : l10n.doseSheetOutOfStock,
      ),
      DoseStatus.taken => (
        AppColors.successBg,
        Icons.check_rounded,
        AppColors.success,
        l10n.doseSheetTakenBody,
      ),
      DoseStatus.rejected => (
        AppColors.deleteBg,
        Icons.close_rounded,
        AppColors.danger,
        l10n.doseSheetRejectedBody,
      ),
    };

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 18),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(24),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(icon, color: iconColor, size: 24),
                ),
                const SizedBox(height: 14),
                Text(medName, style: AppText.bricolage(size: 18)),
                const SizedBox(height: 6),
                Text(
                  body,
                  textAlign: TextAlign.center,
                  style: AppText.jakarta(size: 13, color: AppColors.muted),
                ),
                const SizedBox(height: 18),
                if (current == DoseStatus.pending) ...[
                  if (canTake) ...[
                    _SheetButton(
                      label: l10n.detailMarkAsTaken,
                      background: AppColors.success,
                      foreground: Colors.white,
                      onTap: () => Navigator.of(context).pop(DoseStatus.taken),
                    ),
                    const SizedBox(height: 10),
                  ],
                  _SheetButton(
                    label: l10n.doseSheetMarkRejected,
                    background: AppColors.danger,
                    foreground: Colors.white,
                    onTap: () => Navigator.of(context).pop(DoseStatus.rejected),
                  ),
                  const SizedBox(height: 10),
                  _SheetButton(
                    label: l10n.cancel,
                    background: AppColors.surface2,
                    foreground: AppColors.ink2,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ] else
                  Row(
                    children: [
                      Expanded(
                        child: _SheetButton(
                          label: l10n.cancel,
                          background: AppColors.surface2,
                          foreground: AppColors.ink2,
                          onTap: () => Navigator.of(context).pop(),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _SheetButton(
                          label: l10n.doseSheetUndo,
                          background: AppColors.primary,
                          foreground: Colors.white,
                          onTap: () =>
                              Navigator.of(context).pop(DoseStatus.pending),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SheetButton extends StatelessWidget {
  const _SheetButton({
    required this.label,
    required this.background,
    required this.foreground,
    required this.onTap,
  });

  final String label;
  final Color background;
  final Color foreground;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          label,
          style: AppText.bricolage(size: 14, color: foreground),
        ),
      ),
    );
  }
}
