import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:parq/app_config/generic_controller.dart';
import 'package:parq/core/constants.dart';
import 'package:parq/models/error_model.dart';
import 'package:parq/models/sign_in_model.dart';
import 'package:parq/models/success_model.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_config/app_colors.dart';

class SignUpController extends GenericController {
  var chooseId = RxInt(0);
  var checkValue = false.obs;


  final form = FormGroup({
    'firstName': FormControl<String>(validators: [Validators.required]),
    'lastName': FormControl<String>(validators: [Validators.required]),
    'phone': FormControl<String>(validators: [
      Validators.required,
      Validators.number,
      Validators.minLength(8),
      Validators.maxLength(8)
    ]),
  });

  final Dio _dio = Dio();
  Constants constants = Constants();

  Future<void> signup() async {
    if (!form.valid) {
      form.markAllAsTouched();
      return;
    }

    isBusy.value = true;
    isError.value = false;

    try {
      final response = await _dio.post(
        constants.baseUrl + constants.signUp,
        data: {
          "firstName": form.control("firstName").value,
          "lastName": form.control("lastName").value,
          // Below is phone number but saved as username in body !
          "username": form.control("phone").value,
          'email': form.control('email').value,
          'password': form.control('password').value,
          "enabled": true,
        },
      );
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString("email",form.control('email').value);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final signUpData = SuccessModel.fromJson(response.data);
        // prefs.setString("access_token", "${signUpData.data?.token?.accessToken}");

        if (signUpData.success == true) {
          // isDone.value = true;
          await signIn();
        } else {
          isError.value = true;
          error?.value = signUpData.data ?? 'Login failed';
          Get.snackbar("Error", error?.value ?? "", colorText: AppColors.black);
        }
      }
    } on DioException catch (e) {
      // Handle DioException errors
      if (e.response != null && e.response?.data != null) {
        final errorData = ErrorModel.fromJson(e.response!.data);
        isError.value = true;
        final responseMessages = errorData.getResponseMessages();
        error?.value = responseMessages.isNotEmpty
            ? responseMessages.join('\n')
            : 'An error occurred';
        Get.snackbar("Error", error?.value ?? "", colorText: AppColors.black);
        print("Error Value: ${error?.value}");
        print("Error Data: ${errorData.response}");
      } else {
        isError.value = true;
        error?.value = e.message ?? 'An error occurred. Please try again.';
        Get.snackbar("Error", error?.value ?? "", colorText: AppColors.black);
        print("DioException Message: ${e.message}");
      }
    } catch (e) {
      // Handle other exceptions
      isError.value = true;
      error?.value = 'An error occurred. Please try again.';
      Get.snackbar("Error", error?.value ?? "", colorText: AppColors.blueWhite);
      print("Generic Error: ${e.toString()}");
    } finally {
      // isBusy.value = false;
    }
  }

  Future<void> signIn() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final response = await _dio.post(
        constants.loginUrl,
        data: {
          // Below is phone number but saved as username in body !
          "username": form.control("email").value,
          'password': form.control('password').value,
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
