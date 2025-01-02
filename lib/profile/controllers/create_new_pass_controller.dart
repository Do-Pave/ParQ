import 'package:get/get.dart';
import 'package:parq/app_config/generic_controller.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../app_config/biometrics_login_service.dart';

class CreateNewPassController extends GenericController {
  var passwordObscureText = true.obs;
  var confirmPasswordObscureText = true.obs;
  final biometricLoginService = BiometricLoginService();

  final form = FormGroup({
    'password': FormControl<String>(
        validators: [Validators.required, Validators.minLength(8)]),
    // 'confirmPassword': FormControl<String>(validators: [
    //   Validators.required,
    //   Validators.mustMatch("confirmPassword", "password")
    // ]),
    'confirmPassword': FormControl<String>(),
  }, validators: [
    const MustMatchValidator('password', 'confirmPassword', false)
  ]);
}
