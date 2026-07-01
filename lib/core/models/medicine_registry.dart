import 'package:freezed_annotation/freezed_annotation.dart';

part 'medicine_registry.freezed.dart';

@freezed
abstract class MedicineRegistryItem with _$MedicineRegistryItem {
  const factory MedicineRegistryItem({
    required String name,
    required String genericName,
    required String form,
  }) = _MedicineRegistryItem;
}

@freezed
abstract class MedicineRegistryStatus with _$MedicineRegistryStatus {
  const factory MedicineRegistryStatus({
    required String sourceName,
    required DateTime importedAt,
    required int entryCount,
  }) = _MedicineRegistryStatus;
}
