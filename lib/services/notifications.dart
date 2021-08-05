import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get_it/get_it.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../util/get_version.dart';
import 'settings.dart';

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName!));
}

tz.TZDateTime _nextInstanceOfTime(TimeOfDay timeOfDay) {
  final now = tz.TZDateTime.now(tz.local);
  var scheduledDate = tz.TZDateTime(
      tz.local, now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}

class NotificationService {
  static NotificationService get I => GetIt.I<NotificationService>();

  static Future<NotificationService> init() async {
    FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

    await _configureLocalTimeZone();

    if (!kIsWeb) {
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      const initializationSettingsAndroid =
          AndroidInitializationSettings('app_icon');
      const initializationSettingsIOS = IOSInitializationSettings(
          requestAlertPermission: false,
          requestSoundPermission: false,
          defaultPresentAlert: false,
          defaultPresentSound: false);
      const initializationSettingsMacOS = MacOSInitializationSettings(
          requestAlertPermission: false,
          requestSoundPermission: false,
          defaultPresentAlert: false,
          defaultPresentSound: false);

      const initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS,
          macOS: initializationSettingsMacOS);

      await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    }

    final notificationService = NotificationService._(
        flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin);

    if (!SettingsDataService.I.isInitialSession &&
        SettingsDataService.I.registeredVersion != await getVersion()) {
      await notificationService.cancelAllNotifs();
      await notificationService
          .scheduleNotifs(SettingsDataService.I.scheduledNotifTime);
    }

    return notificationService;
  }

  NotificationService._({this.flutterLocalNotificationsPlugin});

  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  Future<bool?>? requestPermissions() => flutterLocalNotificationsPlugin
      ?.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        sound: true,
      );

  Future<void> cancelAllNotifs() async {
    await flutterLocalNotificationsPlugin?.cancelAll();
  }

  Future<void> scheduleNotifs(TimeOfDay timeOfDay) async {
    if (kIsWeb) return;

    await cancelAllNotifs();

    SettingsDataService.I.scheduledNotifTime = timeOfDay;

    await flutterLocalNotificationsPlugin?.zonedSchedule(
        0,
        "Record today's activities",
        "Don't forget to record the activities you completed today!",
        _nextInstanceOfTime(timeOfDay),
        const NotificationDetails(
            android: AndroidNotificationDetails(
          'daily_reminder',
          'Daily Reminder',
          'Notifications to remind you to record your progress for the day.',
        )),
        androidAllowWhileIdle: false,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }
}
