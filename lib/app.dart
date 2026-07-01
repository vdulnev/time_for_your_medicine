import 'package:flutter/material.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

/// Root application widget wiring auto_route into `MaterialApp.router`.
class PillpalApp extends StatefulWidget {
  const PillpalApp({super.key});

  @override
  State<PillpalApp> createState() => _PillpalAppState();
}

class _PillpalAppState extends State<PillpalApp> {
  final AppRouter _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Pillpal',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      routerConfig: _router.config(),
    );
  }
}
