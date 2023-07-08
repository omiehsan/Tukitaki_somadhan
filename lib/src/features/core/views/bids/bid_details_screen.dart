import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tasking/src/constants/colors.dart';
import 'package:tasking/src/features/core/views/jobs/job_details_screen.dart';

import '../../../../constants/image_list.dart';
import '../../controllers/bid_controller.dart';
import '../../models/bid_model.dart';
import 'bid_details_widget.dart';

class BidDetailScreen extends StatelessWidget {
  const BidDetailScreen({Key? key, this.bidId}) : super(key: key);

  final String? bidId;

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final controller = Get.put(BidPostController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TTS_WhiteColor,
        leading: IconButton(
          color: TTS_DarkColor,
          onPressed: () => Get.back(),
          icon: Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          "Bid Details",
          style: Theme.of(context).textTheme.headline4,
        ),
        actions: [IconButton(color: TTS_DarkColor, onPressed: () {}, icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              FutureBuilder(
                future: controller.getBidDetails(bidId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      BidModel bidDetails = snapshot.data as BidModel;
                      // JobModel jobDetails = snapshot.data as JobModel;
                      // final jobCreatedAtDiff = DateTime.now().millisecondsSinceEpoch - bidDetails.date.millisecondsSinceEpoch;
                      // final jobDate = DateFormat.yMMMMd().format(bidDetails.date);
                      // final jobCreatedAt = bidDetails.date;
                      // final timeAgo = timeago.format(DateTime.now().subtract(Duration(milliseconds: jobCreatedAtDiff)));
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          //   child: Text(
                          //     "${bidDetails.bidderName}",
                          //     style: Theme.of(context).textTheme.headline4,
                          //     maxLines: 1,
                          //   ),
                          // ),
                          const SizedBox(height: 10),
                          ListTile(
                            onTap: () {},
                            leading: Container(
                              width: 50,
                              height: 50,
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.circular(100),
                              //   color: TTS_BlackColor,
                              // ),
                              decoration: BoxDecoration(
                                color: TTS_WhiteColor,
                                border: Border.all(width: 2, color: TTS_DarkColor),
                                // borderRadius: BorderRadius.circular(105),
                                shape: BoxShape.circle,
                                image: DecorationImage(image: NetworkImage(TTS_All_User_Profile)),
                                // image: DecorationImage(image: AssetImage(TTS_All_User_Profile)),
                              ),
                              child: const Text(""),
                            ),
                            title: Text("Bid Placed By:", style: Theme.of(context).textTheme.bodyText2?.apply(color: TTS_LightBlack)),
                            subtitle: Text("${bidDetails.bidderName}", style: Theme.of(context).textTheme.bodyText1?.apply(color: TTS_DarkColor)),
                          ),
                          // Text("${userData.fullName}", style: Theme.of(context).textTheme.headline4),
                          // Text("${userData.email}", style: Theme.of(context).textTheme.bodyText1),
                          const Divider(),
                          // const SizedBox(height: 10),
                          //menu
                          // BidDetailsWidget(
                          //   title: "Posted Date:",
                          //   subtitle: "${jobDate} (${timeAgo})",
                          //   icon: LineAwesomeIcons.clock,
                          //   onPress: () {
                          //     print(jobDate);
                          //     print(timeAgo);
                          //     print(jobCreatedAt);
                          //     print(jobCreatedAtDiff);
                          //   },
                          // ),
                          BidDetailsWidget(title: "Location", subtitle: "${bidDetails.location}", icon: LineAwesomeIcons.map_pin, onPress: () {}),
                          BidDetailsWidget(
                              title: "Asking Price",
                              subtitle: "৳ ${bidDetails.askingPrice}",
                              icon: LineAwesomeIcons.hand_holding_us_dollar,
                              onPress: () {}),
                          // BidDetailsWidget(
                          //     title: "Required Skill",
                          //     subtitle: bidDetails.category.isEmpty ? "Not Specified" : "${jobDetails.category}",
                          //     icon: LineAwesomeIcons.toolbox,
                          //     onPress: () {}),
                          const Divider(),
                          BidDetailsWidget(title: "Status", subtitle: "${bidDetails.status}", icon: LineAwesomeIcons.wifi, onPress: () {}),
                          const Divider(),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text("Bid Descriptions", style: Theme.of(context).textTheme.headline5),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child:
                                Text("${bidDetails.bidderDescription}", textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText1),
                          ),

                          const SizedBox(height: 20),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(side: BorderSide.none, shape: StadiumBorder()),
                              onPressed: () => Get.to(JobDetailScreen(jobId: bidDetails.jobID)),
                              child: Text("Go To Job Details".toUpperCase()),
                            ),
                          ),
                          const SizedBox(height: 50),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      // return const Center(child: Text("Something Went Wrong!"));
                      return Center(child: Text(snapshot.error.toString()));
                    } else {
                      return const Center(child: Text("Something Went Wrong!"));
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
