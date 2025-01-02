import 'package:parq/app_config/generic_controller.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../app_config/biometrics_login_service.dart';

class ResetPasswordController extends GenericController{
  final biometricLoginService = BiometricLoginService();
  final form = FormGroup({
    'phone': FormControl<String>(
        validators: [Validators.required, Validators.number,Validators.minLength(11),Validators.maxLength(11)]),
  });
}