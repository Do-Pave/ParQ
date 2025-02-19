import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/app_colors.dart';
import 'package:parq/app_config/custom_app_bar.dart';
import 'package:parq/booking/controller/return_car_controller.dart';
import 'package:parq/parking/screen/eticket_screen.dart';

import '../../app_config/mains.dart';

class ReturnCarScreen extends GetView<ReturnCarController> {
  const ReturnCarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ReturnCarController());
    return Obx(
          () => Scaffold(
        appBar: ParqAppBar(
          title: "Return Car",
          onBackTap: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.white,
        body: controller.arrived.value == true
            ? Center(
          child: MainText(
            textAlign: TextAlign.center,
            isOverflow: false,
            text: "Valet is arrived!",
            size: 26,
            weight: FontWeight.w500,
            color: AppColors.mainColor,
          ),
        )
            :SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: Column(
              children: [
                CircularCountDownTimer(
                  duration: 5,
                  initialDuration: 0,
                  controller: CountDownController(),
                  width: MediaQuery.of(context).size.width / 2,
                  height: Get.size.height / 4,
                  ringColor: Colors.grey[300]!,
                  fillColor: AppColors.mainColor,
                  backgroundColor: Colors.transparent,
                  strokeWidth: 10.0,
                  textStyle: const TextStyle(
                    fontSize: 26.0,
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  textFormat: CountdownTextFormat.HH_MM_SS,
                  isReverse: true,
                  isTimerTextShown: true,
                  autoStart: true,
                  onComplete: () {
                    // Schedule the state update after the build phase
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      controller.arrived.value = true;
                    });
                  },
                  timeFormatterFunction: (defaultFormatterFunction, duration) {
                    if (duration.inSeconds == 0) {
                      // Schedule the state update after the build phase
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        controller.arrived.value = true;
                      });
                    } else {
                      return Function.apply(defaultFormatterFunction, [duration]);
                    }
                  },
                ),
                const SizedBox(height: 25),
                Center(
                  child: MainText(
                    textAlign: TextAlign.center,
                    isOverflow: false,
                    text: "The time the car will arrive with the valet",
                    size: 18,
                    weight: FontWeight.w400,
                    color: AppColors.textGrey,
                  ),
                ),
                const SizedBox(height: 25),
                const DottedLine(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.center,
                  lineLength: double.infinity,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: AppColors.textGrey,
                  dashGapLength: 4.0,
                ),
                const SizedBox(height: 25),
                returnCarRow("Name", "Amr"),
                const SizedBox(height: 15),
                returnCarRow("Parking Area", "Blue Way City Parking "),
                const SizedBox(height: 15),
                returnCarRow("Arrival Time", "March 15 / 7:30 AM"),
                const SizedBox(height: 15),
                returnCarRow("Exit Time", "March 15 / 7:30 AM"),
                const SizedBox(height: 15),
                returnCarRow("Spot", "A17"),
                const SizedBox(height: 15),
                returnCarRow("Duration", "1 Hour"),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
        bottomNavigationBar: controller.arrived.value == true
            ? Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            height: 50,
            child: MainButton(
              color: AppColors.mainColor,
              buttonText: "View E-Ticket",
              onTap: () {
                Get.to(() => EticketScreen());
              },
            ),
          ),
        ) : null ,
      ),
    );
  }

  Widget returnCarRow(text, value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MainText(
          text: text,
          size: 18,
          weight: FontWeight.w400,
          color: AppColors.textGrey,
        ),
        MainText(
          text: value,
          size: 16,
          weight: FontWeight.w400,
          color: AppColors.black,
        ),
      ],
    );
  }
}

