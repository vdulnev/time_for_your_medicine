import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

import 'app.dart';
import 'core/db/app_database.dart';
import 'core/logging/talker.dart';
import 'core/notifications/notification_service.dart';
import 'core/state/providers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final talker = TalkerFlutter.init();
  final database = AppDatabase();
  final notifications = LocalNotificationService(talker);

  FlutterError.onError = (details) {
    talker.handle(details.exception, details.stack);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    talker.handle(error, stack);
    return true;
  };

  runApp(
    ProviderScope(
      observers: [TalkerRiverpodObserver(talker: talker)],
      overrides: [
        talkerProvider.overrideWithValue(talker),
        databaseProvider.overrideWithValue(database),
        notificationServiceProvider.overrideWithValue(notifications),
      ],
      child: const PillnoteApp(),
    ),
  );
}
