import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../constants/colors.dart';
import '../../controllers/onboarding_controller.dart';

class OnBoardScreen extends StatelessWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final Controller = OnBoardingController();
    final Controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            pages: Controller.pages,
            liquidController: Controller.OnBoLiquidController,
            onPageChangeCallback: Controller.OnPageChangeCallback,
            slideIconWidget: const Icon(Icons.arrow_back_ios),
            enableSideReveal: true,
          ),
          Positioned(
            bottom: 100.0,
            child: OutlinedButton(
              onPressed: () => Controller.animateToNextPage(),
              style: ElevatedButton.styleFrom(
                side: const BorderSide(color: Colors.black26),
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20.0),
                foregroundColor: Colors.white,
              ),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  color: TTS_DarkColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_forward_ios),
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 30,
            child: TextButton(
              onPressed: () => Controller.skip(),
              child: const Text("Skip Intro", style: TextStyle(color: TTS_LogoColor, fontSize: 16)),
            ),
          ),
          Obx(
            () => Positioned(
              bottom: 50,
              child: AnimatedSmoothIndicator(
                count: 3,
                activeIndex: Controller.currentPage.value,
                effect: const WormEffect(
                  activeDotColor: TTS_AccentColor,
                  dotHeight: 8.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
