import '../../../../frontend/config/messages.dart';

DateTime convertToDate(int value, String type) {
  DateTime date = DateTime(0);

  if (type == repeatOptions[0]) {
    date = date.add(Duration(minutes: value));
  } else if (type == repeatOptions[1]) {
    date = date.add(Duration(hours: value));
  } else if (type == repeatOptions[2]) {
    date = date.add(Duration(days: value));
  }

  return date;
}
