import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../util/get_version.dart';

class SettingsDataService {
  static SettingsDataService get I => GetIt.I<SettingsDataService>();

  static Future<SettingsDataService> init() async {
    await Hive.openBox('settings');
    final box = Hive.box('settings');

    return SettingsDataService._(box);
  }

  SettingsDataService._(this.box);

  final Box<dynamic> box;

  bool get isInitialSession => box.get('init') ?? true;
  Future<void> updateInitialSession() async => await box.put('init', false);

  bool get hasRequestedReview => box.get('requestedReview') ?? false;
  Future<void> updateRequestedReview() async =>
      await box.put('requestedReview', true);

  TimeOfDay get scheduledNotifTime {
    try {
      final rawTimeOfDayComponents =
          (box.get('scheduledNotifTime') as String).split(':');
      final hour = int.parse(rawTimeOfDayComponents[0]);
      final minute = int.parse(rawTimeOfDayComponents[1]);
      return TimeOfDay(hour: hour, minute: minute);
    } catch (e) {
      return const TimeOfDay(hour: 19, minute: 0);
    }
  }

  set scheduledNotifTime(TimeOfDay timeOfDay) => box.put('scheduledNotifTime',
      timeOfDay.hour.toString() + ':' + timeOfDay.minute.toString());

  String? get registeredVersion => box.get('registeredVersion');

  Future<void> updateRegisteredVersion() async =>
      box.put('registeredVersion', await getVersion());
}
