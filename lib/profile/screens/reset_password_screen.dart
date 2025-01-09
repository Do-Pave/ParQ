import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/app_colors.dart';
import 'package:parq/app_config/custom_app_bar.dart';
import 'package:parq/app_config/mains.dart';
import 'package:parq/auth/screens/otp_screen.dart';
import 'package:parq/profile/controllers/reset_password_controller.dart';
import 'package:parq/profile/screens/check_email_screen.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ResetPasswordScreen extends GetView<ResetPasswordController> {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ResetPasswordController());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: ReactiveForm(
        formGroup: controller.form,
        child: Scaffold(
          appBar: ParqAppBar(
            onBackTap: () {
              Get.back();
            },
            title: "Manage profile".tr,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Obx(
                    () => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Current Password'.tr,
                      style:
                      const TextStyle(color: AppColors.black, fontSize: 16),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 8.0),
                    currentPassword(),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        const Spacer(),
                        MainText(
                          text: "Forgot Password",
                          size: 16,
                          weight: FontWeight.w400,
                          color: AppColors.mainColor,
                          underlined: true,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      'New Password'.tr,
                      style:
                      const TextStyle(color: AppColors.black, fontSize: 16),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 8.0),
                    newPassword(),
                    const SizedBox(height: 20.0),
                    Text(
                      'Confirm New Password'.tr,
                      style:
                      const TextStyle(color: AppColors.black, fontSize: 16),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 8.0),
                    confirmNewPassword(),
                    const SizedBox(height: 20.0),

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
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20.0),
            child: saveBtn(),
          ),
        ),
      ),
    );
  }

  Widget currentPassword() {
    return Obx(() {
      return ReactiveTextField(
        formControlName: 'currentPassword',
        obscureText: controller.isCurrentPasswordVisible.value,
        textInputAction: TextInputAction.next,
        onSubmitted: (_) {
          controller.form.focus('newPassword');
        },
        validationMessages: {
          ValidationMessage.required: (error) => 'Current Password must not be empty',
        },
        decoration: InputDecoration(
          hintText: '**********',
          hintStyle: const TextStyle(
              color: AppColors.grey, fontSize: 12, fontWeight: FontWeight.w400),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          fillColor: AppColors.grey,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10.0),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              controller.isCurrentPasswordVisible.value
                  ? Icons.visibility
                  : Icons.visibility_off,
            ),
            onPressed: () {
              controller.toggleCurrentPasswordVisibility();
            },
          ),
        ),
        style: const TextStyle(color: Colors.black),
      );
    });
  }

  Widget newPassword() {
    return Obx(() {
      return ReactiveTextField(
        formControlName: 'newPassword',
        obscureText: controller.isNewPasswordVisible.value,
        validationMessages: {
          ValidationMessage.required: (error) => 'Password must not be empty'
        },
        decoration: InputDecoration(
          hintText: '**********',
          hintStyle: const TextStyle(
              color: AppColors.grey, fontSize: 12, fontWeight: FontWeight.w400),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          fillColor: AppColors.grey,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.textFieldBg),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.textFieldBg),
            borderRadius: BorderRadius.circular(10.0),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              controller.isNewPasswordVisible.value
                  ? Icons.visibility
                  : Icons.visibility_off,
            ),
            onPressed: () {
              controller.toggleNewPasswordVisibility();
            },
          ),
        ),
        style: const TextStyle(color: Colors.black),
      );
    });
  }

  Widget confirmNewPassword() {
    return Obx(() {
      return ReactiveTextField(
        formControlName: 'confirmNewPass',
        obscureText: controller.isConfirmPasswordVisible.value,
        textInputAction: TextInputAction.next,
        validationMessages: {
          ValidationMessage.required: (error) => 'Password must not be empty',
        },
        decoration: InputDecoration(
          hintText: '**********',
          hintStyle: const TextStyle(
              color: AppColors.grey, fontSize: 12, fontWeight: FontWeight.w400),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          fillColor: AppColors.grey,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10.0),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              controller.isConfirmPasswordVisible.value
                  ? Icons.visibility
                  : Icons.visibility_off,
            ),
            onPressed: () {
              controller.toggleConfirmPasswordVisibility();
            },
          ),
        ),
        style: const TextStyle(color: Colors.black),
      );
    });
  }



  Widget saveBtn() {
    return ReactiveFormConsumer(builder: (context, form, child) {
      return controller.isBusy.value
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : SizedBox(
        height: 60,
        child: MainButton(
          color: form.valid ?  AppColors.mainColor : Colors.grey,
          onTap: form.valid
              ? () async {
            // await controller.login();
            // if (controller.isDone.isTrue) {
            //   Get.offAllNamed(RouteNames.homePageName);
            // }

            // if (controller.isDone.isTrue) {
            debugPrint(
                "Sign up button inside signup screen tapped");
            // Get.to(() => const PinScreen());
            // }
          }
              : null,
          buttonText: "Update password",
        ),
      );
    });
  }
}

