import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/generic_controller.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_config/app_colors.dart';
import '../../core/constants.dart';
import '../../models/error_model.dart';
import '../../models/sign_in_model.dart';

class LoginWithNumberController extends GenericController{
  final form = FormGroup({
    'phone': FormControl<String>(validators: [
      Validators.required,
      Validators.number,
      Validators.minLength(8),
      Validators.maxLength(8)
    ]),
     });


  final Dio _dio = Dio();
  Constants constants = Constants();

  Future<void> signIn() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    isBusy.value = true;
    isError.value = false;
    error?.value = "";

    try {
      final response = await _dio.post(
        constants.loginUrl,
        data: {
          // Below is phone number but saved as username in body !
          // "username": "+201060205932@example.com",
          "username": form.control('email').value,
          'password': form.control('password').value,
          // 'password': "password123",
          "client_id": "api-users",
          "grant_type": "password",
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