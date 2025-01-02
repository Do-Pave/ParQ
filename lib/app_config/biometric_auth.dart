import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricAuth {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  Future<bool> authenticate() async {
    bool isAuthenticated = false;
    try {
      isAuthenticated = await _localAuthentication.authenticate(
        localizedReason: 'Please authenticate to access the app',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
    } on PlatformException catch (e) {
      debugPrint('Authentication error: $e');
      _handleAuthenticationError(e);
    }
    return isAuthenticated;
  }

  Future<bool> canCheckBiometrics() async {
    try {
      return await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      debugPrint('Biometric check error: $e');
      return false;
    }
  }

  void _handleAuthenticationError(PlatformException e) {
    switch (e.code) {
      case 'NotEnrolled':
        _showNoBiometricsEnrolledDialog();
        break;
      case 'LockedOut':
      case 'PermanentlyLockedOut':
        _showBiometricLockoutDialog();
        break;
      default:
        _showGenericErrorDialog(e.message);
    }
  }

  void _showNoBiometricsEnrolledDialog() {
    // Implement a dialog to inform the user that no biometrics are enrolled
    debugPrint('No biometrics enrolled');
  }

  void _showBiometricLockoutDialog() {
    // Implement a dialog to inform the user that biometrics are locked out
    debugPrint('Biometrics are locked out');
  }

  void _showGenericErrorDialog(String? message) {
    // Implement a dialog to show a generic error message
    debugPrint('Authentication error: $message');
  }
}
