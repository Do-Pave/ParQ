import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parq/home/controller/recent_transactions_controller.dart';
import '../../app_config/app_colors.dart';
import '../../app_config/custom_app_bar.dart';
import '../../app_config/mains.dart';

class RecentTransactionsScreen extends GetView<RecentTransactionsController> {
  const RecentTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RecentTransactionsController());
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: ParqAppBar(
          onBackTap: () {
            Get.back();
          },
          title: "Recent transactions".tr,
        ),
        body: Obx(
          () => controller.isBusy.isTrue
              ? const Center(child: CircularProgressIndicator())
              : controller.isError.value == true
                  ? Center(
                      child: SizedBox(
                      height: 50,
                      width: Get.size.width / 3,
                      child: MainButton(
                          gradient: AppColors.homeScrGradientColor,
                          onTap: () async {
                            controller.onInit();
                          },
                          buttonText: "Reload".tr),
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
                                    child: controller.trans.isEmpty
                                        ? Center(
                                            child: Text(
                                            "No transactions available, yet."
                                                .tr,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.black),
                                          ))
                                        : recentActivity(),
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
          itemCount: controller.trans.length,
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.grey.shade300,
              thickness: 1,
            );
          },
          itemBuilder: (context, index) {
            var trans = controller.trans[index];
            return GestureDetector(
              onTap: () {
                debugPrint(index.toString());
              },
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "Referance ID : ${trans.id}".tr,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black),
                      ),
                      subtitle: Text("formatDate(trans.createdAt)",
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.grey2)),
                    ),
                  ),
                  Text(
                    "${trans.currency} ${trans.amount}",
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
