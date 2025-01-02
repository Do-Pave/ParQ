import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/app_colors.dart';
import 'package:parq/app_config/generic_controller.dart';
import 'package:pinput/pinput.dart';

class PinController extends GenericController {
  var isPinCompleted = false.obs;
  late TextEditingController pinController;

  final defaultPinTheme = PinTheme(
    width: 45,
    height: 45,
    textStyle: const TextStyle(
      fontSize: 22,
      color: AppColors.black,
    ),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.textFieldBg
    ),
  );

  String? finalPin;

  @override
  void onInit() {
    pinController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    // called just before the Controller is deleted from memory
    pinController.dispose();
  }

  // Function to check if the PIN is completed
  void checkPinCompletion(String pin) {
    isPinCompleted.value = pin.length == 5;
  }
}
