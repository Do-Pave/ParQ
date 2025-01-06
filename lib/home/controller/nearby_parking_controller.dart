import 'package:get/get.dart';
import 'package:parq/app_config/generic_controller.dart';

class NearbyParkingController extends GenericController{
  var currentIndex = 0.obs;
  var checkbox1 = false.obs;
  var checkbox2 = false.obs;

  void updateCheckbox(int checkboxNumber, bool value) {
    if (checkboxNumber == 1) {
      checkbox1.value = value;
    } else if (checkboxNumber == 2) {
      checkbox2.value = value;
    }
  }

  void updateIndex(int index) {
    currentIndex.value = index;
  }

}