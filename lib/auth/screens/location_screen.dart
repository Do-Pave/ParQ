import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/custom_app_bar.dart';
import 'package:parq/app_config/mains.dart';
import 'package:parq/auth/screens/location_manually_screen.dart';

import '../../app_config/app_colors.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

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
            Image.asset(
              "assets/images/location.png",
              width: 120,
              height: 120,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "What is Your Location?".tr,
              style: const TextStyle(
                  color: AppColors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Allow accessing your location to suggest nearby services".tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: AppColors.grey2,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 40,
            ),
            MainButton(
                color: AppColors.mainColor,
                onTap: () {
                  // Get.to(() => const VerifyIdFaceScreen());
                },
                buttonText: "Allow Location Access".tr),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                debugPrint("Enter Location Manually tapped");
                Get.to(()=> const LocationManuallyScreen());
              },
              child: Text(
                "Enter Location Manually".tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: AppColors.mainColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}
