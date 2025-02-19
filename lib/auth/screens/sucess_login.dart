import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/app_colors.dart';
import 'package:parq/app_config/custom_app_bar.dart';
import 'package:parq/app_config/mains.dart';
import 'package:parq/auth/screens/location_screen.dart';
import 'package:parq/auth/screens/verify_id_face_screen.dart';

class SuccessLogin extends StatelessWidget {
  const SuccessLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ParqAppBar(
        onBackTap: () {
          Get.back();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              "assets/images/verified.png",color: AppColors.mainColor,
              width: 120,
              height: 120,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Verified successfully".tr,
              style: const TextStyle(
                  color: AppColors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "You have been verified successfully".tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: AppColors.grey2,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            SizedBox(
              height: 60,
              child: MainButton(
                  color: AppColors.mainColor,
                  onTap: () {
                    Get.to(() => const LocationScreen());
                  },
                  buttonText: "Continue".tr),
            )
          ],
        ),
      ),
    );
  }
}
