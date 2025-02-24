import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/custom_app_bar.dart';
import 'package:parq/app_config/mains.dart';
import 'package:parq/auth/screens/location_manually_screen.dart';
import 'package:parq/auth/screens/login_with_number_screen.dart';
import 'package:parq/auth/screens/notification_screen.dart';

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
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 60,
              child: MainButton(
                  color: AppColors.mainColor,
                  onTap: () {
                    Get.dialog(
                      AlertDialog(
                        title: const Text("Location Access Required"),
                        content: const Text("ParQ needs access to your location to provide better services."),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Get.back(); // Close the dialog
                            },
                            child: const Text("Cancel", style: TextStyle(color: Colors.grey),),
                          ),
                          TextButton(
                            onPressed: () async {
                              Get.back();
                              requestLocationPermission();
                            },
                            child: const Text("Allow", style: TextStyle(color: AppColors.mainColor)),
                          ),
                        ],
                      ),
                    );
                  },
                  buttonText: "Allow Location Access".tr),
            ),
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

  Future<void> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
        "Permission Denied",
        "Location access is permanently denied. Enable it from settings.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      Get.snackbar(
        "Permission Granted",
        "You can now use location-based features!",
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.to(()=> const NotificationScreen());
    }
  }

}
