import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/app_colors.dart';
import 'package:parq/app_config/custom_app_bar.dart';
import 'package:parq/app_config/mains.dart';
import 'package:parq/home/controller/home_controller.dart';
import 'package:parq/map/search_map_screen.dart';
import 'package:parq/parking/screen/nearby_parking_screen.dart';
import 'package:parq/home/screen/recent_transactions_screen.dart';
import 'package:intl/intl.dart';
import 'package:parq/map/map_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({super.key, this.savedMethodId});

  String? savedMethodId = "";

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(

      body: RefreshIndicator(
        onRefresh: () async {
          controller.getAllParking();
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 20,left: 20,top: 50),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainText(
                  text: "Location",
                  size: 16,
                  weight: FontWeight.w400,
                  color: AppColors.grey1,
                ),
                locationAndNotification(),
                const SizedBox(
                  height: 16,
                ),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    text: 'Hi, Find The '.tr,
                    style: const TextStyle(
                        color: AppColors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w500),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Best '.tr,
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: AppColors.mainColor)),
                      TextSpan(
                          text: ' Nearby '.tr,
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black)),
                      TextSpan(
                          text: 'parking Spots.'.tr,
                          style: const TextStyle(
                              color: AppColors.mainColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => SearchMapScreen());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.grey2, width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/searchIcon.svg',
                            // Path to your SVG file
                            height: 20,
                            width: 20,
                            fit: BoxFit.scaleDown,
                            color: Colors.grey, // Color of the SVG icon
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          MainText(
                            text: "Search Parking",
                            color: AppColors.textGrey,
                            size: 14,
                            weight: FontWeight.w400,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
                Container(
                  width: Get.size.width,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: MapScreen(),
                ),
                const SizedBox(
                  height: 22,
                ),
                defaultParkValet(controller),
                const SizedBox(
                  height: 22,
                ),
                mainHeaders("Nearby Parking", () {}),
                // const SizedBox(
                //   height: 10,
                // ),
                SizedBox(
                  height: 187 * 3,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: nearbyParking(),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
                mainHeaders("Popular Parking", () {}),
                const SizedBox(
                  height: 22,
                ),
                SizedBox(
                  height: 250,
                  child: Obx(
                    () => ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.allParking.length,
                      itemBuilder: (BuildContext context, int index) {
                        var parkingData = controller.allParking[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: popularParking(parkingData),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget mainHeaders(title, void Function()? onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MainText(
          text: title,
          size: 20,
          weight: FontWeight.w500,
          color: AppColors.black,
        ),
        GestureDetector(
          onTap: onTap,
          child: MainText(
            text: "See all",
            size: 16,
            weight: FontWeight.w400,
            color: AppColors.mainColor,
            underlined: true,
          ),
        ),
      ],
    );
  }

  Widget locationAndNotification() {
    return Row(
      children: [
        SvgPicture.asset(
          "assets/images/locationIcon.svg",
          color: AppColors.mainColor,
        ),
        const SizedBox(
          width: 10,
        ),
        MainText(
          text: "Cairo, Egypt",
          size: 16,
          weight: FontWeight.w400,
          color: AppColors.black,
        ),
        const SizedBox(
          width: 10,
        ),
        const Icon(Icons.keyboard_arrow_down_sharp),
        const Spacer(),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white12, width: 1)),
          child: Center(
              child: Stack(
            children: [
              SvgPicture.asset(
                "assets/images/notificationIcon.svg",
              ),
              Positioned(
                  top: 1,
                  right: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(16)),
                  ))
            ],
          )),
        )
      ],
    );
  }

  Widget defaultParkValet(controller) {
    return GestureDetector(
      onTap: (){
        Get.to(() => NearbyParkingScreen());
      },
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          // height: 260,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.grey2, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                    height: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                              viewportFraction: 1.0,
                              height: 130.0,
                              enlargeCenterPage: true,
                              onPageChanged: (index, reason) {
                                controller.updateIndex(index);
                              }),
                          items: [1, 2, 3, 4, 5].map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: Get.size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.asset(
                                    "assets/images/Frame1000005667.png",
                                    fit: BoxFit.fill,
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                        Positioned(
                          bottom: 10,
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
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.black,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset("assets/images/mainIcon.svg"),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        MainText(
                          text: "PARQ Valet",
                          size: 16,
                          weight: FontWeight.w700,
                          color: AppColors.black,
                        ),
                        MainText(
                          text: "Valet parking",
                          size: 12,
                          weight: FontWeight.w400,
                          color: AppColors.grey1,
                        )
                      ],
                    ),
                    const Spacer(),
                    Image.asset("assets/images/rightArrow.png",
                        width: 30, height: 30, color: AppColors.mainColor)
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  color: AppColors.grey2,
                  height: 1,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/locationIcon.svg",
                          color: AppColors.mainColor,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        MainText(
                          text: "60M Away",
                          size: 14,
                          weight: FontWeight.w400,
                          color: AppColors.textGrey,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset("assets/images/CarVector.svg",
                            color: AppColors.mainColor),
                        const SizedBox(
                          width: 8,
                        ),
                        MainText(
                          text: "25 Spots ",
                          size: 14,
                          weight: FontWeight.w400,
                          color: AppColors.textGrey,
                        )
                      ],
                    ),
                    Row(
                      children: [
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
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          )),
    );
  }

  Widget nearbyParking() {
    return GestureDetector(
      onTap: () {
        Get.to(() => NearbyParkingScreen());
      },
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.grey2)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                          const Spacer(),
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
          )),
    );
  }

  Widget popularParking(parkingData) {
    return GestureDetector(
      onTap: () {
        debugPrint(jsonEncode(parkingData).toString());
        Get.to(() => NearbyParkingScreen(parkingData : parkingData));
      },
      child: Container(
        width: Get.size.width / 2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.grey2)),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Stack(
                children: [
                  Image.asset(
                    "assets/images/Frame000005609.png",
                    fit: BoxFit.fill,
                    width: 170,
                    height: 95,
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: SvgPicture.asset("assets/images/non-fav.svg"),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: const Color.fromRGBO(18, 175, 152, 0.2)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MainText(
                        text:
                            " ${parkingData.spots.length.toString()} ${parkingData.spots.length < 2 ? "Spot" : "Spots"}",
                        size: 14,
                        weight: FontWeight.w400,
                        color: AppColors.mainColor,
                      ),
                    ),
                  ),
                  const Spacer(),
                  MainText(
                    text: "\$${parkingData.netPrice}",
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
                text: limitText(parkingData.parkingName, 13),
                size: 12,
                weight: FontWeight.w500,
                color: AppColors.black,
              ),
              const SizedBox(
                height: 8,
              ),
              const Divider(
                color: AppColors.grey2,
                height: 1,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset("assets/images/locationIcon.svg"),
                      const SizedBox(
                        width: 8,
                      ),
                      MainText(
                        text: "60M Away",
                        size: 10,
                        weight: FontWeight.w400,
                        color: AppColors.textGrey,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset("assets/images/CarVector.svg"),
                      const SizedBox(
                        width: 8,
                      ),
                      MainText(
                        text: "${parkingData.spots.length.toString()} spots",
                        size: 10,
                        weight: FontWeight.w400,
                        color: AppColors.textGrey,
                      )
                    ],
                  ),
                ],
              ),
            ])),
      ),
    );
  }

  String limitText(String text, int maxLength) {
    if (text.length > maxLength) {
      return '${text.substring(0, maxLength)}...';
    }
    return text;
  }
}
