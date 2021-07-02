import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../models/day.dart';
import '../util/date_is_today.dart';

class DayCollectionService {
  static DayCollectionService get I => GetIt.I<DayCollectionService>();

  static Future<DayCollectionService> init() async {
    await Hive.openBox('days');
    final box = Hive.box('days');

    DayModel today;

    try {
      final lastDay = box.values.last as DayModel?;
      if (lastDay != null && dateIsToday(lastDay.date)) {
        today = lastDay;
      } else {
        throw Exception();
      }
    } catch (e) {
      today = DayModel.withDate(DateTime.now());
      await box.add(today);
    }

    return DayCollectionService._(today: today, box: box);
  }

  DayCollectionService._({required this.today, required this.box});

  List<DayModel> get dayCollection => box.values.toList().cast<DayModel>();
  DayModel today;
  final Box box;

  void update(
      {String? gratitudes,
      String? journal,
      String? acts,
      int? exercise,
      int? meditation}) {
    if (gratitudes != null) today.gratitudes.insert(0, gratitudes);
    today.journal = journal ?? today.journal;
    if (acts != null) today.acts.insert(0, acts);
    today.exercise = exercise ?? today.exercise;
    today.meditation = meditation ?? today.meditation;
    today.save();
  }

  Future<void> resetData() async {
    await box.clear();
    today = DayModel.withDate(DateTime.now());
    await box.add(today);
  }
}
