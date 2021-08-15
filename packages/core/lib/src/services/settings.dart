import 'package:flutter/material.dart';

import '../store/settings.dart';
import '../util/get_version.dart';

class SettingsDataService {
  static Future<void> updateRequestedReview() async =>
      await SettingsDataStore.box.put('requestedReview', true);
  static Future<void> updateInitialSession() async =>
      await SettingsDataStore.box.put('init', false);
  static Future<void> updateRegisteredVersion() async =>
      SettingsDataStore.box.put('registeredVersion', await getVersion());

  static Future<void> scheduleNotifTime(TimeOfDay timeOfDay) =>
      SettingsDataStore.box.put('scheduledNotifTime',
          timeOfDay.hour.toString() + ':' + timeOfDay.minute.toString());
}
