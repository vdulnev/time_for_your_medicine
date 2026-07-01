import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:time_for_your_medicine/l10n/locale_resolution.dart';

void main() {
  const supported = [Locale('en'), Locale('uk')];

  test('device set to English resolves to English', () {
    expect(
      resolveLocale([const Locale('en', 'US')], supported),
      const Locale('en'),
    );
  });

  test('device set to Ukrainian resolves to Ukrainian', () {
    expect(
      resolveLocale([const Locale('uk', 'UA')], supported),
      const Locale('uk'),
    );
  });

  test('unsupported device language falls back to Ukrainian', () {
    expect(
      resolveLocale([const Locale('fr', 'FR')], supported),
      const Locale('uk'),
    );
  });

  test('null device locale list falls back to Ukrainian', () {
    expect(resolveLocale(null, supported), const Locale('uk'));
  });

  test('empty device locale list falls back to Ukrainian', () {
    expect(resolveLocale(const [], supported), const Locale('uk'));
  });

  test(
    'picks the first supported match when multiple preferred locales given',
    () {
      expect(
        resolveLocale([
          const Locale('fr', 'FR'),
          const Locale('en', 'GB'),
        ], supported),
        const Locale('en'),
      );
    },
  );
}
