import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/generic_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_config/app_colors.dart';
import '../../app_config/biometrics_login_service.dart';
import '../../core/Generics/refresh_token_class.dart';
import '../../core/constants.dart';
import '../../models/error_model.dart';
import '../../models/my_transactions_model.dart';

class RecentTransactionsController extends GenericController {
  var trans = [].obs;
  final biometricLoginService = BiometricLoginService();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getMyTrans();
  }

  final Dio _dio = Dio();
  Constants constants = Constants();
  RefreshTokenClass refreshToken = RefreshTokenClass();

  Future<void> getMyTrans() async {
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

    var isUnauthorized = false;

    try {
      final response = await _dio.get(constants.myTransactionsUrl,
          options: Options(headers: headers));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final transData = MyTransactionsModel.fromJson(response.data);

        if (transData.success == true) {
          final data = transData.data?.transactions;
          trans.value = data ?? [];
          isDone.value = true;
        } else {
          isError.value = true;
          error?.value = 'Failed';
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
        debugPrint(error?.value);
        e.response!.statusCode == 401
            ? isUnauthorized = true
            : isUnauthorized = false;
        e.response!.statusCode == 401
            ? refreshToken.refreshToken()
            : Get.snackbar("Error", error?.value ?? "",
                colorText: AppColors.blueWhite);
        debugPrint("Error Value: ${error?.value}");
        debugPrint("Error Data: ${errorData.errorDescription}");
      } else {
        isError.value = true;
        error?.value = e.message ?? 'An error occurred. Please try again.';
        Get.snackbar("Error", error?.value ?? "",
            colorText: AppColors.blueWhite);
        debugPrint("DioException Message: ${e.message}");
      }
    } catch (e) {
      // Handle other exceptions
      isError.value = true;
      error?.value = 'An error occurred. Please try again.';
      Get.snackbar("Error", error?.value ?? "", colorText: AppColors.blueWhite);
      debugPrint("Generic Error: ${e.toString()}");
    } finally {
      isUnauthorized == true ? null : isBusy.value = false;
    }
  }

}
