  import 'package:flutter/material.dart';
  import 'package:flutter_svg/svg.dart';
  import 'package:get/get.dart';
import 'package:parq/home/controller/organization/home_organization_controller.dart';
  import 'package:qr_flutter/qr_flutter.dart';

  import '../../../app_config/app_colors.dart';

  class HomeOrganizationScreen extends GetView<HomeOrganizationController> {
    const HomeOrganizationScreen({super.key});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: AppColors.blueWhite,
        body: SingleChildScrollView(
          child: Column(
            children: [
              headerRow(),
              Column(children: [
                SizedBox(
                  // color: const Color(0xffF8F9FD),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          gradient: AppColors.homeScrGradientColor,
                        ),
                        height: Get.size.height / 5,
                        width: double.infinity,
                      ),
                      Positioned(
                          top: 50, right: 80, left: 80, child: qrContainer()),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 130,
                ),
                Container(
                  color: AppColors.bgColor,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child:
                            // controller.trans.isEmpty ? Center(
                            //     child: Text(
                            //       "No transactions available, yet.".tr,
                            //       style: const TextStyle(
                            //           fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.black),
                            //     )) :
                            Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Recent Transactions".tr,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // Action for View All
                                      },
                                      child: Text(
                                        "View All".tr,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.blueUp,
                                            decoration: TextDecoration.underline,
                                            decorationColor: AppColors.blueUp),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: recentActivity(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ])
            ],
          ),
        ),
      );
    }

    Widget headerRow() {
      return Container(
        decoration: const BoxDecoration(
          gradient: AppColors.homeScrGradientColor,
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 50, right: 20, left: 20, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    width: 35,
                    height: 35,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "KHARDAH".tr,
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  )
                ],
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white12, width: 1)),
                child: Center(
                    child: Stack(
                  children: [
                    SvgPicture.asset("assets/images/notification.svg"),
                    Positioned(
                        top: 1,
                        right: 0,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                              color: AppColors.red,
                              borderRadius: BorderRadius.circular(16)),
                        ))
                  ],
                )),
              ),
              // Recent Transactions Section
            ],
          ),
        ),
      );
    }

    Widget qrContainer() {
      return Container(
        // height: Get.size.height / 2.74,
        // width: Get.size.width,
        // padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 50),
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.blueWhite,
              border: Border.all(color: AppColors.grey1),
              borderRadius: BorderRadius.circular(25)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 180,
                  child: QrImageView(
                    data: "123456789",
                    dataModuleStyle:
                        QrDataModuleStyle(color: AppColors.khardaBlue),
                    eyeStyle: QrEyeStyle(color: AppColors.khardaBlue),
                    version: QrVersions.auto,
                  ),
                ),
                const Text(
                  "My QR code" ?? "",
                  style: TextStyle(
                    color: AppColors.khardaBlue,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget recentActivity() {
      return SizedBox(
        // height: Get.size.height - 10 ,
        child: ListView.separated(
            padding: const EdgeInsets.only(bottom: 90),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
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
                    Expanded(
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          "Referance ID : trans.id".tr,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black),
                        ),
                        subtitle: Text("10-10-2025",
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.grey2)),
                      ),
                    ),
                    Text(
                      "trans.currency trans.amount",
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
