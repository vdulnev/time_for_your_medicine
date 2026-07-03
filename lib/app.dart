import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/error/app_exception.dart';
import 'core/router/app_router.dart';
import 'core/state/error_notifier.dart';
import 'core/state/providers.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_theme.dart';
import 'l10n/gen/app_localizations.dart';
import 'l10n/l10n_extensions.dart';
import 'l10n/locale_resolution.dart';

/// Root application widget wiring auto_route into `MaterialApp.router`.
class PillnoteApp extends ConsumerStatefulWidget {
  const PillnoteApp({super.key});

  @override
  ConsumerState<PillnoteApp> createState() => _PillnoteAppState();
}

class _PillnoteAppState extends ConsumerState<PillnoteApp> {
  final AppRouter _router = AppRouter();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    // When the user has picked a language in Settings, it overrides
    // device-locale resolution entirely (`locale:` takes priority over
    // `localeListResolutionCallback`). Otherwise `locale` stays null and
    // `resolveLocale` runs as usual.
    final override = ref.watch(
      dataProvider.select((s) => s.valueOrNull?.settings.localeOverride),
    );

    // A write that failed silently (see `DataNotifier._reportIfFailed`)
    // shows up here — the messenger's own context is used for l10n
    // rather than this one, since it's guaranteed to sit below
    // `MaterialApp.router`'s `Localizations` once mounted.
    ref.listen<AppException?>(errorNotifierProvider, (previous, next) {
      if (next == null) return;
      final messenger = _scaffoldMessengerKey.currentState;
      if (messenger == null) return;
      final l10n = AppLocalizations.of(messenger.context);
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(next.message(l10n)),
            backgroundColor: AppColors.danger,
          ),
        );
      ref.read(errorNotifierProvider.notifier).clear();
    });

    return MaterialApp.router(
      scaffoldMessengerKey: _scaffoldMessengerKey,
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
