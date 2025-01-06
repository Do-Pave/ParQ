import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/generic_controller.dart';
import 'package:parq/models/error_model.dart';
import 'package:parq/models/get_profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_config/app_colors.dart';
import '../../app_config/biometrics_login_service.dart';
import '../../core/Generics/refresh_token_class.dart';
import '../../core/constants.dart';

class ProfileController extends GenericController{
  final biometricLoginService = BiometricLoginService();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // getProfile();
  }


  final Dio _dio = Dio();
  Constants constants = Constants();
  RefreshTokenClass refreshToken = RefreshTokenClass();

  Rx<Details?> userData = Rx<Details?>(null);
  Future<void> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("access_token");

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
    isBusy.value = true;
    isError.value = false;
    error?.value = "";

    try {
      final response = await _dio.get(constants.getProfile, options: Options(headers: headers));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final profileData = GetProfileModel.fromJson(response.data);

        if (profileData.success == true) {
          final data = profileData.data?.details;
          userData.value = data;
          debugPrint(userData.value?.firstName ?? "User data is null");
          isDone.value = true;
        } else {
          isError.value = true;
          error?.value = 'Failed';
          Get.snackbar("Error", error?.value ?? "", colorText: AppColors.black);
        }
      }
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        final errorData = GetProfileErrorModel.fromJson(e.response!.data);
        isError.value = true;
        error?.value = errorData.response?.message ?? 'An error occurred';
        debugPrint(error?.value);
        e.response!.statusCode == 401
            ? refreshToken.refreshToken()
            : Get.snackbar("Error", error?.value ?? "", colorText: AppColors.blueWhite);
      } else {
        isError.value = true;
        error?.value = e.message ?? 'An error occurred. Please try again.';
        Get.snackbar("Error", error?.value ?? "", colorText: AppColors.blueWhite);
      }
    } catch (e) {
      isError.value = true;
      error?.value = 'An error occurred. Please try again.';
      Get.snackbar("Error", error?.value ?? "", colorText: AppColors.blueWhite);
      debugPrint("Generic Error: ${e.toString()}");
    } finally {
      isBusy.value = false;
    }
  }


}