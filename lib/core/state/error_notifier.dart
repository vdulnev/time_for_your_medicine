import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../error/app_exception.dart';

/// Surfaces failures from writes that would otherwise fail silently —
/// `DataNotifier`'s mutation methods run optimistic UI updates and then
/// persist in the background; without this, a failed persist left the UI
/// looking correct while nothing actually reached disk. `report` sets the
/// latest failure, `clear` resets it once a listener has shown it.
class ErrorNotifier extends Notifier<AppException?> {
  @override
  AppException? build() => null;

  void report(AppException error) => state = error;

  void clear() => state = null;
}

final errorNotifierProvider = NotifierProvider<ErrorNotifier, AppException?>(
  ErrorNotifier.new,
);
