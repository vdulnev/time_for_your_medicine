import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/state/selectors.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../../../l10n/l10n_extensions.dart';

class _KindDisplay {
  const _KindDisplay(this.label, this.icon);
  final String label;
  final IconData icon;
}

_KindDisplay _kindDisplay(String kind, AppLocalizations l10n) => switch (kind) {
  'initial' => _KindDisplay(
    l10n.transactionsKindInitial,
    Icons.inventory_2_outlined,
  ),
  'refill' => _KindDisplay(
    l10n.transactionsKindRefill,
    Icons.add_circle_outline,
  ),
  'take' => _KindDisplay(l10n.transactionsKindTake, Icons.check_circle_outline),
  'revertTake' => _KindDisplay(
    l10n.transactionsKindRevertTake,
    Icons.undo_rounded,
  ),
  _ => _KindDisplay(kind, Icons.receipt_long_outlined),
};

/// A single ledger row: kind, medicine, timestamp, and signed pill delta.
class TransactionTile extends StatelessWidget {
  const TransactionTile({super.key, required this.entry});

  final TransactionEntry entry;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final row = entry.row;
    final display = _kindDisplay(row.kind, l10n);
    final positive = row.delta > 0;
    final deltaColor = positive ? AppColors.success : AppColors.ink2;
    final deltaLabel = positive ? '+${row.delta}' : '${row.delta}';
    final timeLabel = DateFormat.yMMMd(
      context.localeName,
    ).add_jm().format(row.createdAt);

    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppColors.cardShadow,
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.surfaceIndigo,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(display.icon, size: 18, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.medName ?? l10n.transactionsDeletedMedicine,
                  style: AppText.jakarta(size: 13.5, weight: FontWeight.w700),
                ),
                Text(
                  '${display.label} · $timeLabel',
                  style: AppText.jakarta(size: 11, color: AppColors.muted2),
                ),
              ],
            ),
          ),
          Text(
            deltaLabel,
            style: AppText.bricolage(size: 16, color: deltaColor),
          ),
        ],
      ),
    );
  }
}
