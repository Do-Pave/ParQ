import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateUtil {
  static String convertDate(String? date) {
    if (date == null || date.isEmpty) return "Invalid Date"; // Handle null/empty

    try {
      DateTime dateTime = DateTime.parse(date).toLocal();
      return DateFormat("MMMM d / h:mm a").format(dateTime);
    } catch (e) {
      debugPrint("Error parsing date: $e"); // Debugging log
      return "Invalid Date";
    }
  }
}
