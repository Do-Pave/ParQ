import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/generic_controller.dart';
import 'package:parq/models/create_booking_model.dart';
import 'package:parq/models/error_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_config/app_colors.dart';
import '../../core/Generics/refresh_token_class.dart';
import '../../core/constants.dart';

class ReviewSummaryController extends GenericController{

  var createBookingData = Rx<Data?>(null);

  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var bookingID = prefs.getString("booking_id");
    getTicketData(bookingID ?? "67b1e68f15cbde011465ebac");
  }
  final Dio _dio = Dio();
  Constants constants = Constants();
  RefreshTokenClass refreshToken = RefreshTokenClass();

  Future<void> getTicketData(bookingID) async {

    isBusy.value = true;
    isError.value = false;
    error?.value = "";

    try {
      final response = await _dio.get(constants.parkBaseUrl + constants.getTicket + bookingID);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final bookingModel = CreateBookingModel.fromJson(response.data);
        if (bookingModel.success == true) {
          final data = bookingModel.data;
          createBookingData.value = data;
          Get.snackbar("Warning", "WE USE A STATIC BOOKING ID TILL FINIS CREATING FROM BACKEND SIDE" ?? "", colorText: AppColors.red);
          isDone.value = true;
        } else {
          isError.value = true;
          error?.value = 'Failed';
          Get.snackbar("Error", error?.value ?? "", colorText: AppColors.black);
        }
      }
    } on DioException catch (e) {
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