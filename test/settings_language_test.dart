import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:time_for_your_medicine/app.dart';
import 'package:time_for_your_medicine/core/db/app_database.dart';
import 'package:time_for_your_medicine/core/logging/talker.dart';
import 'package:time_for_your_medicine/core/state/providers.dart';

import 'support/fixed_clock.dart';
import 'support/seed_test_data.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  testWidgets('picking Ukrainian in Settings re-localizes the whole app live, '
      'and picking System reverts it — with no manual locale: override', (
    tester,
  ) async {
    await withFixedToday(() async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      await seedTestMedicines(db);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            talkerProvider.overrideWithValue(Talker()),
            databaseProvider.overrideWithValue(db),
          ],
          child: const PillnoteApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Starts in English (device/test-harness locale is 'en').
      expect(find.text('Morning'), findsOneWidget);

      // Navigate to Settings via the bottom nav (rightmost tab).
      await tester.tap(find.byIcon(Icons.tune_rounded));
      await tester.pumpAndSettle();
      expect(find.text('Settings'), findsOneWidget);

      // Tap "Українська" — the app should re-localize immediately, without
      // a restart and without any manual `locale:` override in test code.
      await tester.tap(find.text('Українська'));
      await tester.pumpAndSettle();

      expect(find.text('Налаштування'), findsOneWidget);
      expect(find.text('Settings'), findsNothing);

      // The choice must be persisted, not just held in memory.
      final saved = (await db.select(db.settingsRows).getSingle());
      expect(saved.localeOverride, 'uk');

      // Switching back to "System" (the first segment) reverts to the
      // device/test-harness locale (English) live.
      await tester.tap(find.text('Системна'));
      await tester.pumpAndSettle();

      expect(find.text('Settings'), findsOneWidget);
      final cleared = (await db.select(db.settingsRows).getSingle());
      expect(cleared.localeOverride, isNull);
    });
  });
}
