import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/app_colors.dart';
import 'package:parq/app_config/custom_app_bar.dart';
import 'package:parq/app_config/mains.dart';
import 'package:parq/auth/controllers/bank_controller.dart';
import 'package:parq/auth/screens/success_to_start_screen.dart';
import 'package:reactive_forms/reactive_forms.dart';

class BankScreen extends GetView<BankController> {
  const BankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BankController());
    return Scaffold(
      appBar: ParqAppBar(onBackTap: () {
        Get.back();
      }),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Obx(
            () => ReactiveForm(
              formGroup: controller.form,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("Verify your identity".tr,
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black)),
                    const SizedBox(
                      height: 20,
                    ),
                    cameraAnddecoration(),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Bank".tr,
                          style: const TextStyle(
                              color: AppColors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        GestureDetector(
                            onTap: () {
                              debugPrint("Create account tapped");
                            },
                            child: Text(
                              "Create Account".tr,
                              style: const TextStyle(
                                  color: AppColors.blue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.blue),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    chooseBank(),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Account Details".tr,
                      style: const TextStyle(
                          color: AppColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    accNumber(),
                    const SizedBox(
                      height: 20,
                    ),
                    iban(),
                    const SizedBox(
                      height: 40,
                    ),
                    confirmBtn(),
                    if (controller.isError.isTrue) ...[
                      const SizedBox(height: 10),
                      Text(controller.error?.value ?? "Error",
                          style: const TextStyle(color: Colors.red)),
                      const SizedBox(height: 10),
                    ]
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget chooseBank() {
    return ReactiveDropdownField<String>(
      formControlName: 'dropdown',
      decoration: InputDecoration(
        labelText: 'Choose Bank',
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        hintText: 'Choose Bank',
        hintStyle: const TextStyle(
          color: AppColors.grey,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
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
      items: const [
        DropdownMenuItem(value: 'option1', child: Text('Option 1')),
        DropdownMenuItem(value: 'option2', child: Text('Option 2')),
        DropdownMenuItem(value: 'option3', child: Text('Option 3')),
      ],
    );
  }

  Widget accNumber() {
    return ReactiveTextField(
      formControlName: 'accNumber',
      textInputAction: TextInputAction.next,
      onSubmitted: (_) {
        controller.form.focus('iban');
      },
      validationMessages: {
        ValidationMessage.required: (error) =>
            'Account number must not be empty',
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Acc Number',
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        hintText: '0000 0000 0000 0000 0000',
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

  Widget iban() {
    return ReactiveTextField(
      formControlName: 'iban',
      validationMessages: {
        ValidationMessage.required: (error) => 'IBAN must not be empty',
      },
      decoration: InputDecoration(
        labelText: 'IBAN',
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        hintText: '0000 0000 0000 0000 0000',
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

  Widget cameraAnddecoration() {
    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/images/image 4.png",
              ),
            ),
          ),
          // Top-left corner
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0), // Radius for top-left corner
                ),
                border: Border(
                  top: BorderSide(color: AppColors.grey2, width: 2),
                  left: BorderSide(color: AppColors.grey2, width: 2),
                ),
              ),
            ),
          ),
          // Top-right corner
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                  topRight:
                      Radius.circular(16.0), // Radius for top-right corner
                ),
                border: Border(
                  top: BorderSide(color: AppColors.grey2, width: 2),
                  right: BorderSide(color: AppColors.grey2, width: 2),
                ),
              ),
            ),
          ),
          // Bottom-left corner
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft:
                      Radius.circular(16.0), // Radius for top-right corner
                ),
                border: Border(
                  bottom: BorderSide(color: AppColors.grey2, width: 2),
                  left: BorderSide(color: AppColors.grey2, width: 2),
                ),
              ),
            ),
          ),
          // Bottom-right corner
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight:
                      Radius.circular(16.0), // Radius for top-right corner
                ),
                border: Border(
                  bottom: BorderSide(color: AppColors.grey2, width: 2),
                  right: BorderSide(color: AppColors.grey2, width: 2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget confirmBtn() {
    return ReactiveFormConsumer(builder: (context, form, child) {
      return controller.isBusy.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : MainButton(
          gradient: AppColors.homeScrGradientColor,
          color: controller.form.valid ? null : AppColors.grey2,
              onTap: () async {
                debugPrint("Confirm");

                Get.offAll(() => const SuccessToStartScreen());
              },
              buttonText: "Confirm".tr);
    });
  }
}
