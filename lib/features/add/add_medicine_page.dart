import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/period.dart';
import '../../core/state/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import 'add_form_provider.dart';
import 'widgets/photo_placeholder.dart';

/// Form for adding a new medicine.
@RoutePage()
class AddMedicinePage extends ConsumerStatefulWidget {
  const AddMedicinePage({super.key});

  @override
  ConsumerState<AddMedicinePage> createState() => _AddMedicinePageState();
}

class _AddMedicinePageState extends ConsumerState<AddMedicinePage> {
  late final TextEditingController _name = TextEditingController();
  late final TextEditingController _dose = TextEditingController();
  late final TextEditingController _time = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _dose.dispose();
    _time.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final draft = ref.read(addFormProvider);
    await ref.read(dataProvider.notifier).addMedicine(draft);
    if (mounted) context.router.maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final form = ref.read(addFormProvider.notifier);
    final draft = ref.watch(addFormProvider);

    return Scaffold(
      backgroundColor: AppColors.screenBg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 6, 18, 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.router.maybePop(),
                    child: Container(
                      width: 36,
                      height: 36,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.surface2,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.close_rounded,
                        size: 20,
                        color: AppColors.ink2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text('Add medicine', style: AppText.bricolage(size: 19)),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 2, 18, 0),
                children: [
                  const Center(child: PhotoPlaceholder()),
                  const SizedBox(height: 16),
                  const _FieldLabel('MEDICINE NAME'),
                  _Field(
                    controller: _name,
                    hint: 'e.g. Amoxicillin',
                    onChanged: form.setName,
                  ),
                  const SizedBox(height: 14),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const _FieldLabel('DOSE'),
                            _Field(
                              controller: _dose,
                              hint: '500 mg',
                              onChanged: form.setDose,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const _FieldLabel('TIME'),
                            _Field(
                              controller: _time,
                              hint: '8:00 AM',
                              onChanged: form.setTime,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const _FieldLabel('TIME OF DAY'),
                  Row(
                    children: [
                      for (final period in Period.values) ...[
                        Expanded(
                          child: _SegmentButton(
                            label: period.label,
                            selected: draft.period == period,
                            font: AppText.bricolage(
                              size: 12,
                              color: draft.period == period
                                  ? Colors.white
                                  : AppColors.muted2,
                            ),
                            onTap: () => form.setPeriod(period),
                          ),
                        ),
                        if (period != Period.values.last)
                          const SizedBox(width: 7),
                      ],
                    ],
                  ),
                  const SizedBox(height: 14),
                  const _FieldLabel('FOOD'),
                  Row(
                    children: [
                      Expanded(
                        child: _SegmentButton(
                          label: 'With food',
                          selected: draft.withFood,
                          font: AppText.jakarta(
                            size: 12.5,
                            weight: FontWeight.w700,
                            color: draft.withFood
                                ? Colors.white
                                : AppColors.muted,
                          ),
                          onTap: () => form.setFood(true),
                        ),
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        child: _SegmentButton(
                          label: 'Empty stomach',
                          selected: !draft.withFood,
                          font: AppText.jakarta(
                            size: 12.5,
                            weight: FontWeight.w700,
                            color: !draft.withFood
                                ? Colors.white
                                : AppColors.muted,
                          ),
                          onTap: () => form.setFood(false),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                18,
                12,
                18,
                20 + MediaQuery.of(context).padding.bottom,
              ),
              child: GestureDetector(
                onTap: _save,
                child: Container(
                  height: 52,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.6),
                        blurRadius: 22,
                        offset: const Offset(0, 12),
                        spreadRadius: -8,
                      ),
                    ],
                  ),
                  child: Text(
                    'Save medicine',
                    style: AppText.bricolage(size: 15, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
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

class _Field extends StatelessWidget {
  const _Field({
    required this.controller,
    required this.hint,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
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
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
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
