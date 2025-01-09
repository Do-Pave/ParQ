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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Name'.tr,
                      style:
                      const TextStyle(color: AppColors.black, fontSize: 16),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 8.0),
                    name(),
                    const SizedBox(height: 20.0),
                    Text(
                      'Phone number'.tr,
                      style:
                      const TextStyle(color: AppColors.black, fontSize: 16),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 8.0),
                    phone(),
                    const SizedBox(height: 20.0),
                    Text(
                      'Email'.tr,
                      style:
                      const TextStyle(color: AppColors.black, fontSize: 16),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 8.0),
                    email(),
                    const SizedBox(height: 20.0),
                    Text(
                      'DOB'.tr,
                      style:
                      const TextStyle(color: AppColors.black, fontSize: 16),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 8.0),
                    datePickerField(),
                    const SizedBox(height:  20.0),
                    Text(
                      'Gender'.tr,
                      style:
                      const TextStyle(color: AppColors.black, fontSize: 16),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 8.0),
                    SizedBox(height: 100,child: genderSelectionDropdown()),
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

  Widget name() {
    return ReactiveTextField(
      formControlName: 'name',
      textInputAction: TextInputAction.next,
      onSubmitted: (_) {
        controller.form.focus('number');
      },
      validationMessages: {
        ValidationMessage.required: (error) => 'Name must not be empty',
      },
      decoration: InputDecoration(
        // labelText: 'Name',
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        hintText: 'Ex: Amr',
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
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          // borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      style: const TextStyle(
        color: Colors.black,
      ),
    );
  }

  Widget phone() {
    return ReactiveTextField(
      formControlName: 'phone',
      // maxLength: 8,
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

  Widget email() {
    return ReactiveTextField(
      formControlName: 'email',
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      onSubmitted: (_) {
        controller.form.focus('dob');
      },
      validationMessages: {
        ValidationMessage.required: (error) => 'Email must not be empty',
      },
      decoration: InputDecoration(
        // labelText: 'Name',
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        hintText: 'Ex: amfa.94@hotmail.com',
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
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          // borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      style: const TextStyle(
        color: Colors.black,
      ),
    );
  }

  Widget datePickerField() {
    return ReactiveFormConsumer(
      builder: (context, form, child) {
        final dateControl = form.control('date') as FormControl<String>;

        return GestureDetector(
          onTap: () async {
            final pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );

            if (pickedDate != null) {
              dateControl.value = pickedDate
                  .toLocal()
                  .toString()
                  .split(' ')[0]; // Format the date as a string
            }
          },
          child: AbsorbPointer(
            child: ReactiveTextField(
              formControlName: 'date',
              textInputAction: TextInputAction.next,
              onSubmitted: (_) {
                controller.form.focus('gender');
              },
              validationMessages: {
                ValidationMessage.required: (error) =>
                'The date must not be empty',
              },
              decoration: InputDecoration(
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
                hintText: 'Select a date',
                hintStyle: const TextStyle(
                  color: AppColors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
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
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  // borderSide: const BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(10.0),
                ),

                suffixIcon: Icon(Icons.calendar_today,
                    color: AppColors.grey1), // Add an icon for the calendar
              ),
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget genderSelectionDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   'Gender',
        //   style: const TextStyle(
        //     color: AppColors.black,
        //     fontSize: 16,
        //     fontWeight: FontWeight.bold, // Matches the title text style
        //   ),
        //   textAlign: TextAlign.start,
        // ),
        const SizedBox(height: 8.0),
        ReactiveDropdownField<String>(
          formControlName: 'gender',
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white, // Same background color as other fields
            contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              // borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(10.0),
            ),

            hintText: 'Select Gender', // Placeholder text
            hintStyle: TextStyle(color: AppColors.grey.withOpacity(0.8)),
          ),
          items: const [
            DropdownMenuItem(
              value: 'Male',
              child: Text('Male',style: TextStyle( color: AppColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,)),
            ),
            DropdownMenuItem(
              value: 'Female',
              child: Text('Female',style: TextStyle( color: AppColors.black,
                fontSize: 12,
                fontWeight: FontWeight.w400,),),
            ),
          ],
          validationMessages: {
            ValidationMessage.required: (_) => 'Please select a gender',
          },
        ),
      ],
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
                buttonText: "Update profile",
              ),
            );
    });
  }
}
