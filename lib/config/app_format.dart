import 'package:intl/intl.dart';

class AppFormat {
  static String date(String stringDate) {
    // 2022-02-05
    DateTime dateTime = DateTime.parse(stringDate);
    return DateFormat.yMMMMd().format(dateTime); // 5 Feb 2022
  }

  static String formatdate(String stringDate) {
    // 2022-02-05 00:00:00
    DateTime dateTime = DateTime.parse(stringDate);
    return DateFormat('yyyy-MM-dd').format(dateTime); // 2022-02-05
  }
}
