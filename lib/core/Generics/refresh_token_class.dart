import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/generic_controller.dart';
import 'package:parq/onboarding/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_config/app_colors.dart';
import '../../models/error_model.dart';
import '../../models/sign_in_model.dart';
import '../../onboarding/onboarding/presentation/onboarding_screen.dart';
import '../constants.dart';

class RefreshTokenClass extends GenericController{
  final Dio _dio = Dio();
  Constants constants = Constants();
  Future<void> refreshToken() async {
    isBusy.value = true;
    isError.value = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final refreshToken =  prefs.getString("refresh_token");
    try {
      final response = await _dio.post(
        constants.loginUrl,
        data: {
          // Below is phone number but saved as username in body !
          "client_id": "api-users",
          "refresh_token": refreshToken,
          "grant_type": "refresh_token",
          "scope": "openid",
          "client_secret": "yX8WeMlrSJIJReaGUoXdcxJvd5kNY4tH",
        },
        options: Options(
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
        ),
      );
      debugPrint("Response Data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final signInData = SignInModel.fromJson(response.data);
        prefs.setString("access_token", "${signInData.accessToken}");
        prefs.setString("refresh_token", "${signInData.refreshToken}");
        if (signInData.accessToken != null) {
          isDone.value = true;
        } else {
          isError.value = true;
          Get.snackbar("Error", error?.value ?? "", colorText: AppColors.black);
        }
      }
    } on DioException catch (e) {
      // Handle DioException errors
      if (e.response != null && e.response?.data != null) {
        final errorData = ErrorModel.fromJson(e.response!.data);
        isError.value = true;
        error?.value = errorData.errorDescription ?? 'An error occurred';
        Get.snackbar("Error", error?.value ?? "", colorText: AppColors.black);
        Get.offAll(()=> const OnBoarding());
        debugPrint("Error Value: ${error?.value}");
        debugPrint("Error Data: ${errorData.errorDescription}");
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