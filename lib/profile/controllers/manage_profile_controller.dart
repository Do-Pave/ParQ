import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parq/app_config/generic_controller.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_config/app_colors.dart';
import '../../app_config/biometric_auth.dart';
import '../../app_config/biometrics_login_service.dart';
import '../../core/Generics/refresh_token_class.dart';
import '../../core/constants.dart';

class ManageProfileController extends GenericController{
  final form = FormGroup({
    'name': FormControl<String>(validators: [Validators.required]),
    'phone': FormControl<String>(validators: [
      Validators.required,
      // Validators.maxLength(8),
      // Validators.minLength(8)
    ]),
    'date': FormControl<String>(validators: [Validators.required]),
    'email': FormControl<String>(validators: [Validators.required,Validators.email]),
    'gender': FormControl<String>(validators: [Validators.required])
  });

  var selectedImagePath = ''.obs;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      selectedImagePath.value = image.path;
    }
  }

  final biometricLoginService = BiometricLoginService();

  final Dio _dio = Dio();
  Constants constants = Constants();
  RefreshTokenClass refreshToken = RefreshTokenClass();

  // Future<void> updateProfile() async {
  //   isBusy.value = true;
  //   isError.value = false;
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? token = prefs.getString("access_token");
  //   String? bunkerToken = prefs.getString("bunker_token");
  //
  //   try {
  //     final response = await _dio.put(
  //       constants.createMethodsUrl,
  //       data: {
  //         "firstName": form.control('firstName').value,
  //         "lastName": form.control('lastName').value,
  //         "bunkerToken": bunkerToken,
  //       },
  //       options: Options(
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Accept': 'application/json',
  //           if (token != null) 'Authorization': 'Bearer $token',
  //         },
  //       ),
  //     );
  //     debugPrint("Response Data: ${response.data}");
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final createMethodData = CreateMethodsModel.fromJson(response.data);
  //       if (createMethodData.success == true) {
  //         isDone.value = true;
  //       } else {
  //         isError.value = true;
  //         Get.snackbar("Error", error?.value ?? "", colorText: AppColors.black);
  //       }
  //     }
  //   } on DioException catch (e) {
  //     // Handle DioException errors
  //     if (e.response != null && e.response?.data != null) {
  //       final errorData = CreateMethodErrorModel.fromJson(e.response!.data);
  //       isError.value = true;
  //       error?.value = errorData.response?.message ?? 'An error occurred';
  //       debugPrint(error?.value);
  //       e.response!.statusCode == 401
  //           ? refreshToken.refreshToken()
  //           : Get.snackbar("Error", error?.value ?? "",
  //           colorText: AppColors.blueWhite);
  //       debugPrint("Error Value: ${error?.value}");
  //       debugPrint("Error Data: ${errorData.response}");
  //     } else {
  //       isError.value = true;
  //       error?.value = e.message ?? 'An error occurred. Please try again.';
  //       Get.snackbar("Error", error?.value ?? "", colorText: AppColors.black);
  //       debugPrint("DioException Message: ${e.message}");
  //     }
  //   } catch (e) {
  //     // Handle other exceptions
  //     isError.value = true;
  //     error?.value = 'An error occurred. Please try again.';
  //     Get.snackbar("Error", error?.value ?? "", colorText: AppColors.blueWhite);
  //     debugPrint("Generic Error: ${e.toString()}");
  //   } finally {
  //     isBusy.value = false;
  //   }
  // }
}