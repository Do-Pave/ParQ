import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/custom_app_bar.dart';

import '../../app_config/app_colors.dart';
import '../../app_config/mains.dart';
import 'eticket_screen.dart';

class ReviewSummaryScreen extends StatelessWidget {
  const ReviewSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ParqAppBar(
        title: "Review Summary",
        onBackTap: () {
          Get.back();
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              nearbyParking(),
              const SizedBox(
                height: 24,
              ),
              summeryRow("Arrival Time", "March 15 / 6:30 AM", AppColors.textGrey,
                  () {}),
              const SizedBox(
                height: 15,
              ),
              summeryRow(
                  "Exit Time ", "March 15 / 7:30 AM", AppColors.textGrey, () {}),
              const SizedBox(
                height: 15,
              ),
              summeryRow("Vehicle Type", "Car", AppColors.textGrey, () {}),
              const SizedBox(
                height: 15,
              ),
              summeryRow("Spot", "A1", AppColors.textGrey, () {}),
              const SizedBox(
                height: 30,
              ),
              summeryRow("Amount", "\$3.00/hr", AppColors.textGrey, () {}),
              const SizedBox(
                height: 15,
              ),
              summeryRow("Total Hours", "01:00", AppColors.textGrey, () {}),
              const SizedBox(
                height: 15,
              ),
              summeryRow("Fees", "\$2.00", AppColors.textGrey, () {}),
              const SizedBox(
                height: 15,
              ),
              summeryRow("Total", "\$5.00", AppColors.mainColor, () {}),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset("assets/images/paypal.svg"),
                  const SizedBox(
                    width: 16,
                  ),
                  MainText(
                    text: "Paypal",
                    size: 18,
                    weight: FontWeight.w400,
                    color: AppColors.textGrey,
                  ),
                  const Spacer(),
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: MainText(
                          text: "Change",
                          size: 16,
                          weight: FontWeight.w500,
                          color: AppColors.mainColor))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                height: 1,
                color: AppColors.grey2,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: 50,
          child: MainButton(
              color:AppColors.mainColor,
              buttonText: "Continue",
              onTap: () {
                debugPrint("Continue pressed");
               Get.to(() => const EticketScreen());
              },
            ),
        ),
      ),
    );
  }

  Widget summeryRow(text, value, valueColor, void Function()? onTapValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MainText(
          text: text,
          size: 18,
          weight: FontWeight.w400,
          color: AppColors.textGrey,
        ),
        GestureDetector(
            onTap: onTapValue,
            child: MainText(
                text: value,
                size: 16,
                weight: FontWeight.w400,
                color: valueColor))
      ],
    );
  }

  Widget nearbyParking() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.grey2)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          child: Row(
            children: [
              Stack(
                children: [
                  Image.asset(
                    "assets/images/Frame000005609.png",
                    fit: BoxFit.fill,
                    width: 135,
                    height: 135,
                  ),
                  Positioned(
                    top: 5,
                    left: 5,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black.withOpacity(0.8)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/images/fav.svg"),
                              const SizedBox(
                                width: 10,
                              ),
                              MainText(
                                text: "5.0",
                                size: 14,
                                weight: FontWeight.w400,
                                color: Colors.white,
                              )
                            ],
                          ),
                        )),
                  ),
                ],
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // width: Get.size.width / 3,
                      width: 117,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.grey2),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/images/carParkingIcon.svg"),
                            const SizedBox(
                              width: 8,
                            ),
                            MainText(
                              text: "Car Parking",
                              size: 14,
                              weight: FontWeight.w400,
                              color: AppColors.mainColor,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MainText(
                          text: limitText("Blue Way city Parking", 13),
                          size: 16,
                          weight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                        Container(),
                        MainText(
                          text: "\$3.00",
                          size: 14,
                          weight: FontWeight.w500,
                          color: AppColors.mainColor,
                        ),
                        MainText(
                          text: "/hr",
                          size: 14,
                          weight: FontWeight.w400,
                          color: AppColors.textGrey,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    MainText(
                      text: "78 Ali Amen  , cairo",
                      size: 14,
                      weight: FontWeight.w400,
                      color: AppColors.textGrey,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MainText(
                          text: "60M Away",
                          size: 12,
                          weight: FontWeight.w400,
                          color: AppColors.textGrey,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppColors.grey2),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MainText(
                              text: "25 Spots",
                              size: 14,
                              weight: FontWeight.w400,
                              color: AppColors.mainColor,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  String limitText(String text, int maxLength) {
    if (text.length > maxLength) {
      return '${text.substring(0, maxLength)}...';
    }
    return text;
  }
}
