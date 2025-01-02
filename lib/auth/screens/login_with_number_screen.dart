import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/app_colors.dart';
import 'package:parq/app_config/custom_app_bar.dart';
import 'package:parq/auth/controllers/login_with_number_controller.dart';
import 'package:parq/auth/screens/otp_screen.dart';
import 'package:parq/auth/screens/pin_screen.dart';
import 'package:parq/auth/screens/sign_up_screen.dart';
import 'package:parq/nav%20bar/navigation_screen.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../app_config/mains.dart';

class LoginWithNumberScreen extends GetView<LoginWithNumberController>{
  const LoginWithNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginWithNumberController());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        // backgroundColor: AppColors.bgColor,
        appBar: ParqAppBar(
          hasBack: false,
          // onBackTap: () {
          //   Get.back();
          //   debugPrint("Back");
          // },
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Obx(
                () => ReactiveForm(
              formGroup: controller.form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                   Text(
                    "login with a valid local Mobile number".tr,
                    style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 20.0),
                  // Phone number
                  Text(
                    'Phone number'.tr,
                    style:
                    const TextStyle(color: AppColors.black, fontSize: 16),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 8.0),
                  phoneNumber(),
                  const SizedBox(height: 30,),
                  signUp(),
                  // Submit button
                  const Spacer(),
                  submitBtn(),

                  if (controller.isError.value) ...[
                    const SizedBox(height: 20.0),
                    Text(
                      controller.error?.value ?? "Error",
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget phoneNumber() {
    return ReactiveTextField(
      formControlName: 'phone',
      maxLength: 8,
      validationMessages: {
        ValidationMessage.required: (error) => 'Phone number must not be empty',
        ValidationMessage.maxLength: (error) =>
        'Phone number can\'t exceed 8 digits',
        ValidationMessage.minLength: (error) =>
        'Phone number can\'t be less than 8 digits',
      },
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        // labelText: 'Phone number',
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        hintText: 'Ex: 01012345678',
        hintStyle: const TextStyle(
            color: AppColors.grey, fontSize: 12, fontWeight: FontWeight.w400),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.textFieldBg),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.textFieldBg),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      style: const TextStyle(
        color: Colors.black,
      ),
    );
  }

  Widget submitBtn() {
    return ReactiveFormConsumer(builder: (context, form, child) {
      return controller.isBusy.value
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : SizedBox(
        height: 60,
        child: MainButton(
          color: form.valid ? AppColors.green : Colors.grey,
          onTap: form.valid
              ? () async {

            // await controller.signIn();
            // if (controller.isDone.isTrue) {
            debugPrint(
                "Submit button tapped");
            Get.to(() => PinScreen());
            // Get.to(() => const NavScreen());
            // }
          }
              : null,
          buttonText: "Login",
        ),
      );
    });
  }

  Widget signUp() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text.rich(
        TextSpan(
            text: "${'Don\'t have an account? '.tr} ",
            style: const TextStyle(
              color: AppColors.black,
              fontSize: 14,),
            children: [
              TextSpan(
                text: 'Sign up'.tr,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.green,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    debugPrint("Sign up");
                    Get.to(() => const SignupScreen());
                  },
              ),
            ]),
        textAlign: TextAlign.center,
      ),
    );
  }
}

