import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../app_config/app_colors.dart';
import '../../app_config/custom_app_bar.dart';
import '../../app_config/mains.dart';
import '../controllers/Withdraw_requests_controller.dart';

class WithdrawRequestsScreen extends GetView<WithdrawRequestsController>{
  const WithdrawRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(WithdrawRequestsController());
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: ParqAppBar(
          onBackTap: () {
            Get.back();
          },
          title: "Withdraws requests".tr,
        ),
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
                      const SizedBox(height: 20,),
                      SizedBox(
                        width: Get.size.width / 3,
                        child: MainButton(
                            gradient: AppColors.homeScrGradientColor,
                            onTap: () async {
                              // controller.onInit();
                              controller.biometricLoginService.handleBiometricLogin<WithdrawRequestsController>();
                            },
                            buttonText: "Reload".tr),
                      ),
                    ],
                  ))
              : Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        color: AppColors.bgColor,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                // horizontal: 20.0,
                                  vertical: 10),
                              child:
                              // controller.trans.isEmpty
                              //     ? Center(
                              //     child: Text(
                              //       "No transactions available, yet."
                              //           .tr,
                              //       style: const TextStyle(
                              //           fontSize: 16,
                              //           fontWeight: FontWeight.w400,
                              //           color: AppColors.black),
                              //     ))
                              //     :
                              recentActivity(),
                            ),
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ));
  }

  Widget recentActivity() {
    return SizedBox(
      // height: Get.size.height - 10 ,
      child: ListView.separated(
        // padding: const EdgeInsets.only(bottom: 90),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          // itemCount: controller.trans.length,
          itemCount: 10,
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.grey.shade300,
              thickness: 1,
            );
          },
          itemBuilder: (context, index) {
            // var trans = controller.trans[index];
            return GestureDetector(
              onTap: () {
                debugPrint(index.toString());
              },
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  ClipOval(
                    child: Image.asset(
                      "assets/images/image 4.png",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),

                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "Referance ID : 132156465".tr,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black),
                      ),
                      subtitle:  Row(
                        children: [
                          // const Text("formatDate(trans.createdAt)",
                          const Text("22/12/2024",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.grey2)),
                          const SizedBox(width:20),
                          Container(
                            height: 20,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.mainColor
                            ),
                            child: Center(child: Text("Success".tr,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.black)),),
                          )
                        ],
                      ),
                    ),
                  ),
                  Text(
                    // "${trans.currency} ${trans.amount}",
                    "USD 100",
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black),
                  ),
                ],
              ),
            );
          }),
    );
  }
}