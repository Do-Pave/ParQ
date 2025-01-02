import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/app_colors.dart';
import 'package:parq/app_config/custom_app_bar.dart';
import 'package:parq/app_config/mains.dart';
import 'package:parq/profile/controllers/create_new_pass_controller.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CreateNewPassScreen extends GetView<CreateNewPassController> {
  const CreateNewPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CreateNewPassController());
    return ReactiveForm(
      formGroup: controller.form,
      child: Scaffold(
        appBar: ParqAppBar(onBackTap: () {
          Get.back();
        }),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text("Create new password".tr,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black)),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                        "Your new password must be different from previous used passwords."
                            .tr,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.grey2)),
                    const SizedBox(
                      height: 35,
                    ),
                    password(),
                    const SizedBox(
                      height: 35,
                    ),
                    confirmPassword()
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: resetPassBtn(),
        ),
      ),
    );
  }

  Widget password() {
    return ReactiveTextField(
      formControlName: 'password',
      textInputAction: TextInputAction.next,
      onSubmitted: (_) {
        controller.form.focus('confirmPassword');
      },
      validationMessages: {
        ValidationMessage.required: (error) => 'Password must not be empty',
        ValidationMessage.minLength: (error) =>
            "The minimum length must be at least 8 characters."
      },
      obscureText: controller.passwordObscureText.value,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        suffixIcon: GestureDetector(
            onTap: () {
              debugPrint("Show and hide pass for password");
              controller.passwordObscureText.value =
                  !controller.passwordObscureText.value;
            },
            child: controller.passwordObscureText.isTrue
                ? const Icon(Icons.visibility)
                : const Icon(Icons.visibility_off)),
        hintText: 'Password',
        hintStyle: const TextStyle(
            color: AppColors.grey, fontSize: 12, fontWeight: FontWeight.w400),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.grey1),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.grey1),
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      style: const TextStyle(
        color: Colors.black,
      ),
    );
  }

  Widget confirmPassword() {
    return ReactiveTextField(
      obscureText: controller.confirmPasswordObscureText.value,
      formControlName: 'confirmPassword',
      validationMessages: {
        ValidationMessage.required: (error) =>
            'Confirm password must not be empty',
        ValidationMessage.mustMatch: (error) =>
            "Password and confirm password must match"
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Confirm password',
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        suffixIcon: GestureDetector(
            onTap: () {
              debugPrint("Show and hide pass for confirm password");
              controller.confirmPasswordObscureText.value =
                  !controller.confirmPasswordObscureText.value;
            },
            child: controller.confirmPasswordObscureText.isTrue
                ? const Icon(Icons.visibility)
                : const Icon(Icons.visibility_off)),
        hintText: 'Confirm password',
        hintStyle: const TextStyle(
            color: AppColors.grey, fontSize: 12, fontWeight: FontWeight.w400),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.grey1),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.grey1),
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      style: const TextStyle(
        color: Colors.black,
      ),
    );
  }

  Widget resetPassBtn() {
    return ReactiveFormConsumer(builder: (context, form, child) {
      return controller.isBusy.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox(
              height: 60,
              child: MainButton(
                color: form.valid ? null : Colors.grey,
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
                buttonText: "Reset password",
              ),
            );
    });
  }
}
