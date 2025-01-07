import 'package:get/get.dart';
import 'package:parq/app_config/generic_controller.dart';

class BookingDetailsController extends GenericController{
  var currentIndex = 0.obs;
  var selectedOption = 0.obs;
  var selectedDateIndex = (-1).obs;
  var selectedTimeIndex = (-1).obs;

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
}