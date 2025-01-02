import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/app_colors.dart';
import 'package:parq/app_config/generic_controller.dart';
import 'package:pinput/pinput.dart';

class OtpController extends GenericController{
  var isPinCompleted = false.obs;
  late TextEditingController pinController;
  var countdown = 5.obs;
  Timer? _timer;

  final defaultPinTheme = const PinTheme(
    width: 66,
    height: 66,
    textStyle: TextStyle(
      fontSize: 22,
      color: AppColors.black,
    ),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: AppColors.grey2, width: 2)),
    ),
  );

  String? finalPin;

  @override
  void onInit() {
    pinController = TextEditingController();
    startCountdown();
    super.onInit();
  }

  void startCountdown() {
    countdown.value = 5;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void onClose() {
    // called just before the Controller is deleted from memory
    _timer?.cancel();
    pinController.dispose();
  }

  // Function to check if the PIN is completed
  void checkPinCompletion(String pin) {
    isPinCompleted.value = pin.length == 5;
  }
}