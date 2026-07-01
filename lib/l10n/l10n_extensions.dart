import 'package:flutter/widgets.dart';

import '../core/error/app_exception.dart';
import '../core/models/period.dart';
import 'gen/app_localizations.dart';

/// Convenience accessor: `context.l10n.xyz` instead of
/// `AppLocalizations.of(context).xyz`.
extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);

  /// The current locale's language code, e.g. "en" or "uk" — for threading
  /// into locale-aware, context-free helpers (`DayUtils`, `Selectors`).
  String get localeName => Localizations.localeOf(this).languageCode;
}

/// Localized label for a [Period], e.g. "Morning" / "Ранок".
extension PeriodL10n on Period {
  String label(AppLocalizations l10n) => switch (this) {
    Period.morning => l10n.periodMorning,
    Period.afternoon => l10n.periodAfternoon,
    Period.evening => l10n.periodEvening,
  };
}

/// Localized user-facing message for an [AppException].
extension AppExceptionL10n on AppException {
  String message(AppLocalizations l10n) => switch (this) {
    DatabaseFailure(:final message) => message,
    NotFoundFailure(:final id) => l10n.errorNotFound(id),
    UnknownFailure(:final error) => l10n.errorUnknown(error.toString()),
  };
}
