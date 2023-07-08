import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/image_list.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/texts.dart';
import '../dash/dashboard_view.dart';
import 'bidding_form_widget.dart';

class BiddingOnJobScreen extends StatelessWidget {
  const BiddingOnJobScreen({Key? key, required this.jobID}) : super(key: key);

  final String? jobID;

  @override
  Widget build(BuildContext context) {
    final TTS_MQuery = MediaQuery.of(context);
    final deviceSize = TTS_MQuery.size;
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TTS_WhiteColor,
        leading: IconButton(
          color: TTS_DarkColor,
          onPressed: () => Get.offAll(DashboardScreen()),
          icon: Icon(LineAwesomeIcons.window_close),
        ),
        title: Text(
          "Bid For This Job",
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          IconButton(color: TTS_DarkColor, onPressed: () {}, icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon)),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(TTS_DefaultSize),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* -- Start Section 1 -- */
              // FormPageHeader(
              //   logo: TTS_Post_Bid,
              //   logoHeight: 120.0,
              //   pageTitle: TTS_Bid_on_post_Title,
              //   pageSubtitle: TTS_Bid_on_Subtitle,
              // ),
              Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(image: AssetImage(TTS_Login_Imge_1), height: 150),
                  SizedBox(height: TTS_DefaultSize - 20),
                  Text(TTS_Bid_on_Subtitle, style: Theme.of(context).textTheme.headline5),
                  SizedBox(height: TTS_DefaultSize - 20),
                  /* -- Start Section 2 -- */
                  BiddingJobFormWidget(jobID: jobID),

                  /* -- Start Section 3 -- */
                  // JobPostPageFooter()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
