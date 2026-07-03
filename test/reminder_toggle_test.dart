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
import 'package:time_for_your_medicine/features/shell/widgets/toggle_switch.dart';

import 'support/fixed_clock.dart';
import 'support/seed_test_data.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  testWidgets(
    'turning off a medicine\'s reminder hides it from Home; turning it '
    'back on restores it',
    (tester) async {
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

        expect(find.text('Vitamin D'), findsOneWidget);

        // Home → Settings tab → Reminders → toggle off Vitamin D.
        await tester.tap(find.byIcon(Icons.tune_rounded));
        await tester.pumpAndSettle();
        final remindersRow = find.text('Reminders');
        await tester.scrollUntilVisible(remindersRow, 200);
        await tester.tap(remindersRow);
        await tester.pumpAndSettle();

        final vitaminDToggle = find.descendant(
          of: find.ancestor(
            of: find.text('Vitamin D'),
            matching: find.byType(Row),
          ),
          matching: find.byType(ToggleSwitch),
        );
        await tester.tap(vitaminDToggle);
        await tester.pumpAndSettle();

        // Back to Settings, then Home tab.
        await tester.tap(find.byIcon(Icons.chevron_left_rounded));
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(Icons.home_outlined));
        await tester.pumpAndSettle();

        expect(find.text('Vitamin D'), findsNothing);

        // Turning it back on restores it to Home.
        await tester.tap(find.byIcon(Icons.tune_rounded));
        await tester.pumpAndSettle();
        final remindersRow2 = find.text('Reminders');
        await tester.scrollUntilVisible(remindersRow2, 200);
        await tester.tap(remindersRow2);
        await tester.pumpAndSettle();

        final vitaminDToggle2 = find.descendant(
          of: find.ancestor(
            of: find.text('Vitamin D'),
            matching: find.byType(Row),
          ),
          matching: find.byType(ToggleSwitch),
        );
        await tester.tap(vitaminDToggle2);
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.chevron_left_rounded));
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(Icons.home_outlined));
        await tester.pumpAndSettle();

        expect(find.text('Vitamin D'), findsOneWidget);
      });
    },
  );
}
