import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/app_colors.dart';
import 'package:parq/app_config/custom_app_bar.dart';
import 'package:parq/booking/controller/my_booking_controller.dart';
import 'package:parq/booking/screen/return_car_screen.dart';

import '../../app_config/mains.dart';

class MyBookingScreen extends GetView<MyBookingController> {
  const MyBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Instantiating the controller with Get.put (only once)
    Get.put(MyBookingController());

    return Scaffold(
      appBar: ParqAppBar(
        title: "My Booking",
        hasBack: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TabBar(
                controller: controller.tabController,
                tabs: const [
                  Tab(text: "Ongoing"),
                  Tab(text: "Completed"),
                  Tab(text: "Cancelled"),
                ],
                indicatorPadding: const EdgeInsets.symmetric(horizontal: -32),
                indicatorColor: AppColors.mainColor,
                labelColor: AppColors.mainColor,
                unselectedLabelColor: Colors.grey,
              ),
            ),
            SizedBox(
              height: Get.size.height ,
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  Flexible(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 280),
                      itemCount: 35,
                      itemBuilder: (context, index) {
                        return booking("Timer","E-Ticket",(){
                          debugPrint("Timer pressed");
                        },(){
                          debugPrint("E-Ticket pressed");
                          Get.to(()=> const ReturnCarScreen());
                        });
                      },
                    ),
                  ),
                  // booking(),
                  Flexible(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 280),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return booking("Re-Book","E-Ticket",(){
                          debugPrint("Re-Book pressed");
                        },(){
                          debugPrint("E-Ticket pressed");
                        });
                      },
                    ),
                  ),
                 const Center(child:  Text("There are no cancelled bookings!"),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget booking(firstBtnTitle,secondBtnTitle,onTapFirstBtn,onTapSecondBtn) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.grey2)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/images/Frame000005609.png",
                      fit: BoxFit.fill,
                      width: 135,
                      height: 135,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // width: Get.size.width / 3,
                          width: 117,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppColors.greyContainerBG),
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
                        MainText(
                          text: limitText("Blue Way city Parking", 30),
                          size: 16,
                          weight: FontWeight.w500,
                          color: AppColors.black,
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            ),
                          ],
                        ),
                        Container(
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(18, 175, 152, 0.2),
                          borderRadius: BorderRadius.circular(10)
                        ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("With valet".tr),
                          ),)
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 15,),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width:Get.size.width / 2.6,child: MainButton(textSize: 14,textFont: FontWeight.w400,height: 40,onTap: onTapFirstBtn, buttonText: firstBtnTitle,color: AppColors.greyContainerBG,textColor: AppColors.mainColor,)),
                  SizedBox(width:Get.size.width / 2.6,child: MainButton(textSize: 14,textFont: FontWeight.w400,height: 40,onTap: onTapSecondBtn, buttonText: secondBtnTitle,color: AppColors.mainColor,textColor: Colors.white,)),
                ],)
              ],
            ),
          )),
    );
  }

  String limitText(String text, int maxLength) {
    if (text.length > maxLength) {
      return '${text.substring(0, maxLength)}...';
    }
    return text;
  }

}
