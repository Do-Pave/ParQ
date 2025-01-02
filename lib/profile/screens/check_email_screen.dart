import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/app_colors.dart';
import 'package:parq/app_config/custom_app_bar.dart';
import 'package:parq/app_config/mains.dart';
import 'package:parq/profile/controllers/reset_password_controller.dart';
import 'package:parq/profile/screens/create_new_pass_screen.dart';

class CheckEmailScreen extends GetView<ResetPasswordController> {
  const CheckEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ParqAppBar(
        onBackTap: () {
          Get.back();
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            SvgPicture.asset("assets/images/email.svg"),
            const SizedBox(
              height: 45,
            ),
            Text("Check your mail".tr,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black)),
            const SizedBox(
              height: 15,
            ),
            Text(
                "We have sent password recover\ninstructions to your email.".tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.grey2)),
            const SizedBox(
              height: 45,
            ),
            Align(
              alignment: Alignment.center,
              child: MainButton(
                  width: Get.size.width / 2,
                  onTap: () {
                    debugPrint("Open email app");
                  },
                  buttonText: "Open email app"),
            ),
            const SizedBox(
              height: 35,
            ),
            GestureDetector(
              onTap: () {
                debugPrint("skip ,I’ll confirm later tapped");
                Get.to(() => const CreateNewPassScreen());
              },
              child: Text("skip ,I’ll confirm later".tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey2)),
            ),
            const Spacer(),
            Text("Did not receive the email? Check your spam filter.".tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: AppColors.grey2)),
            Text.rich(
              TextSpan(
                  text: 'or '.tr,
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey2),
                  children: <InlineSpan>[
                    TextSpan(
                      text: 'try another email address'.tr,
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: AppColors.khardaBlue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          debugPrint('Try another email address tapped');
                        },
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
