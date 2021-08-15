import 'package:hive/hive.dart';

import '../store/day_collection.dart';
import '../util/models/day.dart';

bool _dateIsToday(DateTime compare) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  return DateTime(compare.year, compare.month, compare.day) == today;
}

class DayCollectionRepository {
  static void update(
      {String? gratitudes,
      String? journal,
      String? acts,
      int? exercise,
      int? meditation}) {
    if (gratitudes != null) {
      DayCollectionStore.today.gratitudes.insert(0, gratitudes);
    }
    DayCollectionStore.today.journal =
        journal ?? DayCollectionStore.today.journal;
    if (acts != null) DayCollectionStore.today.acts.insert(0, acts);
    DayCollectionStore.today.exercise =
        exercise ?? DayCollectionStore.today.exercise;
    DayCollectionStore.today.meditation =
        meditation ?? DayCollectionStore.today.meditation;
    DayCollectionStore.today.save();
  }

  static Future<void> init() async {
    await Hive.openBox('days');
    DayCollectionStore.box = Hive.box('days');

    try {
      final lastDay = DayCollectionStore.box.values.last as DayModel?;
      if (lastDay != null && _dateIsToday(lastDay.date)) {
        DayCollectionStore.today = lastDay;
      } else {
        throw Exception();
      }
    } catch (e) {
      DayCollectionStore.today = DayModel.withDate(DateTime.now());
      await DayCollectionStore.box.add(DayCollectionStore.today);
    }
  }
}
