import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/app_colors.dart';
import 'package:parq/app_config/custom_app_bar.dart';
import 'package:parq/onboarding/onboarding.dart';
import 'package:parq/profile/controllers/profile_controller.dart';
import 'package:parq/profile/screens/manage_profile_screen.dart';
import 'package:parq/profile/screens/privace_policy_screen.dart';
import 'package:parq/profile/screens/reset_password_screen.dart';
import 'package:parq/profile/screens/withdraw_requests_screen.dart';

import '../../app_config/mains.dart';
import '../../onboarding/onboarding/presentation/onboarding_screen.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return Scaffold(
        appBar: ParqAppBar(
          hasBack: false,
          title: "Profile".tr,
        ),
        backgroundColor: AppColors.bgColor,
        body: Obx(
          () => controller.isBusy.isTrue
              ? const Center(child: CircularProgressIndicator())
              : controller.isError.value == true
                  ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Session expired, please login again.".tr,
                    style: const TextStyle(
                        color: AppColors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: Get.size.width / 3,
                    child: MainButton(
                        gradient: AppColors.homeScrGradientColor,
                        onTap: () async {
                          // controller.onInit();
                          controller.biometricLoginService
                              .handleBiometricLogin<ProfileController>();
                        },
                        buttonText: "Reload".tr),
                  ),
                ],
              ))
                  : Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          nameRow(controller),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Column(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      debugPrint("Manage account");
                                      Get.to(() => const ManageProfileScreen());
                                    },
                                    child: mainProfileRows("Manage Profile",
                                        "assets/images/profile.svg")),
                                const SizedBox(
                                  height: 15,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      debugPrint("Withdraws");
                                      Get.to(() => const WithdrawRequestsScreen());
                                    },
                                    child: mainProfileRows("Withdraws",
                                        "assets/images/withdraws.svg")),
                                const SizedBox(
                                  height: 15,
                                ),
                                // GestureDetector(
                                //     onTap: () {
                                //       debugPrint("Pin");
                                //       Get.to(() => const ResetPasswordScreen());
                                //     },
                                //     child: mainProfileRows(
                                //         "Pin", "assets/images/password.svg")),
                                // const SizedBox(
                                //   height: 15,
                                // ),
                                GestureDetector(
                                    onTap: () {
                                      debugPrint("privacy & policy");
                                      Get.to(() => const PrivacyAndPolicyScreen());
                                    },
                                    child: mainProfileRows("privacy & policy",
                                        "assets/images/privacy.svg")),
                                const SizedBox(
                                  height: 15,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      debugPrint("Log out");
                                      Get.offAll(() => const OnBoarding());
                                    },
                                    child: mainProfileRows(
                                        "Log out", "assets/images/logout.svg")),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
        ));
  }

  Widget nameRow(controller) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
        children: [
          // ClipOval(
          //   child: Image.asset(
          //     "assets/images/image 4.png",
          //     width: 50,
          //     height: 50,
          //     fit: BoxFit.cover,
          //   ),
          // ),
          Expanded(
            child: ListTile(
              title: Text(
                "${controller.userData.value?.firstName} ${controller.userData.value?.lastName}",
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black),
              ),
              subtitle: Text("Last login 21 Feb,2024",
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey2)),
            ),
          ),
        ],
      ),
    );
  }

  Widget mainProfileRows(String text, String image) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(children: [
        ClipOval(
          child: SvgPicture.asset(
            image,
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.black),
          ),
        ),
        const Icon(
          Icons.arrow_forward_ios,
          size: 20,
        )
      ]),
    );
  }
}
