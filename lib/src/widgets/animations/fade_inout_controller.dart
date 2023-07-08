import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/src/features/auth/views/onboarding/onboard_view.dart';

class TTS_AnimationController extends GetxController{
  static TTS_AnimationController get find => Get.find();

  RxBool animate = false.obs;

  Future startSplashAnimation() async {
    await Future.delayed(Duration(milliseconds: 500));
    animate.value = true;
    await Future.delayed(Duration(milliseconds: 5000));
    animate.value = false;
    await Future.delayed(Duration(milliseconds: 2000));
    Get.offAll(() => OnBoardScreen());
  }
  Future startAnimation() async {
    await Future.delayed(Duration(milliseconds: 500));
    animate.value = true;
  }
}
