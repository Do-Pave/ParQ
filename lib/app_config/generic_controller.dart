import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class GenericController extends GetxController {
  Rx<bool> isInitial = false.obs;
  Rx<bool> isBusy = false.obs;
  Rx<bool> isError = false.obs;
  Rx<bool> isDone = false.obs;
  Rx<String>? error = "".obs;

  resetStateParam({bool isInitial = false, bool isLoading = false, bool isDone = false, bool isError = false, String error = "error"}) {
    isBusy.value = isLoading;
    this.isDone.value = isDone;
    this.isError.value = isError;
    if (this.isError.isTrue) {
      this.error?.value = error;
    }
  }
}
