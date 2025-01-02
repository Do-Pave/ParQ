import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/app_colors.dart';
import 'package:parq/app_config/custom_app_bar.dart';
import 'package:parq/app_config/mains.dart';
import 'package:parq/auth/controllers/verify_id_face_controller.dart';
import 'package:parq/auth/screens/bank_screen.dart';
import 'package:parq/auth/screens/success_to_start_screen.dart';

class VerifyIdFaceScreen extends GetView<VerifyIdFaceController> {
  const VerifyIdFaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(VerifyIdFaceController());
    return Scaffold(
      appBar: ParqAppBar(onBackTap: () {
        Get.back();
      }),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Let’s verify your identity".tr,
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black)),
                const SizedBox(
                  height: 15,
                ),
                Text(
                    "We’re required by law to verify your identity before we can use your money"
                        .tr,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: AppColors.grey2)),
                const SizedBox(
                  height: 100,
                ),
                cameraAnddecoration(),
                // controller.isBusy.isTrue
                //     ? const Center(child: CircularProgressIndicator())
                //     : MainButton(
                //         color: controller.isPinCompleted.value
                //             ? null
                //             : AppColors.grey2,
                //         onTap: controller.isPinCompleted.value
                //             ? () async {
                //                 debugPrint("Next");

                //                 Get.to(() => const SucessLogin());
                //               }
                //             : null,
                //         buttonText: "Next".tr),

                const Spacer(),
                MainButton(
                    gradient: AppColors.homeScrGradientColor,
                    onTap: () async {
                      debugPrint("Save tapped");

                      Get.to(() => const BankScreen());
                    },
                    buttonText: "Save".tr),

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
    );
  }

  Widget cameraAnddecoration() {
    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/images/image 4.png",
              ),
            ),
          ),
          // Top-left corner
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0), // Radius for top-left corner
                ),
                border: Border(
                  top: BorderSide(color: AppColors.grey2, width: 2),
                  left: BorderSide(color: AppColors.grey2, width: 2),
                ),
              ),
            ),
          ),
          // Top-right corner
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                  topRight:
                      Radius.circular(16.0), // Radius for top-right corner
                ),
                border: Border(
                  top: BorderSide(color: AppColors.grey2, width: 2),
                  right: BorderSide(color: AppColors.grey2, width: 2),
                ),
              ),
            ),
          ),
          // Bottom-left corner
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft:
                      Radius.circular(16.0), // Radius for top-right corner
                ),
                border: Border(
                  bottom: BorderSide(color: AppColors.grey2, width: 2),
                  left: BorderSide(color: AppColors.grey2, width: 2),
                ),
              ),
            ),
          ),
          // Bottom-right corner
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight:
                      Radius.circular(16.0), // Radius for top-right corner
                ),
                border: Border(
                  bottom: BorderSide(color: AppColors.grey2, width: 2),
                  right: BorderSide(color: AppColors.grey2, width: 2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
