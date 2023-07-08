import 'package:get/get.dart';

import '../auth_repo/auth_repo.dart';
import '../user_repo/user_repo.dart';

class CommonUseController extends GetxController {
  static CommonUseController get instance => Get.find();

  final _authRepo = Get.put(AuthRepo());
  final _userRepo = Get.put(UserRepo());

  getUserEmail() {
    final userEmail = _authRepo.firebaseUser.value?.email;
    return userEmail;
  }

  getUserDetails() async {
    final userEmail = _authRepo.firebaseUser.value?.email;
    if (userEmail != null) {
      return _userRepo.getUserDetails(userEmail);
    } else {
      return "";
    }
  }

  getUserDetailsByEmail({required String userEmail}) async {
    return _userRepo.getUserDetails(userEmail);
  }
}
