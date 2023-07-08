import 'package:get/get.dart';

class ShowPassController extends GetxController {
  static ShowPassController get find => Get.find();

  RxBool showPassword = false.obs;

  passVisibility() {
    showPassword.value = !showPassword.value;
  }
}
