import 'package:intl/intl.dart';

class DateUtil {
  static String convertDate(String date) {
    DateTime dateTime = DateTime.parse(date).toLocal();
    return DateFormat("MMMM d / h:mm a").format(dateTime);
  }
}