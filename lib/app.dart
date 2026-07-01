import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/state/providers.dart';
import 'core/theme/app_theme.dart';
import 'l10n/gen/app_localizations.dart';
import 'l10n/locale_resolution.dart';

/// Root application widget wiring auto_route into `MaterialApp.router`.
class PillpalApp extends ConsumerStatefulWidget {
  const PillpalApp({super.key});

  @override
  ConsumerState<PillpalApp> createState() => _PillpalAppState();
}

class _PillpalAppState extends ConsumerState<PillpalApp> {
  final AppRouter _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    // When the user has picked a language in Settings, it overrides
    // device-locale resolution entirely (`locale:` takes priority over
    // `localeListResolutionCallback`). Otherwise `locale` stays null and
    // `resolveLocale` runs as usual.
    final override = ref.watch(
      dataProvider.select((s) => s.valueOrNull?.settings.localeOverride),
    );

    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      routerConfig: _router.config(),
      locale: override == null ? null : Locale(override),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      localeListResolutionCallback: resolveLocale,
    );
  }
}
