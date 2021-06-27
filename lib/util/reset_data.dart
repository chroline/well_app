import '../services/day_collection.dart';
import '../services/settings.dart';

Future<void> resetData() async {
  await SettingsDataService.I.box.clear();
  await DayCollectionService.I.box.clear();
}
