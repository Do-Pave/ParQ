import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/app_colors.dart';
import 'package:parq/app_config/custom_app_bar.dart';
import 'package:parq/app_config/mains.dart';
import 'package:parq/profile/controllers/help_center_controller.dart';

class HelpCenterScreen extends GetView<HelpCenterController> {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HelpCenterController());
    return Scaffold(
      appBar: ParqAppBar(
        title: "Help Center",
        onBackTap: () {
          Get.back();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Search Container
            Container(
              width: Get.size.width,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.grey2, width: 1),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/searchIcon.svg',
                      height: 20,
                      width: 20,
                      fit: BoxFit.scaleDown,
                      color: AppColors.mainColor,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    MainText(
                      text: "Search",
                      color: AppColors.textGrey,
                      size: 14,
                      weight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Tab Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TabBar(
                controller: controller.tabController,
                tabs: const [
                  Tab(text: "FAQ"),
                  Tab(text: "Contact Us"),
                ],
                indicatorPadding: const EdgeInsets.symmetric(horizontal: -32),
                indicatorColor: AppColors.mainColor,
                labelColor: AppColors.mainColor,
                unselectedLabelColor: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 35,
                        child: ListView.separated(
                          itemCount: 4,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) {
                            return Container(width: 10);
                          },
                          itemBuilder: (context, index) {
                            return Obx(() {
                              bool isSelected = controller.selectedIndex.value == index;

                              return GestureDetector(
                                onTap: () {
                                  controller.selectedIndex.value = index;
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isSelected ? AppColors.mainColor : AppColors.grey2,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Center(
                                      child: Text(
                                        'Container ${index + 1}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    color: Colors.green,
                    width: double.infinity,
                    height: double.infinity,
                    child: Center(child: Text('Ongoing Tab')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
