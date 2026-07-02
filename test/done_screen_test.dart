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

  testWidgets('marking the last dose shows the Done celebration content', (
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
          child: const PillpalApp(),
        ),
      );
      await tester.pumpAndSettle();

      // The test fixture has m1 already taken; tap the remaining three,
      // confirming "Mark as taken" in the sheet each opens.
      for (final id in ['m2', 'm3', 'm4']) {
        final finder = find.byKey(ValueKey('toggle-$id-t1'));
        await tester.ensureVisible(finder);
        await tester.pumpAndSettle();
        await tester.tap(finder);
        await tester.pumpAndSettle();
        await tester.tap(find.text('Mark as taken'));
        await tester.pumpAndSettle();
      }

      expect(find.text('All done!'), findsOneWidget);
      expect(find.text('4/4'), findsOneWidget);
      expect(find.text('View tomorrow'), findsOneWidget);
      expect(find.text('Back to today'), findsOneWidget);
    });
  });
}
