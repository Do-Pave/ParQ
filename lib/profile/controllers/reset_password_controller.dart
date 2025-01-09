import 'package:get/get.dart';
import 'package:parq/app_config/generic_controller.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../app_config/biometrics_login_service.dart';

class ResetPasswordController extends GenericController{
  final isCurrentPasswordVisible = true.obs;
  final isNewPasswordVisible = true.obs;
  final isConfirmPasswordVisible = true.obs;

  void toggleCurrentPasswordVisibility() {
    isCurrentPasswordVisible.value = !isCurrentPasswordVisible.value;
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  final form = FormGroup({
    'currentPassword': FormControl<String>(validators: [Validators.required]),
    'newPassword': FormControl<String>(validators: [
      Validators.required,
    ]),
    'confirmNewPass': FormControl<String>(validators: [Validators.required]),
  });
}