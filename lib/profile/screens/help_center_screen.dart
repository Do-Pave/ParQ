import 'package:flutter/cupertino.dart';
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
                  faq(),
                  contactUS()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget faq() {
    return SingleChildScrollView(
      child: Column(
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
                      controller.selectedIndex.value = index; // Update the selected index
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
          const SizedBox(height: 20),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 5,
            separatorBuilder: (context, index) => const Divider(height: 20,color: Colors.transparent,),
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.grey2,),

                ),
                child: const ExpansionTile(
                  iconColor: AppColors.mainColor,
                  shape: Border(),
                  collapsedIconColor: AppColors.mainColor,
                  title: Text('Can i track my order’s delivery status ?'),
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Divider(height: 1,color: AppColors.grey2,),
                    ),
                    ListTile(
                      title: Text('Lorem ipsum dolor sit amet consectetur. Nulla sodales viverra vestibulum laoreet tortor quis egestas senectus nullam.'),
                    ),
                    // ListTile(
                    //   title: Text('Expanded Content 2'),
                    // ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget contactUS() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 4,
            separatorBuilder: (context, index) => const Divider(height: 20,color: Colors.transparent,),
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.grey2,),

                ),
                child: ExpansionTile(
                  iconColor: AppColors.mainColor,
                  shape: const Border(),
                  collapsedIconColor: AppColors.mainColor,
                  leading: SvgPicture.asset("assets/images/headPhoneYellow.svg"),
                  title: const Text('Can i track my order’s delivery status ?'),
                  children: const <Widget>[
                     Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Divider(height: 1,color: AppColors.grey2,),
                    ),
                     ListTile(
                      title: Text('Lorem ipsum dolor sit amet consectetur. Nulla sodales viverra vestibulum laoreet tortor quis egestas senectus nullam.'),
                    ),
                    // ListTile(
                    //   title: Text('Expanded Content 2'),
                    // ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }



  // Widget faq() {
  //   return Column(
  //     children: [
  //       SizedBox(
  //         height: 35,
  //         child: ListView.separated(
  //           itemCount: 4,
  //           scrollDirection: Axis.horizontal,
  //           separatorBuilder: (context, index) {
  //             return Container(width: 10);
  //           },
  //           itemBuilder: (context, index) {
  //             return Obx(() {
  //               bool isSelected = controller.selectedIndex.value == index;
  //
  //               return GestureDetector(
  //                 onTap: () {
  //                   controller.selectedIndex.value = index; // Update the selected index
  //                 },
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                     color: isSelected ? AppColors.mainColor : AppColors.grey2,
  //                     borderRadius: BorderRadius.circular(20),
  //                   ),
  //                   child: Padding(
  //                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //                     child: Center(
  //                       child: Text(
  //                         'Container ${index + 1}',
  //                         style: const TextStyle(
  //                           fontSize: 18,
  //                           fontWeight: FontWeight.bold,
  //                           color: Colors.white,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               );
  //             });
  //           },
  //         ),
  //       ),
  //       const SizedBox(height: 20),
  //       Obx(() {
  //         int selectedIndex = controller.selectedIndex.value;
  //         return ListView.separated(
  //           separatorBuilder: (context, index) {
  //             return const SizedBox(height: 25);
  //           },
  //           shrinkWrap: true, // Ensures the list does not take infinite space
  //           physics: NeverScrollableScrollPhysics(),
  //           itemCount: 10,
  //           itemBuilder: (BuildContext context, int index) {
  //             bool isExpanded = index == selectedIndex;
  //             return GestureDetector(
  //               onTap: () {
  //                 controller.selectedIndex.value = isExpanded ? -1 : index;
  //               },
  //               child: AnimatedContainer(
  //                 duration: const Duration(milliseconds: 300),
  //                 curve: Curves.easeInOut, // Smooth transition
  //                 height: isExpanded ? 150 : 50,
  //                 decoration: BoxDecoration(
  //                   border: Border.all(color: AppColors.grey2),
  //                   borderRadius: BorderRadius.circular(10),
  //                 ),
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(10.0),
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     children: [
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           MainText(
  //                             text: "Can I track my order’s delivery status?",
  //                             size: 16,
  //                             weight: FontWeight.w500,
  //                           ),
  //                           Icon(
  //                             isExpanded
  //                                 ? Icons.keyboard_arrow_up_rounded
  //                                 : Icons.keyboard_arrow_down_rounded,
  //                             color: AppColors.mainColor,
  //                             size: 25,
  //                           ),
  //                         ],
  //                       ),
  //                       if (isExpanded) const SizedBox(height: 10),
  //                       if (isExpanded)
  //                         const Divider(
  //                           height: 1,
  //                           color: AppColors.grey2,
  //                         ),
  //                       if (isExpanded) const SizedBox(height: 10),
  //                       if (isExpanded)
  //                         MainText(
  //                           text:
  //                           "Lorem ipsum dolor sit amet consectetur. Nulla sodales viverra vestibulum laoreet tortor quis egestas senectus nullam.",
  //                           size: 14,
  //                           weight: FontWeight.w400,
  //                           color: AppColors.textGrey,
  //                         ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             );
  //           },
  //         );
  //       }),
  //
  //     ],
  //   );
  // }

}
