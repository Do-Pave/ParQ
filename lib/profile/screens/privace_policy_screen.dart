import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/app_colors.dart';
import 'package:parq/app_config/custom_app_bar.dart';
import 'package:parq/app_config/mains.dart';

class PrivacyAndPolicyScreen extends StatelessWidget {
  const PrivacyAndPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ParqAppBar(
        onBackTap: () {
          Get.back();
        },
        title: "Privacy Policy".tr,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainText(text: "Cancelation Policy",size: 22,weight: FontWeight.w500,color: AppColors.mainColor,),
            const SizedBox(
              height: 15,
            ),
            Text(
                "Lorem ipsum dolor sit amet consectetur. Volutpat quis mauris commodo habitasse nam etiam porta venenatis enim. Vitae vitae adipiscing nulla orci ultrices ipsum a. Lobortis vulputate dignissim mattis odio eget. Vel nunc varius diam dolor justo molestie diam."
                    .tr,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.grey1)),
            const SizedBox(
              height: 35,
            ),
            MainText(text: "Terms & Condition",size: 22,weight: FontWeight.w500,color: AppColors.mainColor,),
            const SizedBox(
              height: 15,
            ),
            Text(
                "Lorem ipsum dolor sit amet consectetur. Volutpat quis mauris commodo habitasse nam etiam porta venenatis enim. Vitae vitae adipiscing nulla orci ultrices ipsum a. Lobortis vulputate dignissim mattis odio eget. Vel nunc varius diam dolor justo molestie diam."
                    .tr,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.grey1)),
          ],
        ),
      ),
    );
  }
}
