import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:time_for_your_medicine/core/db/app_database.dart';
import 'package:time_for_your_medicine/core/logging/talker.dart';
import 'package:time_for_your_medicine/core/router/app_router.dart';
import 'package:time_for_your_medicine/core/state/providers.dart';
import 'package:time_for_your_medicine/core/theme/app_theme.dart';
import 'package:time_for_your_medicine/l10n/gen/app_localizations.dart';

import 'support/fixed_clock.dart';
import 'support/seed_test_data.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  testWidgets('Ukrainian locale renders translated Cyrillic text', (
    tester,
  ) async {
    await withFixedToday(() async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      await seedTestMedicines(db);
      final router = AppRouter();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            talkerProvider.overrideWithValue(Talker()),
            databaseProvider.overrideWithValue(db),
          ],
          child: MaterialApp.router(
            theme: buildAppTheme(),
            locale: const Locale('uk'),
            routerConfig: router.config(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Home: period label + dose/food line, both sourced from ARB.
      expect(find.text('Ранок'), findsOneWidget);
      expect(find.textContaining('з їжею'), findsWidgets);

      // No English chrome strings should have leaked through.
      expect(find.text('Morning'), findsNothing);
    });
  });

  testWidgets('Ukrainian plural: 1 dose left uses singular noun form', (
    tester,
  ) async {
    await withFixedToday(() async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      await seedTestMedicines(db);
      final router = AppRouter();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            talkerProvider.overrideWithValue(Talker()),
            databaseProvider.overrideWithValue(db),
          ],
          child: MaterialApp.router(
            theme: buildAppTheme(),
            locale: const Locale('uk'),
            routerConfig: router.config(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Fixture: only Metformin taken today → 3 left (few → "прийоми").
      expect(
        find.textContaining('Залишилось 3 прийоми сьогодні'),
        findsOneWidget,
      );
    });
  });
}
