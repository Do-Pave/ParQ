import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/generic_controller.dart';
import 'package:parq/models/create_booking_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_config/app_colors.dart';
import '../../core/constants.dart';
import '../../models/error_model.dart';

class PaymentMethodsController extends GenericController{
  var selectedOption = "".obs;

  void selectOption(String option) {
    selectedOption.value = option;
  }

  final Dio _dio = Dio();
  Constants constants = Constants();

  Future<void> createBooking() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("access_token");
    String? date = prefs.getString("date");
    String? parkingId = prefs.getString("parking_id");
    String? parkingSpot = prefs.getString("parking_spot");
    String? vehicleType = prefs.getString("vehicle_type");
    bool? paidReservation = prefs.getBool("paid_reservation");
    int? fees = prefs.getInt("fees");

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    isBusy.value = true;
    isError.value = false;
    error?.value = "";

    try {
      final response = await _dio.post(
          constants.parkBaseUrl +
              constants.createBooking,
          options: Options(headers: headers),
          data: {
            "bookingType": "hourly",
            "date": "2025-02-10T00:00:00.000Z",
            "arrivingTime": "2025-02-10T08:30:00.000Z",
            "exitTime": "2025-02-10T09:30:00.000Z",
            "parking": parkingId,
            "services": [0, 1],
            "parkingSpot": parkingSpot,
            "vehicleType": vehicleType,
            "fees": fees,
            "paidReservation": paidReservation
          }
      );
      debugPrint("Response Data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final createBookingData = CreateBookingModel.fromJson(response.data);

        if (createBookingData.success == true) {
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