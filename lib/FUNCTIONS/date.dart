import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatLongDate(DateTime date) {
  final DateFormat formatter = DateFormat('EEEE, MMMM d, y hh:mm a');
  return formatter.format(date);
}

String formatDate(DateTime date) {
  final DateFormat formatter = DateFormat('MMMM d, y');
  return formatter.format(date);
}

String formatShortDate(DateTime date) {
  final DateFormat formatter = DateFormat('MM/dd/yyyy');
  return formatter.format(date);
}

String formatTime(DateTime date) {
  final DateFormat formatter = DateFormat('hh:mm a');
  return formatter.format(date);
}

String formatLongTime(DateTime date) {
  final DateFormat formatter = DateFormat('HH:mm:ss');
  return formatter.format(date);
}

bool checkDate(DateTime date, DateTime checkedDate) {
  return date.year == checkedDate.year &&
      date.month == checkedDate.month &&
      date.day == checkedDate.day;
}

bool checkGreaterDate(DateTime date, DateTime checkedDate) {
  return checkedDate.millisecondsSinceEpoch > date.millisecondsSinceEpoch;
}

bool checkLessDate(DateTime date, DateTime checkedDate) {
  return checkedDate.millisecondsSinceEpoch < date.millisecondsSinceEpoch;
}

DateTime createDate(int month, int day, int year) {
  return DateTime(year, month, day);
}

String getMonthName(int month) {
  // List of month names in order
  List<String> monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  // Validate the input range
  if (month < 1 || month > 12) {
    throw ArgumentError('Month must be between 1 and 12.');
  }

  // Return the month name
  return monthNames[month - 1];
}

int getMonthNum(String monthStr) {
  switch (monthStr.toLowerCase()) {
    case "january":
      return 1;
    case "february":
      return 2;
    case "march":
      return 3;
    case "april":
      return 4;
    case "may":
      return 5;
    case "june":
      return 6;
    case "july":
      return 7;
    case "august":
      return 8;
    case "september":
      return 9;
    case "october":
      return 10;
    case "november":
      return 11;
    case "december":
      return 12;
    default:
      throw ArgumentError("Invalid month string: $monthStr");
  }
}

List<String> getMonthsOfYear(int year) {
  List<String> months = [];

  for (int month = 1; month <= 12; month++) {
    DateTime date = DateTime(year, month);
    String monthName = getMonthName(date.month);
    months.add(monthName);
  }

  return months;
}

List<int> getDaysOfMonth(int month, int year) {
  // Validate month input
  if (month < 1 || month > 12) {
    throw ArgumentError(
        'Invalid month: $month. Month must be between 1 and 12.');
  }

  // Determine number of days in the month
  int daysInMonth = 31; // Default to maximum days

  switch (month) {
    case 4: // April
    case 6: // June
    case 9: // September
    case 11: // November
      daysInMonth = 30;
      break;
    case 2: // February
      daysInMonth = _isLeapYear(year) ? 29 : 28;
      break;
  }

  // Create list of days in the month
  List<int> daysList = List.generate(daysInMonth, (index) => index + 1);

  return daysList;
}

int daysBetweenDates(DateTime date1, DateTime date2) {
  // Calculate difference in milliseconds
  Duration difference = date1.difference(date2).abs();

  // Calculate difference in days
  int diffDays = difference.inDays;

  return diffDays;
}

DateTime startOfDay(DateTime date) {
  return DateTime.utc(date.year, date.month, date.day);
}

DateTime endOfDay(DateTime date) {
  return DateTime.utc(date.year, date.month, date.day, 23, 59, 59, 999);
}

Future<DateTime?> selectDate(
  BuildContext context, {
  required DateTime initialDate,
  DateTime? minDate,
  DateTime? maxDate,
}) async {
  // Use default values if minDate or maxDate are not provided
  minDate ??= DateTime.now()
      .subtract(const Duration(days: 365 * 100)); // Example: 100 years ago
  maxDate ??= DateTime.now()
      .add(const Duration(days: 365 * 100)); // Example: 100 years ahead

  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: minDate,
    lastDate: maxDate,
  );

  // Return pickedDate or null if canceled
  return pickedDate;
}

Future<TimeOfDay?> selectTime(
  BuildContext context, {
  required TimeOfDay initialTime,
}) async {
  // Show the time picker
  final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      initialEntryMode: TimePickerEntryMode.input);

  // Return the picked time or null if the picker is canceled
  return pickedTime;
}

// LOCAL
bool _isLeapYear(int year) {
  if (year % 4 != 0) {
    return false;
  } else if (year % 100 != 0) {
    return true;
  } else if (year % 400 != 0) {
    return false;
  } else {
    return true;
  }
}
