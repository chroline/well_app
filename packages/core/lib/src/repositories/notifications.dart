import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../services/notifications.dart';
import '../store/notifications.dart';
import '../store/settings.dart';
import '../util/get_version.dart';

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName!));
}

class NotificationRepository {
  static Future<void> init() async {
    await _configureLocalTimeZone();

    NotificationsStore.flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    const initializationSettingsIOS = IOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false);

    const initializationSettingsMacOS = MacOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false);

    const initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
        macOS: initializationSettingsMacOS);

    if (!kIsWeb) {
      await NotificationsStore.flutterLocalNotificationsPlugin
          ?.initialize(initializationSettings);
    }

    if (!SettingsDataStore.isInitialSession &&
        SettingsDataStore.registeredVersion != await getVersion()) {
      await NotificationService.cancelAllNotifs();
      await NotificationService.scheduleNotifs(
          SettingsDataStore.scheduledNotifTime);
    }
  }
}
