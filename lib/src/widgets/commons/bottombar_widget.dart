import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasking/src/features/core/views/dash/dashboard_view.dart';
import 'package:tasking/src/features/core/views/jobs/post_job_view.dart';

import '../../constants/colors.dart';
import '../../features/core/views/bids/all_bids_by_anything_screen.dart';
import '../../features/core/views/notify/notification_screen.dart';
import '../../features/core/views/orders/all_orders_by_anything_screen.dart';
import '../../repository/common_repo/common_controller.dart';

class TTS_BottomNavBar extends StatelessWidget {
  TTS_BottomNavBar({
    Key? key,
  }) : super(key: key);

  final commonController = Get.put(CommonUseController());

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: 0,
      height: 70.0,
      color: TTS_DarkColor,
      backgroundColor: Colors.transparent,
      buttonBackgroundColor: TTS_LogoColor,
      // animationCurve: Curves.easeInExpo,
      items: const <Widget>[
        Icon(Icons.home, size: 25, color: TTS_WhiteColor),
        Icon(Icons.stacked_line_chart_rounded, size: 25, color: TTS_WhiteColor),
        Icon(Icons.add, size: 25, color: TTS_WhiteColor),
        Icon(Icons.library_books, size: 25, color: TTS_WhiteColor),
        Icon(Icons.notifications_active_sharp, size: 25, color: TTS_WhiteColor),
      ],
      onTap: (index) {
        Future.delayed(const Duration(milliseconds: 500), () {
          // Do something
          ToBottomPage(index);
        });
      },
    );
  }

  void ToBottomPage(page) {
    if (page == 0) {
      Get.to(DashboardScreen());
    } else if (page == 1) {
      Get.to(AllBidsByFilterScreen(
        filterByEmail: commonController.getUserEmail(),
        pageTitle: "My Bids",
      ));
    } else if (page == 2) {
      Get.to(PostJobScreen());
    } else if (page == 3) {
      Get.to(AllOrdersByFilterScreen());
    } else if (page == 4) {
      Get.to(NotificationScreen());
    }
    // Get.to(WelcomeScreen());
  }

  void setState(Null Function() param0) {}
}
