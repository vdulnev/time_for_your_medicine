import 'dart:ui';

import 'package:clock/clock.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../../l10n/gen/app_localizations.dart';
import '../../l10n/locale_resolution.dart';
import '../state/data_state.dart';
import 'dose_schedule.dart';

/// Schedules OS dose-reminder notifications from [DataState]. The default
/// binding is [NoopNotificationService]; `main()` overrides it with
/// [LocalNotificationService] (see `notificationServiceProvider`), so
/// tests never touch platform channels.
abstract class NotificationService {
  Future<void> init();

  /// Reconciles the OS notification schedule with [data]. Cheap enough to
  /// call after every mutation — see `DataNotifier._syncNotifications`.
  Future<void> sync(DataState data);
}

class NoopNotificationService implements NotificationService {
  const NoopNotificationService();

  @override
  Future<void> init() async {}

  @override
  Future<void> sync(DataState data) async {}
}

/// The real implementation, backed by `flutter_local_notifications`.
///
/// Every schedule is a daily-repeating zoned notification
/// (`DateTimeComponents.time`); [sync] cancels everything and reschedules
/// from scratch (a few medicines × a few slots — no id bookkeeping, and
/// staleness self-heals on the next app open). Failures are logged and
/// swallowed: a notification problem must never break a dose mutation.
class LocalNotificationService implements NotificationService {
  LocalNotificationService(this._talker);

  final Talker _talker;
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  bool _ready = false;

  @override
  Future<void> init() async {
    if (_ready) return;
    try {
      tzdata.initializeTimeZones();
      try {
        final name = await FlutterTimezone.getLocalTimezone();
        tz.setLocalLocation(tz.getLocation(name));
      } on Object catch (error, st) {
        // tz.local falls back to UTC — schedules would drift, but that
        // beats not scheduling at all.
        _talker.handle(error, st, 'notifications: timezone lookup failed');
      }
      await _plugin.initialize(
        const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
          iOS: DarwinInitializationSettings(),
        ),
      );
      await _plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
      await _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
      _ready = true;
      _talker.debug('notifications: initialized');
    } on Object catch (error, st) {
      _talker.handle(error, st, 'notifications: init failed');
    }
  }

  /// Notification text can't come from a `BuildContext` — schedules are
  /// built from the data layer — so the locale is resolved the same way
  /// the app shell does it: settings override first, device locales via
  /// [resolveLocale] otherwise.
  AppLocalizations _l10nFor(DataState data) {
    final override = data.settings.localeOverride;
    final locale = override != null
        ? Locale(override)
        : resolveLocale(
            PlatformDispatcher.instance.locales,
            AppLocalizations.supportedLocales,
          );
    return lookupAppLocalizations(locale);
  }

  @override
  Future<void> sync(DataState data) async {
    if (!_ready) return;
    try {
      await _plugin.cancelAll();
      final l10n = _l10nFor(data);
      final settings = data.settings;
      // Android freezes a channel's sound/vibration at creation, so each
      // (sound, vibrate) combination gets its own channel — toggling a
      // setting switches to the matching variant instead of silently
      // keeping the old behavior.
      final channelId =
          'doses_s${settings.sound ? 1 : 0}_v${settings.vibrate ? 1 : 0}';
      final details = NotificationDetails(
        android: AndroidNotificationDetails(
          channelId,
          l10n.notifChannelName,
          channelDescription: l10n.notifChannelDescription,
          importance: Importance.high,
          priority: Priority.high,
          playSound: settings.sound,
          enableVibration: settings.vibrate,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBanner: true,
          presentSound: settings.sound,
        ),
      );
      final schedules = buildDoseSchedules(data, clock.now());
      for (var i = 0; i < schedules.length; i++) {
        await _schedule(i, schedules[i], details, l10n, exact: true);
      }
      _talker.debug('notifications: scheduled ${schedules.length} slots');
    } on Object catch (error, st) {
      _talker.handle(error, st, 'notifications: sync failed');
    }
  }

  Future<void> _schedule(
    int id,
    DoseSchedule s,
    NotificationDetails details,
    AppLocalizations l10n, {
    required bool exact,
  }) async {
    try {
      await _plugin.zonedSchedule(
        id,
        l10n.notifDoseTitle,
        l10n.notifDoseBody(s.medName, s.dose, s.displayTime),
        tz.TZDateTime.from(s.firstFire, tz.local),
        details,
        androidScheduleMode: exact
            ? AndroidScheduleMode.exactAllowWhileIdle
            : AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    } on PlatformException {
      // Android 14+ denies exact alarms unless the user grants them in
      // system settings; an inexact daily reminder is the right fallback.
      if (!exact) rethrow;
      await _schedule(id, s, details, l10n, exact: false);
    }
  }
}
