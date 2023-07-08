import 'package:get/get.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';

import '../../../constants/colors.dart';
import '../../../constants/image_list.dart';
import '../../../constants/texts.dart';
import '../models/onboarding_model.dart';
import '../views/onboarding/onboarding_widget_view.dart';
import '../views/welcome/welcome_view.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get find => Get.find();

  final OnBoLiquidController = LiquidController();
  RxInt currentPage = 0.obs;

  final pages = [
    OnBoardingPageWidget(
      model: OnBoardingModel(
        image: TTS_On_BoardingImg_4,
        title: TTS_OnBoarding_Page_Title_1,
        subtitle: TTS_OnBoarding_Page_Subtitle_1,
        pagecounter: TTS_OnBoarding_Counter_1,
        bgcolor: TTS_OnBoarding_Page_Color1,
      ),
    ),
    OnBoardingPageWidget(
      model: OnBoardingModel(
        image: TTS_On_BoardingImg_2,
        title: TTS_OnBoarding_Page_Title_2,
        subtitle: TTS_OnBoarding_Page_Subtitle_2,
        pagecounter: TTS_OnBoarding_Counter_2,
        bgcolor: TTS_OnBoarding_Page_Color2,
      ),
    ),
    OnBoardingPageWidget(
      model: OnBoardingModel(
        image: TTS_On_BoardingImg_3,
        title: TTS_OnBoarding_Page_Title_3,
        subtitle: TTS_OnBoarding_Page_Subtitle_3,
        pagecounter: TTS_OnBoarding_Counter_3,
        bgcolor: TTS_OnBoarding_Page_Color3,
      ),
    ),
  ];

  skip() => Get.to(WelcomeScreen());
  // skip () => OnBoLiquidController.jumpToPage(page: 2);
  animateToNextPage() {
    int nextPage = OnBoLiquidController.currentPage + 1;
    OnBoLiquidController.animateToPage(page: nextPage);
  }

  OnPageChangeCallback(int activePageIndex) {
    currentPage.value = activePageIndex;
  }
}
