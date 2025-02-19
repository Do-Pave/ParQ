import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parq/auth/screens/login_with_number_screen.dart';

import '../../app_config/app_colors.dart';
import '../../app_config/custom_app_bar.dart';
import '../../app_config/mains.dart';
import '../controllers/notification_controller.dart';

class NotificationScreen extends GetView<NotificationController>{
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NotificationController());
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
              "assets/images/notification.png",
              width: 120,
              height: 120,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Enable Notification Access".tr,
              style: const TextStyle(
                  color: AppColors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Enable notifications to receive real-time updates.".tr,
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
                        title: const Text("Allow notification"),
                        content: const Text("ParQ needs access to allow notification to provide better services."),
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
                              controller.requestNotificationPermission();
                            },
                            child: const Text("Allow", style: TextStyle(color: AppColors.mainColor)),
                          ),
                        ],
                      ),
                    );
                  },
                  buttonText: "Allow Notification".tr),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                debugPrint("Maybe Later");
                Get.to(()=> const LoginWithNumberScreen());
              },
              child: Text(
                "Maybe Later".tr,
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