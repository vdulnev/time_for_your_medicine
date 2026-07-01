import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/medicine_registry.dart';
import '../../../core/state/medicine_registry_notifier.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../l10n/l10n_extensions.dart';

class MedicineRegistryField extends ConsumerWidget {
  const MedicineRegistryField({
    required this.controller,
    required this.hint,
    required this.onNameChanged,
    super.key,
  });

  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onNameChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(medicineRegistryQueryProvider);
    final results = ref.watch(medicineRegistrySearchProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          onChanged: (value) {
            onNameChanged(value);
            ref.read(medicineRegistryQueryProvider.notifier).state = value;
          },
          style: AppText.jakarta(size: 14, weight: FontWeight.w700),
          cursorColor: AppColors.primary,
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: AppColors.surface,
            hintText: hint,
            hintStyle: AppText.jakarta(
              size: 14,
              weight: FontWeight.w700,
              color: AppColors.muted2,
            ),
            suffixIcon: const Icon(
              Icons.search_rounded,
              color: AppColors.muted2,
              size: 20,
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
        if (query.trim().length >= 2) ...[
          const SizedBox(height: 6),
          _SearchResults(
            results: results,
            onSelect: (item) {
              controller.text = item.name;
              controller.selection = TextSelection.collapsed(
                offset: controller.text.length,
              );
              onNameChanged(item.name);
              ref.read(medicineRegistryQueryProvider.notifier).state = '';
            },
          ),
        ],
      ],
    );
  }
}

class _SearchResults extends StatelessWidget {
  const _SearchResults({required this.results, required this.onSelect});

  final AsyncValue<List<MedicineRegistryItem>> results;
  final ValueChanged<MedicineRegistryItem> onSelect;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      constraints: const BoxConstraints(maxHeight: 230),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        boxShadow: AppColors.cardShadow,
      ),
      clipBehavior: Clip.antiAlias,
      child: results.when(
        loading: () => const SizedBox(
          height: 52,
          child: Center(
            child: SizedBox.square(
              dimension: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        ),
        error: (_, _) => _Message(text: l10n.registrySearchFailed),
        data: (items) => items.isEmpty
            ? _Message(text: l10n.registryNoResults)
            : ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: items.length,
                separatorBuilder: (_, _) => const Divider(
                  height: 1,
                  indent: 14,
                  endIndent: 14,
                  color: AppColors.divider,
                ),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return InkWell(
                    onTap: () => onSelect(item),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppText.jakarta(
                              size: 13,
                              weight: FontWeight.w700,
                            ),
                          ),
                          if (item.genericName.isNotEmpty ||
                              item.form.isNotEmpty)
                            Text(
                              [
                                if (item.genericName.isNotEmpty)
                                  item.genericName,
                                if (item.form.isNotEmpty) item.form,
                              ].join(' · '),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppText.jakarta(
                                size: 10.5,
                                color: AppColors.muted,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Text(
        text,
        style: AppText.jakarta(size: 11.5, color: AppColors.muted),
      ),
    );
  }
}
