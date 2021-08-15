import 'package:hive/hive.dart';

import '../store/settings.dart';

class SettingsDataRepository {
  static Future<void> init() async {
    await Hive.openBox('settings');
    SettingsDataStore.box = Hive.box('settings');
  }
}
