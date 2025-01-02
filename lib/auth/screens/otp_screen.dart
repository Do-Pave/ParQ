import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:parq/app_config/app_colors.dart';
import 'package:parq/app_config/custom_app_bar.dart';
import 'package:parq/app_config/mains.dart';
import 'package:parq/auth/controllers/otp_controller.dart';
import 'package:parq/auth/screens/pin_screen.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends GetView<OtpController> {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OtpController());
    return Scaffold(
      appBar: ParqAppBar(onBackTap: () {
        Get.back();
      }),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Obx(
              () => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Write OTP number".tr,
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black)),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                      "A 5 digit code has been sent toy your number "
                          .tr,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: AppColors.grey2)),
                  const SizedBox(
                    height: 100,
                  ),
                  // Pinput field
                  Pinput(
                      obscureText: false,
                      autofocus: true,
                      length: 6,
                      // obscuringCharacter: "●",
                      defaultPinTheme: controller.defaultPinTheme,
                      controller: controller.pinController,
                      onChanged: (pin) {
                        controller.isPinCompleted.value = pin.length == 5;
                      },
                      onCompleted: (pin) {
                        controller.isPinCompleted.value = true;
                        debugPrint(pin);
                        controller.finalPin = pin;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],
                      separatorBuilder: (index) => const SizedBox(width: 20)),
                  const SizedBox(
                    height: 25,
                  ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(() => Text("00:${controller.countdown.value.toString().padLeft(2, '0')}",style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.grey),)), // Countdown text
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            if (controller.countdown.value == 0) {
                              controller.startCountdown();
                            }
                          },
                          child: Obx(() => Text(
                            "Request Again",
                            style: TextStyle(
                              color: controller.countdown.value == 0
                                  ? AppColors.khardaBlue
                                  : AppColors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                        )],
                    ),

                  const SizedBox(
                    height: 70,
                  ),

                  // Continue button and timer
                  controller.isBusy.isTrue
                      ? const Center(child: CircularProgressIndicator())
                      : MainButton(                gradient: AppColors.homeScrGradientColor,

                      color: controller.isPinCompleted.value
                          ? null
                          : AppColors.grey2,
                      onTap: controller.isPinCompleted.value
                          ? () async {
                        debugPrint("Next");

                        Get.to(() => PinScreen(isFromLogin: true));
                      }
                          : null,
                      buttonText: "Next".tr),

                  const SizedBox(height: 20),
                  if (controller.isError.isTrue) ...[
                    const SizedBox(height: 10),
                    Text(controller.error?.value ?? "Error",
                        style: const TextStyle(color: Colors.red)),
                    const SizedBox(height: 10),
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
      
    );
  }
}
