import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../data/medicine_repository.dart';
import '../db/app_database.dart';
import '../logging/talker.dart';
import '../models/medicine_registry.dart';
import 'data_notifier.dart';
import 'data_state.dart';
import 'medicine_registry_notifier.dart';
import 'selectors.dart' show TransactionInterval;

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

/// The supply-transaction ledger, reloaded whenever [dataProvider] changes
/// (every mutation that touches supply — take/revert/refill/add — updates
/// `DataState`, which this watches to know when to refetch).
final transactionsProvider =
    FutureProvider.autoDispose<List<SupplyTransactionRow>>((ref) async {
      ref.watch(dataProvider);
      final result = await ref
          .read(medicineRepositoryProvider)
          .loadTransactions();
      return result.getOrElse((failure) => throw failure);
    });

/// Transactions-screen filter: which medicine (`null` = all) and which
/// trailing date interval to show. UI-only, not persisted.
typedef TransactionFilter = ({String? medId, TransactionInterval interval});

class TransactionFilterNotifier extends Notifier<TransactionFilter> {
  @override
  TransactionFilter build() => (medId: null, interval: TransactionInterval.all);

  void setMedId(String? medId) =>
      state = (medId: medId, interval: state.interval);

  void setInterval(TransactionInterval interval) =>
      state = (medId: state.medId, interval: interval);
}

final transactionFilterProvider =
    NotifierProvider<TransactionFilterNotifier, TransactionFilter>(
      TransactionFilterNotifier.new,
    );
