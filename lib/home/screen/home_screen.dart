import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/app_colors.dart';
import 'package:parq/app_config/mains.dart';
import 'package:parq/home/controller/home_controller.dart';
import 'package:parq/home/screen/recent_transactions_screen.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({super.key,this.savedMethodId});
  String? savedMethodId = "";

  @override
  Widget build(BuildContext context) {
    initializeSharedPreferences();
    Get.put(HomeController());
    return Scaffold(
      body: Column(
        children: [
          // Header Section
          headerRow(),

          // Main Scrollable Content
           Expanded(
              child: Obx(
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
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: Get.size.width / 3,
                              child: MainButton(
                                  gradient: AppColors.homeScrGradientColor,
                                  onTap: () async {
                                    // controller.onInit();
                                    controller.biometricLoginService
                                        .handleBiometricLogin<HomeController>();
                                  },
                                  buttonText: "Reload".tr),
                            ),
                          ],
                        ))
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                color: const Color(0xffF8F9FD),
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        gradient:
                                            AppColors.homeScrGradientColor,
                                      ),
                                      height: Get.size.height / 4.6,
                                      width: double.infinity,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Obx(()=> balanceContainer()),
                                    ),
                                  ],
                                ),
                              ),

                              // Recent Transactions Section
                              Container(
                                color: AppColors.bgColor,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0,vertical: 10),
                                      child: controller.trans.isEmpty ? Center(
                                          child: Text(
                                            "No transactions available, yet.".tr,
                                            style: const TextStyle(
                                                fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.black),
                                          )) : Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 2,
                                              blurRadius: 8,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Recent Transactions".tr,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      // Action for View All
                                                      Get.to(()=> const RecentTransactionsScreen());
                                                    },
                                                    child: Text(
                                                      "View All".tr,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              AppColors.blueUp,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          decorationColor:
                                                              AppColors.blueUp),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // const SizedBox(height: 15),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: recentActivity(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),  // Padding(
                                            //   padding:
                                            //       const EdgeInsets.symmetric(
                                            //           horizontal: 20),
                                            //   child: recentActivity(),
                                            // ),
                            ],
                          ),
                        ),
            ),
          ),
        ],
      ),
    );
  }

  // Future<void> initializeSharedPreferences() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String methodId = prefs.getString('savedWallet') ?? 'default';
  //   controller.savedMethodId.value = methodId;
  //   debugPrint("Controller initializeSharedPreferences ${controller.savedMethodId.value}");
  //   debugPrint("initializeSharedPreferences $methodId");
  // }
  Future<void> initializeSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accountNumber = prefs.getString('savedMethodNumber') ?? '0000000000';
    debugPrint("accountNumber: $accountNumber");
    controller.savedMethodIdNew.value = accountNumber;
    savedMethodId = accountNumber;
    debugPrint("Account Number from savedWallet: $accountNumber");
  }
  Widget balanceContainer() {
    // if (controller.wallets.isEmpty) {
    //   return Center(
    //     child: Text(
    //       "No Wallet Data Available".tr,
    //       style: const TextStyle(
    //           fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.blueWhite),
    //     ),
    //   );
    // }

    // var wallet = controller.wallets.first ?? [];
    return Container(
      // height: Get.size.height / 2.74,
      width: Get.size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.grey2, width: 0.5)),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Your balance is".tr,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.grey),
              ),
              GestureDetector(
                onTap: () {
                  // Get.to(() => const ManageAccountScreen())?.then((_) {
                  //   // This will be executed when the user navigates back from the ManageAccountScreen
                  //   initializeSharedPreferences();
                  // });
                },
                child: Text(
                  "Manage".tr,
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
          const SizedBox(height: 10),
          Text.rich(
            TextSpan(
                text: controller.wallets.isEmpty ? "0" :'\$ ${controller.wallets.first.balance}',
                style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black),
                children: <InlineSpan>[
                  TextSpan(
                    text: controller.wallets.isEmpty ? "" : " ${formatDate(controller.wallets.first.createdAt)}",
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey),
                  ),
                ]),
          ),
          controller.wallets.isEmpty ? const SizedBox(height: 0) : const SizedBox(height: 15),

          Text(
            controller.wallets.isEmpty ? "" : "Account Number".tr,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.grey),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              ClipOval(
                child: Image.asset(
                  "assets/images/visa.png",
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                controller.savedMethodIdNew.value.isEmpty ? "" : secureCardNumber(controller.savedMethodIdNew.value),
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.grey),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            color: AppColors.grey,
            height: 0.5,
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 45,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                imageWithTextButton(
                    image: "assets/images/qrBtnIc.png",
                    title: "My QR code",
                    onTap: () {
                      // Get.to(() => const MyQrScreen());
                    }),
                const SizedBox(width: 10,),
                imageWithTextButton(
                    image: "assets/images/withdraw.png",
                    title: "Withdraw  ",
                    onTap: () {
                      // Get.to(() => WithdrawScreen());
                    }),
              ],
            ),
          )
        ],
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
                      subtitle: Text(formatDate(trans.createdAt),
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
            )
          ],
        ),
      ),
    );
  }

  String formatDate(String createdAt) {
    final DateTime dateTime = DateTime.parse(createdAt);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(dateTime);
  }

  String secureCardNumber(String cardNumber) {
    return '**** **** **** ${cardNumber.substring(cardNumber.length - 4)}';
  }
}

