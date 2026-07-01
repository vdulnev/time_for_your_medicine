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

  Future<void> pumpApp(WidgetTester tester, AppDatabase db) async {
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
  }

  testWidgets('bottom nav switches between Home, Calendar, Refills, Settings', (
    tester,
  ) async {
    await withFixedToday(() async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      await seedTestMedicines(db);
      await pumpApp(tester, db);

      expect(find.text('Metformin'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.calendar_today_outlined).first);
      await tester.pumpAndSettle();
      expect(find.text('June 2026'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.medication_liquid_outlined));
      await tester.pumpAndSettle();
      expect(find.text('Refills'), findsOneWidget);
      expect(find.text('Atorvastatin is low'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.tune_rounded));
      await tester.pumpAndSettle();
      expect(find.text('Alex Morgan'), findsOneWidget);
    });
  });

  testWidgets('tapping a medicine opens Detail and back returns Home', (
    tester,
  ) async {
    await withFixedToday(() async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      await seedTestMedicines(db);
      await pumpApp(tester, db);

      await tester.tap(find.text('Metformin'));
      await tester.pumpAndSettle();

      expect(find.text('500 mg capsule'), findsOneWidget);
      expect(find.text('Mark as taken'), findsNothing); // already taken today
      expect(find.text('Taken today ✓'), findsOneWidget);
    });
  });
}
