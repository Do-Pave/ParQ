import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/app_colors.dart';
import 'package:parq/app_config/custom_app_bar.dart';
import 'package:parq/parking/controller/nearby_parking_controller.dart';
import 'package:parq/parking/screen/booking_details_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../app_config/mains.dart';
import '../../models/all_parking_model.dart';

class NearbyParkingScreen extends GetView<NearbyParkingController> {
  NearbyParkingScreen({super.key, this.parkingData});

  AllParking? parkingData;

  @override
  Widget build(BuildContext context) {
    Get.put(NearbyParkingController());
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
            // Makes the middle column scrollable
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    SvgPicture.asset(
                                        "assets/images/carParkingIcon.svg"),
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
                              )),
                          parkingData?.reviews?.length != 0
                              ? Row(
                                  children: [
                                    const Icon(
                                      Icons.star_rounded,
                                      color: AppColors.grey1,
                                    ),
                                    MainText(
                                      text: parkingData?.reviews?.first.rate
                                              .toString() ??
                                          "",
                                      size: 14,
                                      weight: FontWeight.w400,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    MainText(
                                      text:
                                          "(${parkingData?.reviews?.length ?? 0} Reviews)",
                                      size: 14,
                                      weight: FontWeight.w400,
                                    ),
                                  ],
                                )
                              : Container()
                        ],
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.greyContainerBG,
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MainText(
                                text: parkingData?.parkingName ?? "",
                                size: 22,
                                weight: FontWeight.w500,
                                color: AppColors.black,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              MainText(
                                text: parkingData?.location?.address ?? "",
                                size: 18,
                                weight: FontWeight.w400,
                                color: AppColors.textGrey,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        text:
                                            "${parkingData?.spots?.length ?? 0} Spots Available",
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

                      // const Divider(
                      //   color: AppColors.grey2,
                      //   height: 1,
                      // ),
                      const SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        height: (parkingData?.services?.length ?? 0) * 80,
                        child: ListView.separated(
                          itemCount: parkingData?.services?.length ?? 0,
                          separatorBuilder: (context, index) => const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            var service = parkingData?.services?[index];

                            return GestureDetector(
                              onTap: () {
                                controller.updateCheckbox(service?.name ?? "", !controller.isSelected(service?.name ?? ""));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: AppColors.mainColor),
                                ),
                                height: 50,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset("assets/images/valet.svg", color: AppColors.mainColor),
                                      const SizedBox(width: 8),
                                      MainText(
                                        text: service?.name ?? "",
                                        size: 16,
                                        weight: FontWeight.w500,
                                        color: AppColors.mainColor,
                                      ),
                                      const Spacer(),
                                      Obx(() => Checkbox(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                        activeColor: AppColors.mainColor,
                                        side: MaterialStateBorderSide.resolveWith(
                                              (states) => const BorderSide(width: 1.0, color: AppColors.mainColor),
                                        ),
                                        value: controller.isSelected(service?.name ?? ""),
                                        onChanged: (bool? value) {
                                          if (value != null) {
                                            controller.updateCheckbox(service?.name ?? "", value);
                                          }
                                        },
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),


                      // GestureDetector(
                      //   onTap: () {
                      //     controller.checkbox1.value == true
                      //         ? controller.updateCheckbox(1, false)
                      //         : controller.updateCheckbox(1, true);
                      //   },
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(10),
                      //         border: Border.all(color: AppColors.mainColor)),
                      //     height: 50,
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(
                      //           right: 0, left: 20, top: 13, bottom: 13),
                      //       child: Row(
                      //         children: [
                      //           SvgPicture.asset("assets/images/valet.svg",
                      //               color: AppColors.mainColor),
                      //           const SizedBox(
                      //             width: 8,
                      //           ),
                      //           MainText(
                      //             text: "Request Valet",
                      //             size: 16,
                      //             weight: FontWeight.w500,
                      //             color: AppColors.mainColor,
                      //           ),
                      //           const Spacer(),
                      //           Obx(() => Checkbox(
                      //                 shape: RoundedRectangleBorder(
                      //                     borderRadius:
                      //                         BorderRadius.circular(5)),
                      //                 activeColor: AppColors.mainColor,
                      //                 side: MaterialStateBorderSide.resolveWith(
                      //                   (states) => const BorderSide(
                      //                       width: 1.0,
                      //                       color: AppColors.mainColor),
                      //                 ),
                      //                 value: controller.checkbox1.value,
                      //                 onChanged: (bool? value) {
                      //                   if (value != null)
                      //                     controller.updateCheckbox(1, value);
                      //                 },
                      //               )),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 24,
                      // ),
                      // GestureDetector(
                      //   onTap: () {
                      //     controller.checkbox2.value == true
                      //         ? controller.updateCheckbox(2, false)
                      //         : controller.updateCheckbox(2, true);
                      //   },
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(10),
                      //         border: Border.all(color: AppColors.mainColor)),
                      //     height: 50,
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(
                      //           right: 0, left: 20, top: 13, bottom: 13),
                      //       child: Row(
                      //         children: [
                      //           SvgPicture.asset(
                      //             "assets/images/wash.svg",
                      //             color: AppColors.mainColor,
                      //           ),
                      //           const SizedBox(
                      //             width: 8,
                      //           ),
                      //           MainText(
                      //             text: "Car wash",
                      //             size: 16,
                      //             weight: FontWeight.w500,
                      //             color: AppColors.mainColor,
                      //           ),
                      //           const Spacer(),
                      //           Obx(() => Checkbox(
                      //                 shape: RoundedRectangleBorder(
                      //                     borderRadius:
                      //                         BorderRadius.circular(5)),
                      //                 activeColor: AppColors.mainColor,
                      //                 side: MaterialStateBorderSide.resolveWith(
                      //                   (states) => const BorderSide(
                      //                       width: 1.0,
                      //                       color: AppColors.mainColor),
                      //                 ),
                      //                 value: controller.checkbox2.value,
                      //                 onChanged: (bool? value) {
                      //                   if (value != null)
                      //                     controller.updateCheckbox(2, value);
                      //                 },
                      //               )),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 24,
                      ),
                      MainText(
                        text: "Description",
                        size: 18,
                        weight: FontWeight.w500,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        parkingData?.description ?? "",
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textGrey),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MainText(
                            text: "Gallery (200)",
                            size: 18,
                            weight: FontWeight.w500,
                          ),
                          GestureDetector(
                            onTap: () {
                              debugPrint("See all gallery");
                            },
                            child: MainText(
                              text: "See all",
                              size: 16,
                              weight: FontWeight.w400,
                              color: AppColors.mainColor,
                              underlined: true,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 150,
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return Container(
                              width: 20,
                            );
                          },
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (BuildContext context, int index) {
                            return Image.asset(
                                "assets/images/Frame000005609.png");
                          },
                        ),
                      ),
                    ]),
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
              bottom: 30,
              // You can adjust this value to position the dots
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
            Positioned(
              top: 20,
              left: 10,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        // border: Border.all(color: Colors.grey.shade300),
                        color: AppColors.grey,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.black,
                      size: 24,
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
              Expanded(
                child: Column(
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
                          text: "\$${parkingData?.netPrice ?? ""}",
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
              ),
             MainButton(
                height: 50,
                color:AppColors.mainColor,
                width: Get.size.width / 3.2,
                onTap: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString("parking_id",parkingData?.sId ?? "");

                  // if (controller.selectedServices.isNotEmpty) {
                    debugPrint("Book pressed with: ${controller.selectedServices}");
                    Get.to(() => const BookingDetailsScreen());
                  // }
                },
                buttonText: "Book",
              )

            ],
          ),
        ),
    );
  }
}
