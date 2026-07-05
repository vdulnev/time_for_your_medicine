import 'package:flutter/material.dart';

import '../../../core/models/period.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../l10n/l10n_extensions.dart';

/// One editable dose-time row: a time field, a period segmented control,
/// and (when [removable]) a remove button — used by both the Add-medicine
/// form and the Edit Reminder screen's "add a new time" section.
class TimeSlotCard extends StatelessWidget {
  const TimeSlotCard({
    super.key,
    required this.index,
    required this.time,
    required this.period,
    required this.removable,
    required this.onTimeChanged,
    required this.onPeriodChanged,
    required this.onRemove,
  });

  final int index;
  final String time;
  final Period period;
  final bool removable;
  final ValueChanged<String> onTimeChanged;
  final ValueChanged<Period> onPeriodChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.all(12),
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
              Expanded(child: _FieldLabel(l10n.addTimeLabel)),
              if (removable)
                GestureDetector(
                  onTap: onRemove,
                  child: const Icon(
                    Icons.close_rounded,
                    size: 18,
                    color: AppColors.muted2,
                  ),
                ),
            ],
          ),
          TextFormField(
            key: ValueKey('time-field-$index'),
            initialValue: time,
            onChanged: onTimeChanged,
            style: AppText.jakarta(size: 14, weight: FontWeight.w700),
            cursorColor: AppColors.primary,
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: AppColors.surface,
              hintText: l10n.addTimeHint,
              hintStyle: AppText.jakarta(
                size: 14,
                weight: FontWeight.w700,
                color: AppColors.muted2,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 10),
          _FieldLabel(l10n.addTimeOfDayLabel),
          Row(
            children: [
              for (final p in Period.values) ...[
                Expanded(
                  child: _SegmentButton(
                    label: p.label(l10n),
                    selected: period == p,
                    font: AppText.bricolage(
                      size: 12,
                      color: period == p ? Colors.white : AppColors.muted2,
                    ),
                    onTap: () => onPeriodChanged(p),
                  ),
                ),
                if (p != Period.values.last) const SizedBox(width: 7),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: AppText.jakarta(
          size: 11,
          weight: FontWeight.w700,
          color: AppColors.muted,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _SegmentButton extends StatelessWidget {
  const _SegmentButton({
    required this.label,
    required this.selected,
    required this.font,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final TextStyle font;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 11),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Text(label, style: font),
      ),
    );
  }
}
