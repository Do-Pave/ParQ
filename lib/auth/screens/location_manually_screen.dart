import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/app_colors.dart';
import 'package:parq/app_config/custom_app_bar.dart';
import 'package:parq/auth/controllers/location_manually_controller.dart';

class LocationManuallyScreen extends GetView<LocationManuallyController> {
  const LocationManuallyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LocationManuallyController());
    return Scaffold(
      appBar: ParqAppBar(
        title: "Enter Your Location",
        onBackTap: () {
          Get.back();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.grey, // Background color
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
              child: TextField(
                controller: controller.textController, // Bind TextEditingController
                decoration: InputDecoration(
                  hintText: "Giza",
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: InputBorder.none, // Remove default border
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: 10), // Padding inside the field
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0), // Padding for SVG icon
                    child: SvgPicture.asset(
                      'assets/images/searchIcon.svg', // Path to your SVG file
                      height: 20,
                      width: 20,
                      fit: BoxFit.scaleDown,
                      color: Colors.grey, // Color of the SVG icon
                    ),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      controller.textController.clear(); // Clear text
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0), // Padding for SVG icon
                      child: SvgPicture.asset(
                        'assets/images/clearIcon.svg', // Path to your SVG file
                        height: 20,
                        width: 20,
                        fit: BoxFit.scaleDown,
                        color: Colors.grey, // Color of the SVG icon
                      ),
                    ),
                  ),
                ),
                style: const TextStyle(color: Colors.black), // Text style
              ),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: controller.requestPermissions, // Trigger location fetch
              child: Row(
                children: [
                  SvgPicture.asset("assets/images/mapIcon.svg"),
                  const SizedBox(width: 10),
                  Text(
                    "Use my current location".tr,
                    style: const TextStyle(fontSize: 16),
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