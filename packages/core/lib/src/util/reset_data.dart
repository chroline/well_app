import '../services/day_collection.dart';
import '../store/settings.dart';

Future<void> resetData() async {
  await SettingsDataStore.box.clear();
  await DayCollectionService.resetData();
}
