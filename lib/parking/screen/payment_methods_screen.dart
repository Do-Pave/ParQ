import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/app_colors.dart';
import 'package:parq/app_config/custom_app_bar.dart';
import 'package:parq/app_config/mains.dart';
import 'package:parq/parking/controller/payment_methods_controller.dart';
import 'package:parq/parking/screen/review_summary_screen.dart';

class PaymentMethodsScreen extends GetView<PaymentMethodsController> {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PaymentMethodsController());
    return Scaffold(
      appBar: ParqAppBar(
        title: "Payment Methods",
        onBackTap: () {
          Get.back();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainText(
                text: "Wallet",
                size: 20,
                weight: FontWeight.w500,
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() => mainRow(
                  "assets/images/walletGreen.svg",
                  "Wallet",
                  controller.selectedOption.value == "Wallet"
                      ? "assets/images/selected.svg"
                      : "assets/images/unSelected.svg")),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                height: 1,
                color: AppColors.grey2,
              ),
              const SizedBox(
                height: 20,
              ),
              MainText(
                text: "Credit & Debit Card",
                size: 20,
                weight: FontWeight.w500,
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() => mainRow(
                  "assets/images/cardGreen.svg",
                  "Add Card",
                  controller.selectedOption.value == "Add Card"
                      ? "assets/images/selected.svg"
                      : "assets/images/unSelected.svg")),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                height: 1,
                color: AppColors.grey2,
              ),
              const SizedBox(
                height: 20,
              ),
              MainText(
                text: "More Payment Options",
                size: 20,
                weight: FontWeight.w500,
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() => mainRow(
                  "assets/images/paypal.svg",
                  "Paypal",
                  controller.selectedOption.value == "Paypal"
                      ? "assets/images/selected.svg"
                      : "assets/images/unSelected.svg")),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                height: 1,
                color: AppColors.grey2,
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() => mainRow(
                  "assets/images/google.svg",
                  "Google Pay",
                  controller.selectedOption.value == "Google Pay"
                      ? "assets/images/selected.svg"
                      : "assets/images/unSelected.svg")),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                height: 1,
                color: AppColors.grey2,
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() => mainRow(
                  "assets/images/apple.svg",
                  "Apple Pay",
                  controller.selectedOption.value == "Apple Pay"
                      ? "assets/images/selected.svg"
                      : "assets/images/unSelected.svg")),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: 50,
          child: Obx(
            () => MainButton(
              color: controller.selectedOption.value != ""
                  ? AppColors.mainColor
                  : AppColors.grey2,
              buttonText: "Continue",
              onTap: () {
                debugPrint("Continue pressed");
                controller.createBooking();
                // controller.selectedOption.value != ""
                //     ? Get.to(() => const ReviewSummaryScreen())
                //     : null;
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget mainRow(String asset, String text, String selectedOrNot) {
    return GestureDetector(
      onTap: () {
        controller.selectedOption(text);
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(asset),
            const SizedBox(
              width: 16,
            ),
            MainText(
              text: text,
              size: 16,
              weight: FontWeight.w500,
              color: AppColors.textGrey,
            ),
            Expanded(
              child: Container(),
            ),
            SvgPicture.asset(selectedOrNot)
          ],
        ),
      ),
    );
  }
}
