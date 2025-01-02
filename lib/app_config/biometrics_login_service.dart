import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:parq/onboarding/onboarding.dart';
import 'package:parq/onboarding/onboarding/presentation/onboarding_screen.dart';

import '../auth/screens/login_with_number_screen.dart';
import '../core/Generics/refresh_token_class.dart';
import 'biometric_auth.dart';

class BiometricLoginService {
  final RefreshTokenClass refreshToken = RefreshTokenClass();

  Future<void> handleBiometricLogin<T extends GetxController>() async {
    final biometricAuth = BiometricAuth();
    final bool canCheckBiometrics = await biometricAuth.canCheckBiometrics();

    if (canCheckBiometrics) {
      final bool isAuthenticated = await biometricAuth.authenticate();

      if (isAuthenticated) {
        refreshToken.refreshToken();

        // Get the instance of the controller and call its onInit
        final controller = Get.find<T>();
        controller.onInit();

        // Check if the controller is registered
        if (Get.isRegistered<T>()) {
          try {
            // Attempt to find the controller and call onInit
            final controller = Get.find<T>();
            controller.onInit.call();
          } catch (e) {
            debugPrint("Error calling onInit: $e");
            Get.offAll(() => const OnBoarding());
          }
        } else {
          debugPrint("Controller of type $T is not registered");
          Get.offAll(() => const OnBoarding());
        }
      } else {
        debugPrint("Authentication failed");
        Get.offAll(() => const OnBoarding());
      }
    } else {
      debugPrint("Biometrics are not available");
      Get.offAll(() => const OnBoarding());
    }
  }
}