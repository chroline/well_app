import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../store/notifications.dart';
import 'settings.dart';

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
  static Future<void> requestPermissions() async {
    if (Platform.isIOS) {
      await NotificationsStore.flutterLocalNotificationsPlugin
          ?.resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }
    if (Platform.isMacOS) {
      // ignore: unawaited_futures
      NotificationsStore.flutterLocalNotificationsPlugin
          ?.resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }
  }

  static Future<void> cancelAllNotifs() async {
    await NotificationsStore.flutterLocalNotificationsPlugin?.cancelAll();
  }

  static Future<void> scheduleNotifs(TimeOfDay timeOfDay) async {
    if (kIsWeb) return;

    await cancelAllNotifs();

    await SettingsDataService.scheduleNotifTime(timeOfDay);

    await NotificationsStore.flutterLocalNotificationsPlugin?.zonedSchedule(
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
