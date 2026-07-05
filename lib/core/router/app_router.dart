import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../features/add/add_medicine_page.dart';
import '../../features/calendar/calendar_page.dart';
import '../../features/detail/medicine_detail_page.dart';
import '../../features/done/done_page.dart';
import '../../features/edit_reminder/edit_reminder_page.dart';
import '../../features/history/history_page.dart';
import '../../features/home/home_page.dart';
import '../../features/refills/refills_page.dart';
import '../../features/reminders/notifications_page.dart';
import '../../features/settings/settings_page.dart';
import '../../features/shell/dashboard_page.dart';
import '../../features/splash/splash_page.dart';
import '../../features/transactions/transactions_page.dart';

part 'app_router.gr.dart';

/// Typed navigation for the app.
@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(
      page: DashboardRoute.page,
      children: [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: CalendarRoute.page),
        AutoRoute(page: RefillsRoute.page),
        AutoRoute(page: SettingsRoute.page),
      ],
    ),
    AutoRoute(page: AddMedicineRoute.page),
    AutoRoute(page: MedicineDetailRoute.page),
    AutoRoute(page: EditReminderRoute.page),
    AutoRoute(page: DoneRoute.page),
    AutoRoute(page: HistoryRoute.page),
    AutoRoute(page: NotificationsRoute.page),
    AutoRoute(page: TransactionsRoute.page),
  ];
}
