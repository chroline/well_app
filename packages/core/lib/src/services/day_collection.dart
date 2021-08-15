import '../store/day_collection.dart';
import '../util/models/day.dart';

class DayCollectionService {
  static Future<void> resetData() async {
    await DayCollectionStore.box.clear();
    DayCollectionStore.today = DayModel.withDate(DateTime.now());
    await DayCollectionStore.box.add(DayCollectionStore.today);
  }
}
