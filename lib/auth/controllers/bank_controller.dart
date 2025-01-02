import 'package:parq/app_config/generic_controller.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../app_config/biometrics_login_service.dart';

class BankController extends GenericController {
  final form = FormGroup({
    'accNumber': FormControl<String>(validators: [Validators.required]),
    'dropdown': FormControl<String>(validators: [Validators.required]),
    'iban': FormControl<String>(validators: [
      Validators.required,
    ]),
  });
  final biometricLoginService = BiometricLoginService();

}
