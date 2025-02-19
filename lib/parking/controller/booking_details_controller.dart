import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/generic_controller.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingDetailsController extends GenericController{
  var currentIndex = 0.obs;
  var selectedOption = 0.obs;
  var selectedDateIndex = (-1).obs;
  var selectedTimeIndex = (-1).obs;
  var formatedDateAndTime= "";

  // Sample available dates and times (You should replace them with actual data)
  List<DateTime> availableDates = [
    DateTime(2025, 2, 10),
    DateTime(2025, 2, 11),
    DateTime(2025, 2, 12),
    DateTime(2025, 2, 13),
    DateTime(2025, 2, 14),
    DateTime(2025, 2, 16),
    DateTime(2025, 2, 17),
    DateTime(2025, 2, 18),
  ];

  List<String> availableTimes = [
    "08:00", "10:00", "11:00" ,"12:00", "14:00", "16:00" , "17:00", "20:00"
  ];

  void updateIndex(int index) {
    currentIndex.value = index;
  }

  void updateOption(int option) {
    selectedOption.value = option;
    selectedDateIndex.value = (-1);
    selectedTimeIndex.value = (-1);
  }

  void updateSelectedDateIndex(int index) {
    selectedDateIndex.value = index;
  }

  void updateSelectedTimeIndex(int index) {
    selectedTimeIndex.value = index;
  }

  void getSelectedTimestamp() async{
    DateTime selectedDate = availableDates[selectedDateIndex.value];
    String selectedTime = availableTimes[selectedTimeIndex.value];

    // Parse time and merge with date
    List<String> timeParts = selectedTime.split(":");
    DateTime finalDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      int.parse(timeParts[0]), // Hour
      int.parse(timeParts[1]), // Minute
    );

    formatedDateAndTime = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'").format(finalDateTime.toUtc());
    debugPrint("Selected date: ${formatedDateAndTime.toString()}");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("arriving_time", formatedDateAndTime);

  }

}