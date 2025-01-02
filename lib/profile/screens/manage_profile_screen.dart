import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/app_colors.dart';
import 'package:parq/app_config/custom_app_bar.dart';
import 'package:parq/app_config/mains.dart';
import 'package:parq/profile/controllers/manage_profile_controller.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ManageProfileScreen extends GetView<ManageProfileController> {
  const ManageProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ManageProfileController());
    return GestureDetector(
      // onHorizontalDragUpdate: (details) {
      //   if (details.delta.dx > 0) {
      //     // Swipe from left to right to go back
      //     Get.back();
      //   }
      // },
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
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  firstName(),
                  const SizedBox(
                    height: 25,
                  ),
                  lastName(),
                  const SizedBox(
                    height: 25,
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
            child: saveBtn(),
          ),
        ),
      ),
    );
  }

  Widget firstName() {
    return ReactiveTextField(
      formControlName: 'firstName',
      textInputAction: TextInputAction.next,
      onSubmitted: (_) {
        controller.form.focus('lastName');
      },
      validationMessages: {
        ValidationMessage.required: (error) => 'First name must not be empty',
      },
      decoration: InputDecoration(
        labelText: 'First name',
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        hintText: 'Ex: Amr',
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

  Widget lastName() {
    return ReactiveTextField(
      formControlName: 'lastName',
      textInputAction: TextInputAction.next,
      onSubmitted: (_) {
        controller.form.focus('phone');
      },
      validationMessages: {
        ValidationMessage.required: (error) => 'Last name must not be empty',
      },
      decoration: InputDecoration(
        labelText: 'Last name',
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        hintText: 'Ex: Amr',
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

  Widget phoneNumber() {
    return ReactiveTextField(
      formControlName: 'phone',
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

  Widget saveBtn() {
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
                        debugPrint(
                            "Sign up button inside signup screen tapped");
                        // Get.to(() => const PinScreen());
                        // }
                      }
                    : null,
                buttonText: "Save changes",
              ),
            );
    });
  }
}
