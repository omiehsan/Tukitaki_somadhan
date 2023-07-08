import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '/src/constants/colors.dart';
import '/src/constants/image_list.dart';
import '/src/constants/sizes.dart';
import '/src/constants/texts.dart';
import '../../../../widgets/animations/fade_inout_controller.dart';
import '../../../../widgets/animations/fade_inout_model.dart';
import '../../../../widgets/animations/fade_inout_view.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var TTS_MQuery = MediaQuery.of(context);

    final deviceWidth = TTS_MQuery.size.width;

    final TTS_Anim_Controller = Get.put(TTS_AnimationController());
    TTS_Anim_Controller.startSplashAnimation();

    return Scaffold(
      body: Stack(
        children: [
          TTS_FadeInOutAnim(
            duration: 1600,
            animPos: TTS_AnimatePosition(
              topBefore: 80,
              topAfter: 80,
              leftBefore: TTS_DefaultSize,
              leftAfter: TTS_DefaultSize,
            ),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(100),
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                ),
                color: Colors.deepPurple,
              ),
            ),
          ),
          TTS_FadeInOutAnim(
            duration: 1000,
            animPos: TTS_AnimatePosition(
              topBefore: 200,
              topAfter: 200,
              leftBefore: -80,
              leftAfter: TTS_DefaultSize,
              // opacityStart: 0.5,
              // opacityEnd: 1,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(TTS_AppName,
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          fontSize: 24,
                          color: TTS_LogoColor,
                        )),
              ],
            ),
          ),
          TTS_FadeInOutAnim(
            duration: 2000,
            animPos: TTS_AnimatePosition(
              topBefore: 280,
              topAfter: 240,
              leftBefore: TTS_DefaultSize,
              leftAfter: TTS_DefaultSize,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(TTS_TagLine,
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: 32.0,
                          color: Colors.black87,
                          // fontStyle: FontStyle.italic,
                          // letterSpacing: 1.5,
                        )),
              ],
            ),
          ),
          TTS_FadeInOutAnim(
            duration: 800,
            animPos: TTS_AnimatePosition(
              bottomBefore: 430,
              bottomAfter: 400,
            ),
            child: SizedBox(
              width: deviceWidth * 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage(TTS_SplashImage), width: deviceWidth * 0.75),
                ],
              ),
            ),
          ),
          TTS_FadeInOutAnim(
            duration: 1600,
            animPos: TTS_AnimatePosition(
              bottomBefore: -250,
              bottomAfter: -100,
              rightBefore: -250,
              rightAfter: -100,
            ),
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(300),
                color: TTS_PrimaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
