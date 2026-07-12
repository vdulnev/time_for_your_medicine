import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:time_for_your_medicine/core/db/app_database.dart';
import 'package:time_for_your_medicine/core/logging/talker.dart';
import 'package:time_for_your_medicine/core/notifications/notification_service.dart';
import 'package:time_for_your_medicine/core/state/data_state.dart';
import 'package:time_for_your_medicine/core/state/providers.dart';
import 'package:time_for_your_medicine/core/util/day_utils.dart';

import 'support/fixed_clock.dart';
import 'support/seed_test_data.dart';

/// Every mutation that changes what or when to notify must re-sync the OS
/// notification schedule. The default provider binding is a no-op (so the
/// rest of the suite never touches platform channels); this test swaps in
/// a recording fake to prove DataNotifier actually calls through.
class _RecordingNotificationService implements NotificationService {
  final List<DataState> syncs = [];

  @override
  Future<void> init() async {}

  @override
  Future<void> sync(DataState data) async => syncs.add(data);
}

void main() {
  test('dose, medicine, reminder, and settings mutations re-sync '
      'notifications with the post-mutation state', () async {
    await withFixedToday(() async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      await seedTestMedicines(db);

      final service = _RecordingNotificationService();
      final container = ProviderContainer(
        overrides: [
          databaseProvider.overrideWithValue(db),
          talkerProvider.overrideWithValue(Talker()),
          notificationServiceProvider.overrideWithValue(service),
        ],
      );
      addTearDown(container.dispose);

      await container.read(dataProvider.future);
      final notifier = container.read(dataProvider.notifier);
      final iso = DayUtils.iso(kToday);

      expect(service.syncs, isEmpty); // loading alone doesn't sync

      await notifier.markTaken(iso, 'm2', 't1');
      expect(service.syncs, hasLength(1));
      expect(
        service.syncs.last.isTaken(iso, 'm2', 't1'),
        isTrue,
        reason: 'sync must see the post-mutation state',
      );

      await notifier.revertDose(iso, 'm2', 't1');
      expect(service.syncs, hasLength(2));

      await notifier.toggleNotif('m3');
      expect(service.syncs, hasLength(3));
      expect(service.syncs.last.reminderOn('m3'), isFalse);

      await notifier.toggleSetting('sound');
      expect(service.syncs, hasLength(4));

      await notifier.deleteMedicine('m4');
      expect(service.syncs, hasLength(5));
      expect(service.syncs.last.meds.map((m) => m.id), isNot(contains('m4')));
    });
  });
}
