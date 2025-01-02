import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/app_colors.dart';
import 'package:parq/onboarding/onboarding/presentation/onboarding_screen.dart';

class PreOnboardingPage extends StatelessWidget {
  const PreOnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 40.0, bottom: 20, left: 40, right: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  child: Image.asset("assets/images/logo.png")),
              Center(
                child: Column(
                  children: [
                    SvgPicture.asset("assets/images/onBording1.svg"),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Rotating\n Peer 2 Peer Saving & Lending Club'.tr,
                      style:
                          const TextStyle(color: AppColors.grey1, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              lastRow()
            ],
          ),
        ),
      ),
    );
  }

  Widget lastRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Get Started".tr,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.blueWhite),
        ),
        nextBtn()
      ],
    );
  }

  Widget nextBtn() {
    return GestureDetector(
      onTap: () {
        Get.off(() => const OnBoarding());
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Color(0xFF387CFF),
              Color(0xFF4D60E7),
              Color(0xFF6145D0),
            ],
            stops: [0, 0.16, 1],
          ),
        ),
        child: const Center(
          child: Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
