import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:parq/app_config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:parq/auth/screens/login_with_number_screen.dart';
import 'package:parq/auth/screens/sign_up_screen.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: AppColors.primaryColor,
        body: Padding(
      padding: const EdgeInsets.only(top: 0.0, bottom: 20, left: 0, right: 0),
      child: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [secondBody(), thirdBody(), fourthBody()],
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _currentPage >= 1
                      ? prevBtn()
                      : Container(
                          width: 50,
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < 3; i++)
                        GestureDetector(
                          onTap: () {
                            _pageController.animateToPage(i,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease);
                          },
                          child: Container(
                            width: _currentPage == i ? 14 : 10,
                            height: _currentPage == i ? 14 : 10,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: _currentPage == i
                                    ? AppColors.mainColor
                                    : AppColors.mint),
                          ),
                        ),
                    ],
                  ),
                  nextBtn()
                ],
              ),
            ],
          ),
        ],
      ),
    ));
  }

  Widget firstBody() {
    return Container(
      // color: AppColors.primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/images/onBording1.svg"),
            const SizedBox(
              height: 40,
            ),
            Text(
              'Rotating\n Peer 2 Peer Saving & Lending Club'.tr,
              style: const TextStyle(color: AppColors.grey1, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget secondBody() {
    return SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                  decoration: const BoxDecoration(
                      // color: AppColors.grey,
                      // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80),bottomRight: Radius.circular(80))
                      ),
                  width: Get.size.width,
                  child: Image.asset(
                    "assets/images/onBoarding1.png",
                    fit: BoxFit.fill,
                    height: Get.size.height / 1.8,
                  )),
              Positioned(
                top: 30,
                right: 20,
                child: GestureDetector(
                  onTap: () {
                    Get.offAll(const LoginWithNumberScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: Get.size.width,
                      child: Text(
                        "Skip".tr,
                        style: const TextStyle(
                            color: AppColors.mainColor, fontSize: 16),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'From'.tr,
                style: const TextStyle(
                    color: AppColors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
                children: <TextSpan>[
                  TextSpan(
                      text: ' You '.tr,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: AppColors.mainColor)),
                  TextSpan(
                      text: 'to Us ,'.tr,
                      style: const TextStyle(
                          color: AppColors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w500)),
                  TextSpan(
                      text: ' Parking '.tr,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: AppColors.mainColor)),
                  TextSpan(
                      text: 'Made'.tr,
                      style: const TextStyle(
                          color: AppColors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w500)),
                  TextSpan(
                      text: ' Easy '.tr,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: AppColors.mainColor)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Hand over your car ,and let us handle parking with care and convenience.'
                  .tr,
              style: const TextStyle(color: AppColors.grey1, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget thirdBody() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                  decoration: const BoxDecoration(
                      // color: AppColors.grey,
                      // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80),bottomRight: Radius.circular(80))
                      ),
                  width: Get.size.width,
                  child: Image.asset(
                    "assets/images/onBoarding2.png",
                    fit: BoxFit.fill,
                    height: Get.size.height / 1.8,
                  )),
              Positioned(
                top: 30,
                right: 20,
                child: GestureDetector(
                  onTap: () {
                    Get.offAll(const LoginWithNumberScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: Get.size.width,
                      child: Text(
                        "Skip".tr,
                        style: const TextStyle(
                            color: AppColors.mainColor, fontSize: 16),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Find'.tr,
                style: const TextStyle(
                    color: AppColors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
                children: <TextSpan>[
                  TextSpan(
                      text: ' Nearby Parking Spots '.tr,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: AppColors.mainColor)),
                  TextSpan(
                      text: 'With Ease'.tr,
                      style: const TextStyle(
                          color: AppColors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Discover stress- free parking and valet solutions with ease.'.tr,
              style: const TextStyle(color: AppColors.grey1, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget fourthBody() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(decoration: const BoxDecoration(
                // color: AppColors.grey,
                // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80),bottomRight: Radius.circular(80))
              ),width: Get.size.width,child: Image.asset("assets/images/onBoarding3.png",fit: BoxFit.fill,height: Get.size.height / 1.8,)),
              Positioned(top: 30 , right: 20,child:  GestureDetector(
                onTap: (){
                  Get.offAll(const LoginWithNumberScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: Get.size.width,
                    child: Text(
                      "Skip".tr,
                      style:
                      const TextStyle(color: AppColors.mainColor, fontSize: 16),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ),),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Give Us'.tr,
                style: const TextStyle(
                    color: AppColors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
                children: <TextSpan>[
                  TextSpan(
                      text: ' Your Car, Enjoy '.tr,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: AppColors.mainColor)),
                  TextSpan(
                      text: 'Your'.tr,
                      style: const TextStyle(
                          color: AppColors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w500)),
                  TextSpan(
                      text: ' Day!'.tr,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: AppColors.mainColor)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'With our valet service , parking is no longer your problem - it’s ours.'
                  .tr,
              style: const TextStyle(color: AppColors.grey1, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget nextBtn() {
    return GestureDetector(
      onTap: () {
        if (_currentPage < 2) {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        } else {
          // Handle what to do when on the last page
          // Get.off(() => const SignUpPage());
          Get.off(() => const LoginWithNumberScreen());
        }
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
            shape: BoxShape.circle, color: AppColors.mainColor),
        child: const Center(
          child: Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget prevBtn() {
    return GestureDetector(
      onTap: () {
        _pageController.previousPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            // color: AppColors.mainColor
            border: Border.all(color: AppColors.mainColor)),
        child: const Center(
          child: Icon(
            Icons.arrow_back,
            color: AppColors.mainColor,
          ),
        ),
      ),
    );
  }
}
