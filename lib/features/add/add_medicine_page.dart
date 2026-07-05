import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/add_draft.dart';
import '../../core/state/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../l10n/l10n_extensions.dart';
import 'add_form_provider.dart';
import 'widgets/medicine_registry_field.dart';
import 'widgets/photo_placeholder.dart';
import 'widgets/time_slot_card.dart';

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
  late final TextEditingController _supply = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _dose.dispose();
    _supply.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final draft = ref.read(addFormProvider);
    await ref.read(dataProvider.notifier).addMedicine(draft);
    if (mounted) context.router.maybePop();
  }

  /// Mirrors the validation `DataNotifier.addMedicine` applies before
  /// saving, so the button can't be tapped into a silent no-op.
  bool _canSave(AddDraft draft) {
    final pills = int.tryParse(draft.supply.trim());
    return draft.name.trim().isNotEmpty && pills != null && pills >= 1;
  }

  @override
  Widget build(BuildContext context) {
    final form = ref.read(addFormProvider.notifier);
    final draft = ref.watch(addFormProvider);
    final canSave = _canSave(draft);
    final l10n = context.l10n;

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
                  Text(l10n.addTitle, style: AppText.bricolage(size: 19)),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 2, 18, 0),
                children: [
                  const Center(child: PhotoPlaceholder()),
                  const SizedBox(height: 16),
                  _FieldLabel(l10n.addMedicineNameLabel, isRequired: true),
                  MedicineRegistryField(
                    controller: _name,
                    hint: l10n.addMedicineNameHint,
                    onNameChanged: form.setName,
                  ),
                  const SizedBox(height: 14),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _FieldLabel(l10n.addDoseLabel),
                            _Field(
                              controller: _dose,
                              hint: l10n.addDoseHint,
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
                            _FieldLabel(l10n.addPillsLabel, isRequired: true),
                            _Field(
                              controller: _supply,
                              hint: l10n.addPillsHint,
                              keyboardType: TextInputType.number,
                              onChanged: form.setSupply,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  for (var i = 0; i < draft.times.length; i++) ...[
                    TimeSlotCard(
                      key: ValueKey('time-slot-$i'),
                      index: i,
                      time: draft.times[i].time,
                      period: draft.times[i].period,
                      removable: draft.times.length > 1,
                      onTimeChanged: (v) => form.setTimeAt(i, v),
                      onPeriodChanged: (p) => form.setPeriodAt(i, p),
                      onRemove: () => form.removeTimeSlotAt(i),
                    ),
                    const SizedBox(height: 10),
                  ],
                  GestureDetector(
                    onTap: form.addTimeSlot,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.add_rounded,
                          size: 18,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          l10n.addAnotherTime,
                          style: AppText.jakarta(
                            size: 12.5,
                            weight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  _FieldLabel(l10n.addFoodLabel),
                  Row(
                    children: [
                      Expanded(
                        child: _SegmentButton(
                          label: l10n.foodWithFoodButton,
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
                          label: l10n.foodEmptyStomachButton,
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!canSave) ...[
                    Text(
                      l10n.addSaveRequirementsHint,
                      textAlign: TextAlign.center,
                      style: AppText.jakarta(
                        size: 11.5,
                        weight: FontWeight.w600,
                        color: AppColors.muted,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  GestureDetector(
                    onTap: canSave ? _save : null,
                    child: Container(
                      height: 52,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: canSave ? AppColors.primary : AppColors.muted3,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: canSave
                            ? [
                                BoxShadow(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.6,
                                  ),
                                  blurRadius: 22,
                                  offset: const Offset(0, 12),
                                  spreadRadius: -8,
                                ),
                              ]
                            : null,
                      ),
                      child: Text(
                        l10n.addSaveButton,
                        style: AppText.bricolage(size: 15, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text, {this.isRequired = false});

  final String text;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    final style = AppText.jakarta(
      size: 11,
      weight: FontWeight.w700,
      color: AppColors.muted,
      letterSpacing: 0.5,
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: isRequired
          ? RichText(
              text: TextSpan(
                style: style,
                children: [
                  TextSpan(text: text),
                  TextSpan(
                    text: ' *',
                    style: style.copyWith(color: AppColors.danger),
                  ),
                ],
              ),
            )
          : Text(text, style: style),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.controller,
    required this.hint,
    required this.onChanged,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: keyboardType,
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
