import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/mains.dart';
import 'package:parq/parking/controller/booking_details_controller.dart';
import 'package:parq/parking/screen/payment_methods_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../app_config/app_colors.dart';

class BookingDetailsScreen extends GetView<BookingDetailsController> {
  const BookingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BookingDetailsController());
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              topImages(),
              Positioned(
                  bottom: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30))),
                    height: 20,
                    width: Get.size.width,
                  )),
            ],
          ), // Top section
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MainText(
                        text: "Booking Details",
                        size: 18,
                        weight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.greyContainerBG,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MainText(
                              text: "Blue Way City Parking",
                              size: 22,
                              weight: FontWeight.w500,
                              color: AppColors.black,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            MainText(
                              text: "78 Ali Amen, Cairo",
                              size: 18,
                              weight: FontWeight.w400,
                              color: AppColors.textGrey,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/images/locationIcon.svg",
                                      color: const Color(0xffC2C2C2),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    MainText(
                                      text: "60M Away",
                                      size: 16,
                                      weight: FontWeight.w400,
                                      color: AppColors.black,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        "assets/images/CarVector.svg",
                                        color: const Color(0xffC2C2C2)),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    MainText(
                                      text: "25 Spots Available",
                                      size: 16,
                                      weight: FontWeight.w400,
                                      color: AppColors.black,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() => GestureDetector(
                              onTap: () {
                                controller.updateOption(1);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color:
                                            controller.selectedOption.value == 1
                                                ? AppColors.mainColor
                                                : AppColors.textGrey)),
                                height: 50,
                                width: Get.size.width / 2.3,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 0, left: 20, top: 13, bottom: 13),
                                  child: Row(
                                    children: [
                                      MainText(
                                        text: "Hourly",
                                        size: 16,
                                        weight: FontWeight.w500,
                                        color:
                                            controller.selectedOption.value == 1
                                                ? AppColors.mainColor
                                                : AppColors.textGrey,
                                      ),
                                      const Spacer(),
                                      Obx(() => Radio<int>(
                                            value: 1,
                                            groupValue:
                                                controller.selectedOption.value,
                                            activeColor: AppColors.mainColor,
                                            fillColor: MaterialStateProperty
                                                .resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                                if (states.contains(
                                                    MaterialState.selected)) {
                                                  return AppColors
                                                      .mainColor; // Checked color
                                                }
                                                return AppColors
                                                    .textGrey; // Unchecked color
                                              },
                                            ),
                                            onChanged: (value) {
                                              if (value != null) {
                                                controller.updateOption(value);
                                              }
                                            },
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                        Obx(() => GestureDetector(
                              onTap: () {
                                controller.updateOption(2);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color:
                                            controller.selectedOption.value == 2
                                                ? AppColors.mainColor
                                                : AppColors.textGrey)),
                                height: 50,
                                width: Get.size.width / 2.3,
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 0,
                                        left: 20,
                                        top: 13,
                                        bottom: 13),
                                    child: Row(
                                      children: [
                                        MainText(
                                          text: "Daily",
                                          size: 16,
                                          weight: FontWeight.w500,
                                          color:
                                              controller.selectedOption.value ==
                                                      2
                                                  ? AppColors.mainColor
                                                  : AppColors.textGrey,
                                        ),
                                        const Spacer(),
                                        Radio<int>(
                                          value: 2,
                                          groupValue:
                                              controller.selectedOption.value,
                                          activeColor: AppColors.mainColor,
                                          fillColor: MaterialStateProperty
                                              .resolveWith<Color>(
                                            (Set<MaterialState> states) {
                                              if (states.contains(
                                                  MaterialState.selected)) {
                                                return AppColors
                                                    .mainColor; // Checked color
                                              }
                                              return AppColors
                                                  .textGrey; // Unchecked color
                                            },
                                          ),
                                          onChanged: (value) {
                                            if (value != null) {
                                              controller.updateOption(value);
                                            }
                                          },
                                        ),
                                      ],
                                    )),
                              ),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    selectDate(),
                    const SizedBox(
                      height: 24,
                    ),
                    arrivingTime(),
                  ],
                ),
              ),
            ),
          ),
          total(),
        ],
      ),
    );
  }

  Widget topImages() {
    return Container(
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                  viewportFraction: 1.0,
                  height: 300.0,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    controller.updateIndex(index);
                  }),
              items: [1, 2, 3, 4, 5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return SizedBox(
                      width: Get.size.width,
                      child: Image.asset(
                        "assets/images/Frame1000005667.png",
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            Positioned(
              top: 50,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                      // border: Border.all(color: Colors.grey.shade300),
                      color: Color(0xffD9D9D9).withOpacity(0.50),
                      borderRadius: BorderRadius.circular(16)),
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Center(
                child: Obx(
                  () => AnimatedSmoothIndicator(
                    activeIndex: controller.currentIndex.value,
                    count: 5,
                    effect: const ExpandingDotsEffect(
                      dotWidth: 12,
                      dotHeight: 8,
                      activeDotColor: AppColors.mainColor,
                      dotColor: Color(0xffE1E1E1),
                      spacing: 4,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget total() {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainText(
                  text: "Total Price",
                  size: 18,
                  weight: FontWeight.w500,
                ),
                Row(
                  children: [
                    MainText(
                      text: "\$3.00",
                      size: 14,
                      weight: FontWeight.w500,
                      color: AppColors.mainColor,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    MainText(
                      text: "/hr",
                      size: 18,
                      weight: FontWeight.w500,
                      color: AppColors.textGrey,
                    )
                  ],
                )
              ],
            ),
            Obx(
              () => MainButton(
                  height: 50,
                  color: controller.selectedDateIndex.value != (-1) ||
                          controller.selectedTimeIndex.value != (-1)
                      ? AppColors.mainColor
                      : AppColors.grey2,
                  width: Get.size.width / 3,
                  onTap: () {
                    debugPrint("Book pressed");
                    controller.selectedDateIndex.value != (-1) ||
                        controller.selectedTimeIndex.value != (-1)
                        ? Get.to(() => const PaymentMethodsScreen()): null;
                  },
                  buttonText: "Book"),
            )
          ],
        ),
      ),
    );
  }

  Widget selectDate() {
    return Container(
      width: Get.size.width,
      decoration: BoxDecoration(
          color: AppColors.greyContainerBG,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainText(
              text: "Select Date",
              size: 18,
              weight: FontWeight.w500,
              color: AppColors.black,
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 35,
              width: Get.size.width,
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Container(
                    width: 20,
                  );
                },
                scrollDirection: Axis.horizontal,
                itemCount: 24,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      debugPrint(index.toString());
                      controller.selectedTimeIndex.value = index;
                    },
                    child: Obx(
                      () => Container(
                          width: 80,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: controller.selectedTimeIndex.value == index
                                  ? AppColors.greyContainerBG
                                  : Colors.white,
                              border: Border.all(
                                  color: controller.selectedTimeIndex.value ==
                                          index
                                      ? AppColors.mainColor
                                      : Colors.white)),
                          child: Center(
                              child: MainText(
                            text: "15 Mar",
                            size: 14,
                            weight: FontWeight.w400,
                            color: controller.selectedTimeIndex.value == index
                                ? AppColors.mainColor
                                : AppColors.textGrey,
                          ))),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget arrivingTime() {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.greyContainerBG,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainText(
              text: "Arriving Time",
              size: 18,
              weight: FontWeight.w500,
              color: AppColors.black,
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 35,
              width: Get.size.width,
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Container(
                    width: 20,
                  );
                },
                scrollDirection: Axis.horizontal,
                itemCount: 24,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      debugPrint(index.toString());
                      controller.selectedDateIndex.value = index;
                    },
                    child: Obx(
                      () => Container(
                          width: 80,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: controller.selectedDateIndex.value == index
                                  ? AppColors.greyContainerBG
                                  : Colors.white,
                              border: Border.all(
                                  color: controller.selectedDateIndex.value ==
                                          index
                                      ? AppColors.mainColor
                                      : Colors.white)),
                          child: Center(
                              child: MainText(
                            text: "10:00 AM",
                            size: 14,
                            weight: FontWeight.w400,
                            color: controller.selectedDateIndex.value == index
                                ? AppColors.mainColor
                                : AppColors.textGrey,
                          ))),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
