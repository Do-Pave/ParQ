import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/app_colors.dart';
import 'package:parq/app_config/custom_app_bar.dart';
import 'package:parq/app_config/mains.dart';
import 'package:parq/auth/controllers/pin_controller.dart';
import 'package:parq/auth/screens/sucess_login.dart';
import 'package:parq/nav%20bar/navigation_screen.dart';
import 'package:pinput/pinput.dart';

class PinScreen extends GetView<PinController> {
   PinScreen({super.key,this.isFromLogin});
  bool? isFromLogin;
  @override
  Widget build(BuildContext context) {
    Get.put(PinController());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: ParqAppBar(onBackTap: () {
          Get.back();
        }),
        body: Obx(
          () => Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Verify Code".tr,
                      style:
                      const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 15,),
                        Text.rich(
              TextSpan(
                  text: "${'Please enter the code we just sent to number '.tr} ",
                  style: const TextStyle(
                    color: AppColors.black,
                    fontSize: 14,),
                  children: [
                    TextSpan(
                      text: '0011022200'.tr,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.green,
                      ),

                    ),
                  ]),
              textAlign: TextAlign.center,
                        ),
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
                        controller.isPinCompleted.value = pin.length == 6;
                      },
                      onCompleted: (pin) {
                        controller.isPinCompleted.value = true;
                        debugPrint(pin);
                        controller.finalPin = pin;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],),

                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Didn’t receive OTP?".tr,
                    style:
                    const TextStyle(fontSize: 16,color: AppColors.textGrey),
                  ),

                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){
                          debugPrint("Resend code tapped");
                        },
                        child: Text('Resend code'.tr,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.green,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.green
                          ),
                        ),
                      ),
                      const SizedBox(width: 16,),
                      Text(
                        "00:40".tr,
                        style:
                        const TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: AppColors.textGrey),
                      ),
                    ],
                  ),

                  const SizedBox(height: 50,),
                  // Continue button and timer
                  controller.isBusy.isTrue
                      ? const Center(child: CircularProgressIndicator())
                      : MainButton(
                      color: controller.isPinCompleted.value
                              ? AppColors.green
                              : AppColors.grey2,
                          onTap: controller.isPinCompleted.value
                              ? () async {
                                  debugPrint("Verify");
                                  isFromLogin == true ? Get.to(() => const NavScreen()) :
                                  Get.to(() => const SuccessLogin());
                                }
                              : null,
                          buttonText: isFromLogin == true ? "Verify".tr : "Verify".tr),

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
