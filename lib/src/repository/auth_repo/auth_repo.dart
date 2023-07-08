import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../features/auth/views/splash/splash_view.dart';
import '../../features/auth/views/welcome/welcome_view.dart';
import '../../features/core/views/dash/dashboard_view.dart';
import 'exceptions/login_email_pass_exceptions.dart';
import 'exceptions/register_email_pass_exceptions.dart';

class AuthRepo extends GetxController {
  static AuthRepo get instance => Get.find();

  // Variable
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null ? Get.offAll(() => const SplashScreen()) : Get.offAll(() => DashboardScreen());
  }

  Future<void> createUserEmailPass(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null ? Get.offAll(() => const DashboardScreen()) : Get.offAll(() => WelcomeScreen());
    } on FirebaseAuthException catch (e) {
      final ex = createUserEmailPassExceptions.code(e.code);
      Get.snackbar(
        "Firebase Auth Exception:",
        "${ex.errorMessage}",
        icon: Icon(Icons.person, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: TTS_LogoColor,
        borderRadius: 10,
        margin: EdgeInsets.all(15),
        colorText: Colors.white,
        duration: Duration(seconds: 10),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutBack,
      );
      throw ex;
    } catch (_) {
      const ex = createUserEmailPassExceptions();
      Get.snackbar(
        "Exception:",
        "${ex.errorMessage}",
        icon: Icon(Icons.person, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: TTS_LogoColor,
        borderRadius: 10,
        margin: EdgeInsets.all(15),
        colorText: Colors.white,
        duration: Duration(seconds: 10),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutBack,
      );
      throw ex;
    }
  }

  Future<void> loginEmailPass(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null ? Get.offAll(() => const DashboardScreen()) : Get.offAll(() => WelcomeScreen());
    } on FirebaseAuthException catch (e) {
      final ex = loginUserEmailPassExceptions.code(e.code);
      Get.snackbar(
        "Firebase Auth Exception:",
        "${ex.errorMessage}",
        icon: Icon(Icons.person, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: TTS_LogoColor,
        borderRadius: 10,
        margin: EdgeInsets.all(15),
        colorText: Colors.white,
        duration: Duration(seconds: 10),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutBack,
      );
      throw ex;
    } catch (_) {
      const ex = loginUserEmailPassExceptions();
      Get.snackbar(
        "Exception:",
        "${ex.errorMessage}",
        icon: Icon(Icons.person, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: TTS_LogoColor,
        borderRadius: 10,
        margin: EdgeInsets.all(15),
        colorText: Colors.white,
        duration: Duration(seconds: 10),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutBack,
      );
      throw ex;
    }
  }

  Future<void> logOut() async => await _auth.signOut();
}
