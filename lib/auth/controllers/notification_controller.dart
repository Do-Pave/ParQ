import 'package:get/get.dart';
import 'package:parq/app_config/generic_controller.dart';
import 'package:parq/auth/screens/login_with_number_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationController extends GenericController{

  Future<void> requestNotificationPermission() async {
    isBusy.value = true;

    PermissionStatus notificationPermission = await Permission.notification.status;
    if (!notificationPermission.isGranted) {
      notificationPermission = await Permission.notification.request();
    }

    if (!notificationPermission.isGranted) {
      isBusy.value = false;
      Get.snackbar(
        "Permission Denied",
        "Notifications permission is required.",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (notificationPermission.isGranted) {
      isBusy.value = false;
      Get.snackbar(
        "Permission Granted",
        "Notifications permission granted successfully!.",
        snackPosition: SnackPosition.BOTTOM,
      );
      isBusy.value = false;

      Get.offAll(() => const LoginWithNumberScreen()); // Replace with actual login screen widget
      return;
    }
    isBusy.value = false;

  }

}