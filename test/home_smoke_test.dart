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

  testWidgets('boots to an empty Home without demo medicines', (tester) async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);

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

    expect(find.text('Metformin'), findsNothing);
    expect(find.text('No medicines yet.\nTap + to add one.'), findsOneWidget);
  });
}
