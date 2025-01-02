import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:parq/onboarding/onboarding/presentation/onboarding_screen.dart';

import '../app_config/app_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000)).then((value) async {
      // if (GetStorage().hasData('user')) {
      //   await Get.find<IAuthLocalDataSource>().loadUser();
      // Get.off(() => const Home());
      // } else {
      // Get.off(() => const SignInPage());
      // }
      Get.offAll(const OnBoarding());
      debugPrint("Splash");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: AppColors.blueWhite,
          child: Center(
            child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: SvgPicture.asset("assets/images/parqLogo.svg")),
          ),
        ));
  }
}

