import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/image_list.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/texts.dart';
import '../../../../widgets/animations/fade_inout_controller.dart';
import '../../../../widgets/animations/fade_inout_model.dart';
import '../../../../widgets/animations/fade_inout_view.dart';
import '../login/login_view.dart';
import '../singup/singup_view.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TTS_Anim_Controller = Get.put(TTS_AnimationController());
    TTS_Anim_Controller.startAnimation();

    final TTS_MediaQuery = MediaQuery.of(context);
    final screenHeight = TTS_MediaQuery.size.height;
    final brightness = TTS_MediaQuery.platformBrightness;

    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? TTS_SecondaryColor : TTS_OnBoarding_Page_Color2,
      body: Stack(
        children: [
          TTS_FadeInOutAnim(
            duration: 500,
            animPos: TTS_AnimatePosition(
              topBefore: 0,
              topAfter: 0,
              bottomBefore: -100,
              bottomAfter: 0,
              leftBefore: 0,
              leftAfter: 0,
              rightBefore: 0,
              rightAfter: 0,
            ),
            child: Container(
              padding: const EdgeInsets.all(TTS_DefaultSize),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image(image: AssetImage(TTS_Welcome_Imge_2), height: screenHeight * 0.5),
                  Column(
                    children: [
                      Text(TTS_Welcome_Title, style: Theme.of(context).textTheme.headline2!.copyWith(color: TTS_LogoColor)),
                      Text(TTS_Welcome_Subtitle, style: Theme.of(context).textTheme.subtitle1, textAlign: TextAlign.center),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Get.to(() => const LoginScreen()),
                          child: Text(TTS_Login.toUpperCase()),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Get.to(() => const SignUpScreen()),
                          child: Text(TTS_Register.toUpperCase()),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
