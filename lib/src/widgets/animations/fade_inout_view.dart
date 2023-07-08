import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/image_list.dart';
import '../../constants/sizes.dart';
import 'fade_inout_model.dart';
import './fade_inout_controller.dart';



class TTS_FadeInOutAnim extends StatelessWidget {
  TTS_FadeInOutAnim({
    Key? key,

    required this.duration,
    required this.child,
    this.animPos,

  }) : super(key: key);

  final TTS_Anim_Controller = Get.put(TTS_AnimationController());
  final TTS_AnimatePosition? animPos;
  final int duration;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedPositioned(
        duration: Duration(milliseconds: duration),
        top: TTS_Anim_Controller.animate.value ? animPos!.topAfter : animPos!.topBefore,
        bottom: TTS_Anim_Controller.animate.value ? animPos!.bottomAfter : animPos!.bottomBefore,
        left: TTS_Anim_Controller.animate.value ? animPos!.leftAfter : animPos!.leftBefore,
        right: TTS_Anim_Controller.animate.value ? animPos!.rightAfter : animPos!.rightBefore,
        height: TTS_Anim_Controller.animate.value ? animPos!.heightAfter : animPos!.heightBefore,
        width: TTS_Anim_Controller.animate.value ? animPos!.widthAfter : animPos!.widthBefore,

        child: AnimatedOpacity(
          duration: Duration(milliseconds: duration),
          opacity: TTS_Anim_Controller.animate.value ? animPos!.opacityEnd ?? 1 : animPos!.opacityStart ?? 0,
          child: child,
          // Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          //   Image(
          //     image: AssetImage(TTS_SplashImage),
          //   ),
          // ]),
        ),
      ),
    );
  }
}
