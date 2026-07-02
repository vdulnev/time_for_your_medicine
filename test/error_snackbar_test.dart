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

/// Regression coverage for the class of bug fixed in the v7 → v8
/// migration (see SPEC.md §7): a `DataNotifier` mutation applies its
/// optimistic UI update, then the actual repository write throws and is
/// caught by `MedicineRepository._guard` — without this snackbar, that
/// failure was completely invisible to the user.
void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  testWidgets(
    'a background write that fails after the DB closes shows an error '
    'snackbar instead of failing silently',
    (tester) async {
      await withFixedToday(() async {
        final db = AppDatabase(NativeDatabase.memory());
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

        expect(find.byType(SnackBar), findsNothing);

        // Force every subsequent write to throw — a stand-in for any
        // real-world write failure (a schema mismatch like the v7→v8
        // bug, a full disk, etc.), which is what `_reportIfFailed`
        // exists to surface regardless of cause.
        await db.close();

        final finder = find.byKey(const ValueKey('toggle-m2-t1'));
        await tester.ensureVisible(finder);
        await tester.pumpAndSettle();
        await tester.tap(finder);
        await tester.pumpAndSettle();
        await tester.tap(find.text('Mark as taken'));
        await tester.pumpAndSettle();

        expect(find.byType(SnackBar), findsOneWidget);
      });
    },
  );
}
