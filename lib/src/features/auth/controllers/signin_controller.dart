import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../repository/auth_repo/auth_repo.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  // TextFormField Controllers To Get Form Data

  // final fullName = TextEditingController();
  // final phoneNum = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  void loginUser(String email, String password) {
    AuthRepo.instance.loginEmailPass(email, password);
  }
}
