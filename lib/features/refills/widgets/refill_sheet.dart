import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/models/medicine.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../l10n/l10n_extensions.dart';

/// Shows the "Refill {name}?" sheet. Resolves to the new pill count the
/// user entered, or `null` if they cancelled / left it invalid.
Future<int?> showRefillSheet(
  BuildContext context,
  Medicine med,
  int currentSupply,
) {
  return showModalBottomSheet<int>(
    context: context,
    backgroundColor: Colors.transparent,
    barrierColor: const Color(0x7328253D),
    isScrollControlled: true,
    builder: (context) => _RefillSheet(med: med, currentSupply: currentSupply),
  );
}

class _RefillSheet extends StatefulWidget {
  const _RefillSheet({required this.med, required this.currentSupply});

  final Medicine med;
  final int currentSupply;

  @override
  State<_RefillSheet> createState() => _RefillSheetState();
}

class _RefillSheetState extends State<_RefillSheet> {
  late final TextEditingController _controller = TextEditingController(
    text: '${widget.currentSupply}',
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _confirm() {
    final value = int.tryParse(_controller.text.trim());
    Navigator.of(context).pop(value != null && value > 0 ? value : null);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
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
                    color: AppColors.surfaceIndigo,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(
                    Icons.medication_liquid_outlined,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  l10n.refillSheetTitle(widget.med.name),
                  style: AppText.bricolage(size: 18),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.refillSheetBody,
                  textAlign: TextAlign.center,
                  style: AppText.jakarta(size: 13, color: AppColors.muted),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _controller,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textAlign: TextAlign.center,
                  onSubmitted: (_) => _confirm(),
                  style: AppText.bricolage(size: 22),
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: AppColors.surface,
                    hintText: l10n.addPillsHint,
                    hintStyle: AppText.bricolage(
                      size: 22,
                      color: AppColors.muted2,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
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
                        label: l10n.refillSheetConfirm,
                        background: AppColors.primary,
                        foreground: Colors.white,
                        onTap: _confirm,
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
