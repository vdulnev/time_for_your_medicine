import 'package:file_selector/file_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/medicine_registry.dart';
import 'providers.dart';

class MedicineRegistryNotifier extends AsyncNotifier<MedicineRegistryStatus> {
  @override
  Future<MedicineRegistryStatus> build() async {
    final result = await ref
        .read(medicineRepositoryProvider)
        .ensureMedicineRegistry();
    return result.getOrElse((failure) => throw failure);
  }

  Future<bool?> importCsv() async {
    const csvFiles = XTypeGroup(
      label: 'CSV',
      extensions: <String>['csv'],
      mimeTypes: <String>['text/csv', 'text/plain'],
      uniformTypeIdentifiers: <String>['public.comma-separated-values-text'],
    );
    final file = await openFile(acceptedTypeGroups: const [csvFiles]);
    if (file == null) return null;

    final previous = state.valueOrNull;
    state = const AsyncLoading();
    final result = await ref
        .read(medicineRepositoryProvider)
        .replaceMedicineRegistryFromCsv(file.openRead(), file.name);
    return result.fold(
      (failure) {
        state = previous == null
            ? AsyncError(failure, StackTrace.current)
            : AsyncData(previous);
        return false;
      },
      (status) {
        state = AsyncData(status);
        return true;
      },
    );
  }
}

final medicineRegistryQueryProvider = StateProvider.autoDispose<String>(
  (ref) => '',
);

final medicineRegistrySearchProvider =
    FutureProvider.autoDispose<List<MedicineRegistryItem>>((ref) async {
      await ref.watch(medicineRegistryProvider.future);
      final query = ref.watch(medicineRegistryQueryProvider);
      final result = await ref
          .read(medicineRepositoryProvider)
          .searchMedicineRegistry(query);
      return result.getOrElse((failure) => throw failure);
    });
