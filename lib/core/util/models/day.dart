import 'package:hive/hive.dart';

part 'day.g.dart';

@HiveType(typeId: 0)
class DayModel extends HiveObject {
  @HiveField(1)
  List<String> gratitudes = [];

  @HiveField(2)
  String? journal;

  @HiveField(3)
  List<String> acts = [];

  @HiveField(4)
  int exercise = 0;

  @HiveField(5)
  int meditation = 0;

  @HiveField(6)
  late final DateTime date;

  DayModel();

  DayModel.withDate(this.date);
}