// class HomeScreen extends GetView<HomeController> {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Stack(
//           children: [
//             Container(
//               height: Get.size.height,
//               child: Column(
//                 children: [
//                   Container(
//                     decoration: const BoxDecoration(
//                         gradient: AppColors.homeScrGradientColor),
//                     height: Get.size.height / 3,
//                     width: double.infinity,
//                   ),
//                   Container(
//                     color: Colors.white,
//                     // height: Get.size.height / 3,
//                     width: double.infinity,
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//               top: 50,
//               right: 20,
//               left: 20,
//               child: Column(
//                 children: [
//                   headerRow(),
//                   const SizedBox(
//                     height: 25,
//                   ),
//                   balanceContainer(),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Recent Activity".tr,
//                         style: const TextStyle(
//                             fontSize: 14, fontWeight: FontWeight.w400),
//                       ),
//                       Text(
//                         "View All".tr,
//                         style: const TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                             color: AppColors.blue),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   recentActivity()
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget balanceContainer() {
//     return Container(
//       height: Get.size.height / 2.74,
//       width: Get.size.width,
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(color: AppColors.grey2, width: 0.5)),
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Your balance is".tr,
//             style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w400,
//                 color: AppColors.grey),
//           ),
//           const SizedBox(height: 15),
//           Text.rich(
//             TextSpan(
//                 text: '\$ 67,897.00 '.tr,
//                 style: const TextStyle(
//                     overflow: TextOverflow.ellipsis,
//                     fontSize: 32,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.black),
//                 children: <InlineSpan>[
//                   TextSpan(
//                     text: 'Today 15 jun'.tr,
//                     style: const TextStyle(
//                         fontSize: 10,
//                         fontWeight: FontWeight.w400,
//                         color: AppColors.grey),
//                   ),
//                 ]),
//           ),
//           const SizedBox(height: 15),
//           Text(
//             "Account Number".tr,
//             style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w400,
//                 color: AppColors.grey),
//           ),
//           const SizedBox(height: 15),
//           Text(
//             secureCardNumber("123456789").tr,
//             style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w400,
//                 color: AppColors.grey),
//           ),
//           const SizedBox(height: 30),
//           Container(
//             color: AppColors.grey,
//             height: 0.5,
//           ),
//           const SizedBox(height: 20),
//           SizedBox(
//             height: 45,
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 imageWithTextButton(
//                     image: "assets/images/qrBtnIc.png",
//                     title: "My QR code",
//                     onTap: () {
//                       Get.to(() => const MyQrScreen());
//                     }),
//                 imageWithTextButton(
//                     image: "assets/images/withdraw.png",
//                     title: "Withdraw",
//                     onTap: () {
//                       Get.to(() => const WithdrawScreen());
//                     }),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget recentActivity() {
//     return SizedBox(
//       height: Get.size.height / 2.39,
//       child: ListView.builder(
//         physics: const AlwaysScrollableScrollPhysics(),
//         padding: EdgeInsets.zero,
//         shrinkWrap: true,
//         itemCount: 10,
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () {
//               debugPrint(index.toString());
//             },
//             child: Row(
//               children: [
//                 SizedBox(
//                   width: 80,
//                   child: Stack(children: [
//                     Container(
//                       decoration: BoxDecoration(
//                           border: Border.all(
//                             color: AppColors.grey1,
//                             width: 8,
//                           ),
//                           borderRadius: BorderRadius.circular(100)),
//                       child: ClipOval(
//                         child: Image.asset(
//                           "assets/images/image 4.png",
//                           width: 50,
//                           height: 50,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       right: 5,
//                       bottom: 5,
//                       child: index.isOdd
//                           ? Image.asset(
//                               "assets/images/send.png",
//                               width: 20,
//                               height: 20,
//                             )
//                           : Image.asset(
//                               "assets/images/recive.png",
//                               width: 20,
//                               height: 20,
//                             ),
//                     ),
//                   ]),
//                 ),
//                 const SizedBox(width: 10),
//                 const Expanded(
//                   child: ListTile(
//                     contentPadding: EdgeInsets.zero,
//                     title: Text(
//                       "Spotify",
//                       style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           color: AppColors.black),
//                     ),
//                     subtitle: Text("Today at 8.30 pm",
//                         style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w400,
//                             color: AppColors.grey2)),
//                   ),
//                 ),
//                 const Text(
//                   "EGP 168.00",
//                   style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: AppColors.black),
//                 ),
//                 const SizedBox(width: 10),
//                 const Icon(
//                   Icons.arrow_forward_ios_rounded,
//                   size: 18,
//                   color: AppColors.black,
//                 )
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget headerRow() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Image.asset(
//               "assets/images/logo.png",
//               width: 35,
//               height: 35,
//             ),
//             const SizedBox(
//               width: 10,
//             ),
//             Text(
//               "KHARDAH".tr,
//               style: const TextStyle(
//                   fontSize: 25,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.white),
//             )
//           ],
//         ),
//         Container(
//           width: 40,
//           height: 40,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(color: Colors.white12, width: 1)),
//           child: Center(
//               child: Stack(
//             children: [
//               SvgPicture.asset("assets/images/notification.svg"),
//               Positioned(
//                   top: 1,
//                   right: 0,
//                   child: Container(
//                     width: 8,
//                     height: 8,
//                     decoration: BoxDecoration(
//                         color: AppColors.red,
//                         borderRadius: BorderRadius.circular(16)),
//                   ))
//             ],
//           )),
//         )
//       ],
//     );
//   }

//   String secureCardNumber(String cardNumber) {
//     return '**** **** **** ${cardNumber.substring(cardNumber.length - 4)}';
//   }
// }
