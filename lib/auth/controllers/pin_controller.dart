import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/app_colors.dart';
import 'package:parq/app_config/generic_controller.dart';
import 'package:parq/models/error_model.dart';
import 'package:parq/models/sign_in_model.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants.dart';

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

  final Dio _dio = Dio();
  Constants constants = Constants();

  Future<void> signIn(phone) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    isBusy.value = true;
    isError.value = false;
    error?.value = "";

    try {
      final response = await _dio.post(
        constants.baseUrl +
          constants.loginUrl,
          data: {
            "otp": finalPin,
            'phone': phone,
          }
      );
      debugPrint("Response Data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final signInData = LoginModel.fromJson(response.data);
        prefs.setString("access_token", "${signInData.data?.accessToken}");
        prefs.setString("refresh_token", "${signInData.data?.refreshToken}");
        if (signInData.data?.accessToken != null) {
          isDone.value = true;
        } else {
          isError.value = true;
          Get.snackbar("Error", error?.value ?? "", colorText: AppColors.black);
        }
      }
    } on DioException catch (e) {
      // Handle DioException errors
      if (e.response != null && e.response?.data != null) {
        final errorData = ParqErrorModel.fromJson(e.response!.data);
        isError.value = true;
        final responseMessages = errorData.getResponseMessages();
        error?.value = responseMessages.isNotEmpty
            ? responseMessages.join('\n')
            : 'An error occurred';
        Get.snackbar("Error", error?.value ?? "", colorText: AppColors.black);
        debugPrint("Error Value: ${error?.value}");
        debugPrint("Error Data: ${errorData.message}");
      } else {
        isError.value = true;
        error?.value = e.message ?? 'An error occurred. Please try again.';
        Get.snackbar("Error", error?.value ?? "", colorText: AppColors.black);
        debugPrint("DioException Message: ${e.message}");
      }
    } catch (e) {
      // Handle other exceptions
      isError.value = true;
      error?.value = 'An error occurred. Please try again.';
      Get.snackbar("Error", error?.value ?? "", colorText: AppColors.blueWhite);
      debugPrint("Generic Error: ${e.toString()}");
    } finally {
      isBusy.value = false;
    }
  }
}
