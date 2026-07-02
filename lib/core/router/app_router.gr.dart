// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AddMedicinePage]
class AddMedicineRoute extends PageRouteInfo<void> {
  const AddMedicineRoute({List<PageRouteInfo>? children})
    : super(AddMedicineRoute.name, initialChildren: children);

  static const String name = 'AddMedicineRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AddMedicinePage();
    },
  );
}

/// generated route for
/// [CalendarPage]
class CalendarRoute extends PageRouteInfo<void> {
  const CalendarRoute({List<PageRouteInfo>? children})
    : super(CalendarRoute.name, initialChildren: children);

  static const String name = 'CalendarRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CalendarPage();
    },
  );
}

/// generated route for
/// [DashboardPage]
class DashboardRoute extends PageRouteInfo<void> {
  const DashboardRoute({List<PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DashboardPage();
    },
  );
}

/// generated route for
/// [DonePage]
class DoneRoute extends PageRouteInfo<void> {
  const DoneRoute({List<PageRouteInfo>? children})
    : super(DoneRoute.name, initialChildren: children);

  static const String name = 'DoneRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DonePage();
    },
  );
}

/// generated route for
/// [HistoryPage]
class HistoryRoute extends PageRouteInfo<void> {
  const HistoryRoute({List<PageRouteInfo>? children})
    : super(HistoryRoute.name, initialChildren: children);

  static const String name = 'HistoryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HistoryPage();
    },
  );
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
    },
  );
}

/// generated route for
/// [MedicineDetailPage]
class MedicineDetailRoute extends PageRouteInfo<MedicineDetailRouteArgs> {
  MedicineDetailRoute({
    Key? key,
    required String medId,
    List<PageRouteInfo>? children,
  }) : super(
         MedicineDetailRoute.name,
         args: MedicineDetailRouteArgs(key: key, medId: medId),
         initialChildren: children,
       );

  static const String name = 'MedicineDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MedicineDetailRouteArgs>();
      return MedicineDetailPage(key: args.key, medId: args.medId);
    },
  );
}

class MedicineDetailRouteArgs {
  const MedicineDetailRouteArgs({this.key, required this.medId});

  final Key? key;

  final String medId;

  @override
  String toString() {
    return 'MedicineDetailRouteArgs{key: $key, medId: $medId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MedicineDetailRouteArgs) return false;
    return key == other.key && medId == other.medId;
  }

  @override
  int get hashCode => key.hashCode ^ medId.hashCode;
}

/// generated route for
/// [NotificationsPage]
class NotificationsRoute extends PageRouteInfo<void> {
  const NotificationsRoute({List<PageRouteInfo>? children})
    : super(NotificationsRoute.name, initialChildren: children);

  static const String name = 'NotificationsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NotificationsPage();
    },
  );
}

/// generated route for
/// [RefillsPage]
class RefillsRoute extends PageRouteInfo<void> {
  const RefillsRoute({List<PageRouteInfo>? children})
    : super(RefillsRoute.name, initialChildren: children);

  static const String name = 'RefillsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RefillsPage();
    },
  );
}

/// generated route for
/// [SettingsPage]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsPage();
    },
  );
}

/// generated route for
/// [TransactionsPage]
class TransactionsRoute extends PageRouteInfo<void> {
  const TransactionsRoute({List<PageRouteInfo>? children})
    : super(TransactionsRoute.name, initialChildren: children);

  static const String name = 'TransactionsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TransactionsPage();
    },
  );
}
