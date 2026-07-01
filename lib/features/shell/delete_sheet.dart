import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// Shows the "Delete reminder?" confirmation sheet. Resolves to `true` when
/// the user confirms deletion.
Future<bool> showDeleteSheet(BuildContext context, String medName) async {
  final result = await showModalBottomSheet<bool>(
    context: context,
    backgroundColor: Colors.transparent,
    barrierColor: const Color(0x7328253D),
    builder: (context) => _DeleteSheet(medName: medName),
  );
  return result ?? false;
}

class _DeleteSheet extends StatelessWidget {
  const _DeleteSheet({required this.medName});

  final String medName;

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.deleteBg,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.delete_outline_rounded,
                  color: AppColors.danger,
                  size: 24,
                ),
              ),
              const SizedBox(height: 14),
              Text('Delete reminder?', style: AppText.bricolage(size: 18)),
              const SizedBox(height: 6),
              Text(
                '$medName and its schedule will be removed. '
                'This can’t be undone.',
                textAlign: TextAlign.center,
                style: AppText.jakarta(
                  size: 13,
                  color: AppColors.muted,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: _SheetButton(
                      label: 'Cancel',
                      background: AppColors.surface2,
                      foreground: AppColors.ink2,
                      onTap: () => Navigator.of(context).pop(false),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _SheetButton(
                      label: 'Delete',
                      background: AppColors.danger,
                      foreground: Colors.white,
                      onTap: () => Navigator.of(context).pop(true),
                    ),
                  ),
                ],
              ),
            ],
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
