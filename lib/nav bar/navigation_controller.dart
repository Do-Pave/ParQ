import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/app_colors.dart';
import 'package:parq/app_config/generic_controller.dart';
import 'package:parq/home/controller/home_controller.dart';
import 'package:parq/home/screen/home_screen.dart';
import 'package:parq/profile/screens/profile_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../app_config/biometrics_login_service.dart';
import '../home/screen/organization/home_organization_screen.dart';
import '../profile/controllers/profile_controller.dart';

class NavController extends GenericController {
  RxInt currentPage = 0.obs;
  RxInt prevPage = 0.obs;
  RxBool isSelected = false.obs;
  final biometricLoginService = BiometricLoginService();

  PersistentTabController persistentTabController =
      PersistentTabController(initialIndex: 0);

  // List of screens
  final List<Widget> screens = [
    HomeScreen(),
    // const BankAccountScreen(),
    const ProfileScreen(),
  ];

  // List of screens
  final List<Widget> organizationScreens = [
    const HomeOrganizationScreen(),
    const ProfileScreen(),
  ];

  // Corresponding icon paths and titles can be managed separately
  final List<PersistentBottomNavBarItem> items = [
    PersistentBottomNavBarItem(
      inactiveIcon:
          SvgPicture.asset("assets/images/home.svg", color: AppColors.grey2),
      icon: SvgPicture.asset("assets/images/home.svg", color: Colors.white),
      title: ("Home".tr),
      activeColorSecondary: Colors.white,
    ),
    // PersistentBottomNavBarItem(
    //   inactiveIcon: SvgPicture.asset("assets/images/accountIcon.svg",
    //       color: AppColors.grey2),
    //   icon: SvgPicture.asset("assets/images/accountIcon.svg",
    //       color: Colors.white),
    //   title: ("Accounts".tr),
    //   activeColorSecondary: Colors.white,
    // ),
    PersistentBottomNavBarItem(
      inactiveIcon:
          SvgPicture.asset("assets/images/Icon.svg", color: AppColors.grey2),
      icon: SvgPicture.asset("assets/images/Icon.svg", color: Colors.white),
      title: ("Profile".tr),
      activeColorSecondary: Colors.white,
    ),
  ];

  final List<PersistentBottomNavBarItem> organizationItems = [
    PersistentBottomNavBarItem(
      inactiveIcon:
          SvgPicture.asset("assets/images/home.svg", color: AppColors.grey2),
      icon: SvgPicture.asset("assets/images/home.svg", color: Colors.white),
      title: ("Home".tr),
      activeColorSecondary: Colors.white,
    ),
    PersistentBottomNavBarItem(
      inactiveIcon:
          SvgPicture.asset("assets/images/Icon.svg", color: AppColors.grey2),
      icon: SvgPicture.asset("assets/images/Icon.svg", color: Colors.white),
      title: ("Profile".tr),
      activeColorSecondary: Colors.white,
    ),
  ];

  bool changeScreen(int index) {
    prevPage.value = currentPage.value;
    currentPage.value = index;

    // Change the tab using the PersistentTabController
    persistentTabController.index = index;
    // Call getProfile if the Profile tab is selected
    if (index == 0) {
      final homeController = Get.find<HomeController>();
      homeController.onInit();
      // profileController.getProfile();
    }
    if (index == 1) {
      // final bankAccountsController = Get.find<BankAccountsController>();
      // bankAccountsController.onInit();
      // profileController.getProfile();
    }
    if (index == 2) {
      final profileController = Get.find<ProfileController>();
      profileController.getProfile();
    }
    return true;
  }
}
