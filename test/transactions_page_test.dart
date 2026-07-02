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

  Future<void> openTransactions(WidgetTester tester, AppDatabase db) async {
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

    await tester.tap(find.byIcon(Icons.tune_rounded)); // Settings tab
    await tester.pumpAndSettle();
    final historyRow = find.text('History & adherence');
    await tester.scrollUntilVisible(historyRow, 200);
    await tester.tap(historyRow);
    await tester.pumpAndSettle();
    final transactionsRow = find.text('View transactions');
    await tester.scrollUntilVisible(transactionsRow, 200);
    await tester.tap(transactionsRow);
    await tester.pumpAndSettle();
  }

  testWidgets('lists every seeded medicine\'s initial-stock transaction', (
    tester,
  ) async {
    await withFixedToday(() async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      await seedTestMedicines(db);
      await openTransactions(tester, db);

      expect(find.text('Transactions'), findsOneWidget);
      for (final name in [
        'Metformin',
        'Vitamin D',
        'Ibuprofen',
        'Atorvastatin',
      ]) {
        expect(find.text(name), findsOneWidget);
      }
      expect(find.textContaining('Initial stock'), findsNWidgets(4));
    });
  });

  testWidgets('filtering by medicine narrows the list to that medicine', (
    tester,
  ) async {
    await withFixedToday(() async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      await seedTestMedicines(db);
      await openTransactions(tester, db);

      await tester.tap(find.byType(DropdownButton<String?>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Ibuprofen').last);
      await tester.pumpAndSettle();

      // Two matches: the dropdown's own selected-value label, plus the
      // one remaining transaction tile for Ibuprofen.
      expect(find.text('Ibuprofen'), findsNWidgets(2));
      expect(find.text('Metformin'), findsNothing);
      expect(find.text('Vitamin D'), findsNothing);
      expect(find.text('Atorvastatin'), findsNothing);
    });
  });
}
