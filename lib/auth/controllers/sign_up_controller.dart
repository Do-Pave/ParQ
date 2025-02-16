import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:parq/app_config/generic_controller.dart';
import 'package:parq/core/constants.dart';
import 'package:parq/models/error_model.dart';
import 'package:parq/models/register_model.dart';
import 'package:parq/models/sign_in_model.dart';
import 'package:parq/models/success_model.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_config/app_colors.dart';

class SignUpController extends GenericController {
  var chooseId = RxInt(0);
  var checkValue = false.obs;
  String? phone;


  final form = FormGroup({
    'firstName': FormControl<String>(validators: [Validators.required]),
    'lastName': FormControl<String>(validators: [Validators.required]),
    'phone': FormControl<String>(validators: [
      Validators.required,
      Validators.number,
      Validators.minLength(11),
      Validators.maxLength(11)
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
    isDone.value = false;

    try {
      final response = await _dio.post(
        constants.authBaseUrl + constants.signUp,
        data: {
          "firstName": form.control("firstName").value,
          "lastName": form.control("lastName").value,
          "phone": form.control("phone").value,
        },
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString("email",form.control('email').value);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final signUpData = RegisterModel.fromJson(response.data);
        prefs.setString("phone", "${signUpData.data?.phone}");
        var savedPhone = prefs.getString("phone");
        debugPrint("Saved phone is: $savedPhone");

        if (signUpData.success == true) {
          phone = savedPhone ?? "";
          isDone.value = true;
          debugPrint("Data: ${response.data}");
        } else {
          isError.value = true;
          error?.value = 'Sign up failed';
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
