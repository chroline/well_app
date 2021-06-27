import 'dart:math';

import '../models/day.dart';

double calculateDayCompletion(DayModel day) =>
    (min(day.gratitudes.length / 3, 1) +
        (day.journal != null && day.journal != '' ? 1 : 0) +
        min(day.acts.length / 3, 1) +
        min(day.exercise / 20, 1) +
        min(day.meditation / 15, 1)) /
    5;
