import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tasking/src/features/core/views/dash/widgets/category_widget.dart';
import 'package:tasking/src/features/core/views/orders/test/test_category_widget.dart';

import '../../../../constants/colors.dart';
import '../../../../widgets/commons/appbar_widget.dart';
import '../dash/dashboard_view.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  get isDark => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TTS_WhiteColor,
        leading: IconButton(
            icon: Icon(LineAwesomeIcons.arrow_left),
            color: TTS_DarkColor,
            onPressed: () {
              Get.to(DashboardScreen());
            }),
        title: Text(
          "Your Orders",
          style: Theme.of(context).textTheme.headline5,
        ),
        actions: [IconButton(color: TTS_DarkColor, onPressed: () {}, icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: TestCategoryWidget(textTheme: Typography.blackHelsinki,),
        ),
      ),
    );
  }
}
