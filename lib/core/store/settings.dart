import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SettingsDataStore {
  static late Box<dynamic> box;

  static bool get isInitialSession => SettingsDataStore.box.get('init') ?? true;

  static bool get hasRequestedReview =>
      SettingsDataStore.box.get('requestedReview') ?? false;

  static TimeOfDay get scheduledNotifTime {
    try {
      final rawTimeOfDayComponents =
          (SettingsDataStore.box.get('scheduledNotifTime') as String)
              .split(':');
      final hour = int.parse(rawTimeOfDayComponents[0]);
      final minute = int.parse(rawTimeOfDayComponents[1]);
      return TimeOfDay(hour: hour, minute: minute);
    } catch (e) {
      return const TimeOfDay(hour: 19, minute: 0);
    }
  }

  static String? get registeredVersion =>
      SettingsDataStore.box.get('registeredVersion');
}
