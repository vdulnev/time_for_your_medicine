import 'package:flutter/widgets.dart';

/// Matches the device's preferred locales against [supportedLocales] by
/// language code — a device set to English or Ukrainian shows as-is. If
/// none of the device's preferred locales are supported, defaults to
/// Ukrainian rather than Flutter's built-in fallback (the first entry in
/// [supportedLocales], which is English).
Locale resolveLocale(
  List<Locale>? deviceLocales,
  Iterable<Locale> supportedLocales,
) {
  for (final deviceLocale in deviceLocales ?? const <Locale>[]) {
    for (final supported in supportedLocales) {
      if (supported.languageCode == deviceLocale.languageCode) {
        return supported;
      }
    }
  }
  return const Locale('uk');
}
