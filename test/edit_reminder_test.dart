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

  Future<void> openEditReminderForMetformin(
    WidgetTester tester,
    AppDatabase db,
  ) async {
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

    await tester.tap(find.text('Metformin'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.edit_outlined));
    await tester.pumpAndSettle();
  }

  testWidgets(
    'shows the existing time read-only and lets staged new times be added '
    'and removed down to a minimum of 1',
    (tester) async {
      await withFixedToday(() async {
        final db = AppDatabase(NativeDatabase.memory());
        addTearDown(db.close);
        await seedTestMedicines(db);
        await openEditReminderForMetformin(tester, db);

        expect(find.text('Edit Reminder'), findsOneWidget);
        // Matches both the existing time row and the still-empty new-time
        // field's placeholder hint (which is also "8:00 AM").
        expect(find.text('8:00 AM'), findsNWidgets(2));

        // Only the page's own close button uses this icon while there's
        // just one (non-removable) staged slot.
        expect(find.byIcon(Icons.close_rounded), findsOneWidget);

        await tester.tap(find.text('Add another time'));
        await tester.pumpAndSettle();

        // Two staged slots now, both removable, plus the page close button.
        expect(find.byIcon(Icons.close_rounded), findsNWidgets(3));

        // .first is the page's own close button (pops the page) — tap the
        // last one instead, one of the two removable TimeSlotCards.
        await tester.tap(find.byIcon(Icons.close_rounded).last);
        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.close_rounded), findsOneWidget);
      });
    },
  );

  testWidgets(
    'save is disabled with a hint when the staged time duplicates the '
    'existing one',
    (tester) async {
      await withFixedToday(() async {
        final db = AppDatabase(NativeDatabase.memory());
        addTearDown(db.close);
        await seedTestMedicines(db);
        await openEditReminderForMetformin(tester, db);

        await tester.enterText(
          find.byKey(const ValueKey('time-field-0')),
          '8:00 AM',
        );
        await tester.pumpAndSettle();

        expect(find.text('That time is already used.'), findsOneWidget);

        await tester.tap(find.text('Save changes'));
        await tester.pumpAndSettle();

        // Still on the Edit Reminder screen — the tap was a no-op.
        expect(find.text('Edit Reminder'), findsOneWidget);
      });
    },
  );

  testWidgets(
    'saving a new, distinct time appends it and returns to the detail page',
    (tester) async {
      await withFixedToday(() async {
        final db = AppDatabase(NativeDatabase.memory());
        addTearDown(db.close);
        await seedTestMedicines(db);
        await openEditReminderForMetformin(tester, db);

        await tester.enterText(
          find.byKey(const ValueKey('time-field-0')),
          '2:00 PM',
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('Save changes'));
        await tester.pumpAndSettle();

        expect(find.text('Edit Reminder'), findsNothing);
        expect(find.textContaining('2:00 PM'), findsOneWidget);
      });
    },
  );
}
