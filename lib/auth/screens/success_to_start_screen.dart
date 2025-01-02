import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/app_colors.dart';
import 'package:parq/app_config/mains.dart';
import 'package:parq/nav%20bar/navigation_screen.dart';

class SuccessToStartScreen extends StatelessWidget {
  const SuccessToStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            SvgPicture.asset("assets/images/success.svg"),
            const SizedBox(
              height: 50,
            ),
            Text(
              "successfully verified by Hawity ".tr,
              style: const TextStyle(
                  color: AppColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset("assets/images/hawaity.png"),
            const SizedBox(
              height: 50,
            ),
            const Spacer(),
            MainButton(
                gradient: AppColors.homeScrGradientColor,
                onTap: () {
                  Get.offAll(() => const NavScreen());
                },
                buttonText: "Start now".tr)
          ],
        ),
      ),
    );
  }
}
