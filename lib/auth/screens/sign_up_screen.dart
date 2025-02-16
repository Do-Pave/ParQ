import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/app_colors.dart';
import 'package:parq/app_config/custom_app_bar.dart';
import 'package:parq/app_config/mains.dart';
import 'package:parq/auth/controllers/sign_up_controller.dart';
import 'package:parq/auth/screens/login_with_number_screen.dart';
import 'package:parq/auth/screens/pin_screen.dart';
import 'package:parq/home/screen/home_screen.dart';
import 'package:parq/nav%20bar/navigation_screen.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignupScreen extends GetView<SignUpController> {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpController());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: ParqAppBar(
          onBackTap: () {
            Get.back();
            debugPrint("Back");
          },
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Obx(
              () => ReactiveForm(
                formGroup: controller.form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text(
                        "Create an account".tr,
                        style:
                        const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Text(
                      'Fill your information below or register with your social account'.tr,
                      style:
                      const TextStyle(color: AppColors.grey1, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 50.0),
                    // Name
                    Text(
                      'First name'.tr,
                      style:
                      const TextStyle(color: AppColors.black, fontSize: 16),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 8.0),
                    name(),
                    const SizedBox(height: 20.0),
                    Text(
                      'Last name'.tr,
                      style:
                      const TextStyle(color: AppColors.black, fontSize: 16),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: .0),
                    lastName(),
                    const SizedBox(height: 20.0),
                    Text(
                      'Phone number'.tr,
                      style:
                      const TextStyle(color: AppColors.black, fontSize: 16),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 8.0),
                    phoneNumber(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          activeColor: AppColors.mainColor,
                          value: controller.checkValue.value,
                          onChanged: (newValue) {
                            controller.checkValue.value = newValue ?? false;
                          },
                        ),
                        // const SizedBox(width: 8), // Adjust this value to control spacing
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'Agree with '.tr,
                            style: const TextStyle(color: AppColors.black, fontSize: 16),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Terms&condition'.tr,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: AppColors.mainColor,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
// const SizedBox(height: 10,),
//                     CheckboxListTile(
//                       checkColor: Colors.white,
//                       activeColor: AppColors.mainColor,
//                       title: RichText(
//                         textAlign: TextAlign.center,
//                         text: TextSpan(
//                           text: 'Agree with '.tr,
//                           style: const TextStyle(color: AppColors.black,fontSize: 16),
//                           children: <TextSpan>[
//                             TextSpan(
//                                 text: 'Terms&condition'.tr, style: const TextStyle(fontSize: 16,color: AppColors.mainColor,decoration: TextDecoration.underline)),
//                           ],
//                         ),
//                       ),
//                       value: controller.checkValue.value,
//                       onChanged: (newValue) {
//                           controller.checkValue.value = newValue ?? false;
//                       },
//                       controlAffinity: ListTileControlAffinity.leading,
//                     ),
                    const SizedBox(height: 50.0),
                    // Sign up button
                    signUpBtn(),
                    const SizedBox(height: 50,),

                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: AppColors.grey, // Line color
                            thickness: 1,       // Line thickness
                            endIndent: 8,       // Space between line and text
                          ),
                        ),
                        Text(
                          'or sign up with '.tr,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xffA1A1A1),
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            color: AppColors.grey, // Line color
                            thickness: 1,       // Line thickness
                            indent: 8,          // Space between line and text
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(onTap:(){debugPrint("Google tapped");},child: Image.asset("assets/images/google.png",height: 40,width: 40,)),
                        const SizedBox(width: 16,),
                        GestureDetector(onTap:(){debugPrint("Facebook tapped");},child: Image.asset("assets/images/facebook.png",height: 50,width: 50,)),
                        const SizedBox(width: 16,),
                        GestureDetector(onTap:(){debugPrint("Apple tapped");},child: Image.asset("assets/images/apple.png",height: 50,width: 50,)),
                      ],
                    ),
                    const SizedBox(height: 25,),
                    login(),

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
      ),
    );
  }

  Widget name() {
    return ReactiveTextField(
      formControlName: 'firstName',
      textInputAction: TextInputAction.next,
      onSubmitted: (_) {
        controller.form.focus('lastName');
      },
      validationMessages: {
        ValidationMessage.required: (error) => 'Required',
      },
      decoration: InputDecoration(
        // labelText: 'First name',
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        hintText: 'First name',
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

  Widget lastName() {
    return ReactiveTextField(
      formControlName: 'lastName',
      textInputAction: TextInputAction.next,
      onSubmitted: (_) {
        controller.form.focus('phone');
      },
      validationMessages: {
        ValidationMessage.required: (error) => 'Required',
      },
      decoration: InputDecoration(
        // labelText: 'Last Name',
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        hintText: 'Last Name',
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

  Widget phoneNumber() {
    return ReactiveTextField(
      formControlName: 'phone',
      maxLength: 11,
      validationMessages: {
        ValidationMessage.required: (error) => 'Phone number must not be empty',
        ValidationMessage.maxLength: (error) =>
            'Phone number can\'t exceed 11 digits',
        ValidationMessage.minLength: (error) =>
            'Phone number can\'t be less than 11 digits',
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

  Widget signUpBtn() {
    return ReactiveFormConsumer(builder: (context, form, child) {
      return controller.isBusy.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox(
              height: 60,
              child: MainButton(
                // gradient: AppColors.homeScrGradientColor,
                color: form.valid && controller.checkValue.value == true ? AppColors.mainColor : Colors.grey,
                onTap: form.valid && controller.checkValue.value == true
                    ? () async {
                        await controller.signup();
                        if (controller.isDone.isTrue) {
                        debugPrint(
                            "Sign up button inside signup screen tapped");
                        Get.to(() => PinScreen(isFromLogin: false,phone: controller.phone,));
                        // Get.to(() => const NavScreen());
                        }
                      }
                    : null,
                buttonText: "Create an account",
              ),
            );
    });
  }

  Widget login() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text.rich(
        TextSpan(
            text: "${'Already have an account? '.tr} ",
            style: const TextStyle(
                color: AppColors.black,
                fontSize: 14,),
            children: [
              TextSpan(
                text: 'Sign in'.tr,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.mainColor,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    debugPrint("Sign in");
                    Get.to(() => const LoginWithNumberScreen());
                  },
              ),
            ]),
        textAlign: TextAlign.center,
      ),
    );
  }
}
