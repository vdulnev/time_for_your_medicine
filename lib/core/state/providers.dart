import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../data/medicine_repository.dart';
import '../db/app_database.dart';
import '../logging/talker.dart';
import '../models/medicine_registry.dart';
import 'data_notifier.dart';
import 'data_state.dart';
import 'medicine_registry_notifier.dart';

/// The drift database. Overridden in `main()` and in tests (in-memory).
final databaseProvider = Provider<AppDatabase>(
  (ref) => throw UnimplementedError('databaseProvider not overridden'),
);

/// Repository over the database, logging through the injected [Talker].
final medicineRepositoryProvider = Provider<MedicineRepository>((ref) {
  return MedicineRepository(
    ref.watch(databaseProvider),
    ref.watch(talkerProvider),
  );
});

/// The single source of truth for persisted domain data.
final dataProvider = AsyncNotifierProvider<DataNotifier, DataState>(
  DataNotifier.new,
);

final medicineRegistryProvider =
    AsyncNotifierProvider<MedicineRegistryNotifier, MedicineRegistryStatus>(
      MedicineRegistryNotifier.new,
    );
