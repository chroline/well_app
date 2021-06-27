bool dateIsToday(DateTime compare) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  return DateTime(compare.year, compare.month, compare.day) == today;
}
