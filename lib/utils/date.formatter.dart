import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static String formatterDate(String date) {
    //parse to 2024-02-14
    try {
      DateTime dateTime = DateTime.parse(date);

      DateFormat formatter = DateFormat('yyyy-MM-dd');

      String formattedDate = formatter.format(dateTime);

      return formattedDate;
    } catch (e) {
      return "";
    }
  }
}
