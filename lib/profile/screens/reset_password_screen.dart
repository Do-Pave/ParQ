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
            title: "Reset PIN".tr,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Reset password".tr,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black)),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                      "Enter the email associated with your account and we’ll send an email with instructions to reset your password"
                          .tr,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey2)),
                  const SizedBox(
                    height: 30,
                  ),
                  phoneNumber(),
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
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20.0),
            child: sendBtn(),
          ),
        ),
      ),
    );
  }

  Widget phoneNumber() {
    return ReactiveTextField(
      formControlName: 'phone',
      textInputAction: TextInputAction.next,
      onSubmitted: (_) {
        controller.form.focus('id');
      },
      validationMessages: {
        ValidationMessage.required: (error) => 'Phone number must not be empty',
        ValidationMessage.maxLength: (error) =>
        'Phone number can\'t exceed 11 digits',
        ValidationMessage.minLength: (error) =>
        'Phone number can\'t be less than 11 digits',
      },
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: 'Phone number',
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        hintText: 'Ex: 01012345678',
        hintStyle: const TextStyle(
            color: AppColors.grey, fontSize: 12, fontWeight: FontWeight.w400),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.grey1),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.grey1),
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      style: const TextStyle(
        color: Colors.black,
      ),
    );
  }


  Widget sendBtn() {
    return ReactiveFormConsumer(builder: (context, form, child) {
      return controller.isBusy.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox(
              height: 60,
              child: MainButton(
                gradient: AppColors.homeScrGradientColor,
                color: form.valid ? null : Colors.grey,
                onTap: form.valid
                    ? () async {
                        // await controller.login();
                        // if (controller.isDone.isTrue) {
                        //   Get.offAllNamed(RouteNames.homePageName);
                        // }

                        // if (controller.isDone.isTrue) {
                        debugPrint("Send button tapped");
                        Get.to(() => const OtpScreen());
                        // }
                      }
                    : null,
                buttonText: "Send code",
              ),
            );
    });
  }
}
