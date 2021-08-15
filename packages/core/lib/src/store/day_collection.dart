import 'package:hive/hive.dart';

import '../util/models/day.dart';

class DayCollectionStore {
  static List<DayModel> get dayCollection =>
      box.values.toList().cast<DayModel>();
  static late DayModel today;
  static late Box box;
}
