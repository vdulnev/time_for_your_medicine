import 'package:flutter/material.dart';

import '../../../core/models/medicine.dart';
import '../../../core/state/selectors.dart' show TransactionInterval;
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../../../l10n/l10n_extensions.dart';

/// Medicine dropdown + interval-preset segmented control for the
/// transactions screen.
class TransactionFilterBar extends StatelessWidget {
  const TransactionFilterBar({
    super.key,
    required this.meds,
    required this.medId,
    required this.interval,
    required this.onMedIdChanged,
    required this.onIntervalChanged,
  });

  final List<Medicine> meds;
  final String? medId;
  final TransactionInterval interval;
  final ValueChanged<String?> onMedIdChanged;
  final ValueChanged<TransactionInterval> onIntervalChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(16),
            boxShadow: AppColors.cardShadow,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String?>(
              value: medId,
              isExpanded: true,
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.muted2,
              ),
              style: AppText.jakarta(size: 13.5, weight: FontWeight.w700),
              items: [
                DropdownMenuItem(
                  value: null,
                  child: Text(l10n.transactionsAllMedicines),
                ),
                for (final m in meds)
                  DropdownMenuItem(value: m.id, child: Text(m.name)),
              ],
              onChanged: onMedIdChanged,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(16),
            boxShadow: AppColors.cardShadow,
          ),
          child: Row(
            children: [
              for (final option in TransactionInterval.values) ...[
                Expanded(
                  child: _IntervalOption(
                    label: _label(option, l10n),
                    selected: option == interval,
                    onTap: () => onIntervalChanged(option),
                  ),
                ),
                if (option != TransactionInterval.values.last)
                  const SizedBox(width: 4),
              ],
            ],
          ),
        ),
      ],
    );
  }

  String _label(TransactionInterval option, AppLocalizations l10n) =>
      switch (option) {
        TransactionInterval.all => l10n.transactionsIntervalAll,
        TransactionInterval.last7Days => l10n.transactionsInterval7Days,
        TransactionInterval.last30Days => l10n.transactionsInterval30Days,
        TransactionInterval.last90Days => l10n.transactionsInterval90Days,
      };
}

class _IntervalOption extends StatelessWidget {
  const _IntervalOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 11),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Text(
          label,
          style: AppText.jakarta(
            size: 12,
            weight: FontWeight.w700,
            color: selected ? Colors.white : AppColors.muted,
          ),
        ),
      ),
    );
  }
}
