import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:time_for_your_medicine/app.dart';
import 'package:time_for_your_medicine/core/db/app_database.dart';
import 'package:time_for_your_medicine/core/logging/talker.dart';
import 'package:time_for_your_medicine/core/state/providers.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  testWidgets('shows the animated splash first, then hands off to Home', (
    tester,
  ) async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          talkerProvider.overrideWithValue(Talker()),
          databaseProvider.overrideWithValue(db),
        ],
        child: const PillpalApp(),
      ),
    );

    // Right after the first frame, the splash brand mark is up and
    // Home hasn't rendered yet — the router hasn't handed off.
    await tester.pump();
    expect(find.text('Pillpal'), findsOneWidget);
    expect(find.text('Time to take your medicine'), findsOneWidget);
    expect(find.text('No medicines yet.\nTap + to add one.'), findsNothing);

    // Once data load + the minimum splash duration elapse, it
    // replaces itself with the dashboard.
    await tester.pumpAndSettle();
    expect(find.text('No medicines yet.\nTap + to add one.'), findsOneWidget);
    expect(find.text('Time to take your medicine'), findsNothing);
  });
}
