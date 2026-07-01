import 'package:flutter/material.dart';

import '../../../core/state/selectors.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/util/day_utils.dart';
import '../../../l10n/l10n_extensions.dart';

/// The month day-grid with weekday headers, selection, today, and dots.
class MonthGrid extends StatelessWidget {
  const MonthGrid({super.key, required this.cells, required this.onSelect});

  final List<CalCell> cells;
  final ValueChanged<String> onSelect;

  /// A known Monday, used only to derive locale-correct weekday-header
  /// glyphs in Mon…Sun order.
  static final DateTime _refMonday = DateTime(2024, 1, 1);

  @override
  Widget build(BuildContext context) {
    final locale = context.localeName;
    final dow = [
      for (var i = 0; i < 7; i++)
        DayUtils.dowNarrow(DayUtils.addDays(_refMonday, i), locale),
    ];
    return Column(
      children: [
        Row(
          children: [
            for (final d in dow)
              Expanded(
                child: Center(
                  child: Text(
                    d,
                    style: AppText.jakarta(
                      size: 10,
                      weight: FontWeight.w700,
                      color: AppColors.muted2,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisExtent: 42,
          ),
          itemCount: cells.length,
          itemBuilder: (context, index) =>
              _Cell(cell: cells[index], onSelect: onSelect),
        ),
      ],
    );
  }
}

class _Cell extends StatelessWidget {
  const _Cell({required this.cell, required this.onSelect});

  final CalCell cell;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    if (cell.blank) return const SizedBox.shrink();

    final numColor = cell.isToday ? AppColors.primary : AppColors.ink;
    return GestureDetector(
      onTap: () => onSelect(cell.iso),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: cell.selected ? AppColors.primary : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Text(
              '${cell.day}',
              style: AppText.bricolage(
                size: 13,
                weight: cell.selected ? FontWeight.w800 : FontWeight.w700,
                color: cell.selected ? Colors.white : numColor,
              ),
            ),
          ),
          const SizedBox(height: 2),
          SizedBox(
            height: 5,
            child: cell.showDot
                ? Container(
                    width: 5,
                    height: 5,
                    decoration: const BoxDecoration(
                      color: Color(0xFFC9CEF1),
                      shape: BoxShape.circle,
                    ),
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
