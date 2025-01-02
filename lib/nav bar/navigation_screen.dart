import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/app_colors.dart';
import 'package:parq/nav%20bar/navigation_controller.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class NavScreen extends GetView<NavController> {
  const NavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NavController());

    return Obx(
          () {
        return Scaffold(
          body: controller.isBusy.isTrue
              ? const Center(child: CircularProgressIndicator())
              : PersistentTabView(
            context,
            decoration: NavBarDecoration(borderRadius: BorderRadius.circular(50),boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // Shadow color
                spreadRadius: 5, // Spread of the shadow
                blurRadius: 15, // Blur radius
                offset: Offset(0, 4), // Position of the shadow
              ),
            ],),
            margin: const EdgeInsets.all(10),
            controller: controller.persistentTabController,
            screens: controller.screens,
            items: controller.items,
            // screens: controller.organizationScreens,
            // items: controller.organizationItems,
            backgroundColor: Colors.white,
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: true,
            stateManagement: true,
            navBarHeight: 75,
            navBarStyle: NavBarStyle.style7,
            onItemSelected: (index) {
              controller.changeScreen(index);
            },
          ),

        );
      },
    );
  }
}