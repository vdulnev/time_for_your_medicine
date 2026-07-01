import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../core/router/app_router.dart';
import '../../core/theme/app_colors.dart';
import 'bottom_nav_bar.dart';

/// The bottom-tab shell hosting Home, Calendar, Refills, and Settings.
@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        HomeRoute(),
        CalendarRoute(),
        RefillsRoute(),
        SettingsRoute(),
      ],
      transitionBuilder: (context, child, animation) =>
          FadeTransition(opacity: animation, child: child),
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          backgroundColor: AppColors.screenBg,
          body: Stack(
            children: [
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom:
                        kNavBarHeight + MediaQuery.of(context).padding.bottom,
                  ),
                  child: child,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: BottomNavBar(tabsRouter: tabsRouter),
              ),
            ],
          ),
        );
      },
    );
  }
}
