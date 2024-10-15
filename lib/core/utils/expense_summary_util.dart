class ExpenseUtils {
  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  static bool isSameWeek(DateTime date) {
    final now = DateTime.now();
    final startOfWeek = now.subtract(
        Duration(days: now.weekday)); // Start of the current week (Monday)
    final endOfWeek = now.add(
        Duration(days: 8 - now.weekday)); // End of the current week (Sunday)
    return date.isAfter(startOfWeek) && date.isBefore(endOfWeek);
  }

  static bool isSameMonth(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month;
  }
}
