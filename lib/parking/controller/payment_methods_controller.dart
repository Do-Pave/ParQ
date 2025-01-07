import 'package:get/get.dart';
import 'package:parq/app_config/generic_controller.dart';

class PaymentMethodsController extends GenericController{
  var selectedOption = "".obs;

  void selectOption(String option) {
    selectedOption.value = option;
  }
}