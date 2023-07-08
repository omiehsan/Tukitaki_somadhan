import 'package:easy_stepper/easy_stepper.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tasking/src/constants/colors.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

import '../../../../constants/image_list.dart';
import '../../../../repository/common_repo/common_controller.dart';
import '../../../auth/models/users_model.dart';
import '../../controllers/bid_controller.dart';
import '../../controllers/job_controller.dart';
import '../../models/bid_model.dart';
import '../../models/job_model.dart';
import '../bids/all_bids_by_anything_screen.dart';
import '../bids/bidding_on_job_view.dart';
import 'job_details_widget.dart';

class JobDetailScreen extends StatelessWidget {
  const JobDetailScreen({
    Key? key,
    required this.jobId,
    this.isOrder = false,
    this.pageTitle = "Job Details",
    this.bidPrice = 0,
  }) : super(key: key);

  final bool? isOrder;
  final num? bidPrice;
  final String? jobId;
  final String? pageTitle;

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final controller = Get.put(JobPostController());
    final bidController = Get.put(BidPostController());
    final jobController = Get.put(JobPostController());
    final commonController = Get.put(CommonUseController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TTS_WhiteColor,
        leading: IconButton(
          color: TTS_DarkColor,
          onPressed: () => Get.back(),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(pageTitle!, style: Theme.of(context).textTheme.headline5),
        actions: [IconButton(color: TTS_DarkColor, onPressed: () {}, icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                FutureBuilder(
                  future: controller.getJobDetails(jobId),
                  // future: controller.getJobDetails("lxQh77P4xmv5C2qaLKTu"),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        JobModel jobDetails = snapshot.data as JobModel;
                        final jobCreatedAtDiff = DateTime.now().millisecondsSinceEpoch - jobDetails.date.millisecondsSinceEpoch;
                        final jobDate = DateFormat.yMMMMd().format(jobDetails.date);
                        final jobCreatedAt = jobDetails.date;
                        final timeAgo = timeago.format(DateTime.now().subtract(Duration(milliseconds: jobCreatedAtDiff)));
                        final isMyPost = jobDetails.email == commonController.getUserEmail();
                        final isHiring = jobDetails.status == "Hiring";
                        final isProgress = jobDetails.status == "In-Progress";
                        final isDelivered = jobDetails.status == "Delivered";
                        final isFinished = jobDetails.status == "Finished";
                        // print(isMyPost);
                        // print(commonController.getUserEmail());
                        // print(jobDetails.email);
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            EasyStepper(
                              activeStep: isHiring
                                  ? 0
                                  : isProgress
                                      ? 1
                                      : isDelivered
                                          ? 2
                                          : isFinished
                                              ? 3
                                              : 0,
                              lineLength: 60,
                              stepShape: StepShape.circle,
                              // stepBorderRadius: 15,
                              borderThickness: 6,
                              padding: 8,
                              stepRadius: 25,
                              lineColor: TTS_DarkColor,
                              finishedStepBorderColor: TTS_DarkColor,
                              finishedStepTextColor: TTS_DarkColor,
                              finishedStepBackgroundColor: TTS_LogoColor,
                              activeStepIconColor: Colors.deepOrange,
                              activeStepBorderColor: Colors.deepOrange,
                              activeStepTextColor: TTS_DarkColor,
                              // loadingAnimation: 'https://assets1.lottiefiles.com/packages/lf20_p8bfn5to.json',
                              // showLoadingAnimation: true,
                              steps: const [
                                EasyStep(
                                  icon: Icon(Icons.flight_land_rounded),
                                  title: 'Hiring',
                                ),
                                EasyStep(
                                  icon: Icon(Icons.person_3_rounded),
                                  title: 'Working',
                                ),
                                EasyStep(
                                  icon: Icon(Icons.flight_takeoff_rounded),
                                  title: 'Delivery',
                                ),
                              ],
                              onStepReached: (index) {
                                // setState(() => activeStep = index;
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Text(
                                    "${jobDetails.jobTitle}",
                                    style: Theme.of(context).textTheme.headline4,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Divider(),
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
                              title: Text("Job Placed By:", style: Theme.of(context).textTheme.bodyText2?.apply(color: TTS_LightBlack)),
                              subtitle: isMyPost
                                  ? Text("${jobDetails.createdBy} (You)",
                                      style: Theme.of(context).textTheme.bodyText1?.apply(color: TTS_DarkColor, fontWeightDelta: 500))
                                  : Text("${jobDetails.createdBy}",
                                      style: Theme.of(context).textTheme.bodyText1?.apply(color: TTS_DarkColor, fontWeightDelta: 500)),
                            ),
                            // Text("${userData.fullName}", style: Theme.of(context).textTheme.headline4),
                            // Text("${userData.email}", style: Theme.of(context).textTheme.bodyText1),
                            const Divider(),
                            // const SizedBox(height: 10),
                            //menu
                            JobDetailsWidget(
                              title: "Posted Date:",
                              subtitle: "${jobDate} (${timeAgo})",
                              icon: LineAwesomeIcons.clock,
                              onPress: () {
                                print(jobDate);
                                print(timeAgo);
                                print(jobCreatedAt);
                                print(jobCreatedAtDiff);
                              },
                            ),
                            JobDetailsWidget(title: "Location", subtitle: "${jobDetails.location}", icon: LineAwesomeIcons.map_pin, onPress: () {}),
                            JobDetailsWidget(title: "Status", subtitle: "${jobDetails.status}", icon: LineAwesomeIcons.wifi, onPress: () {}),
                            JobDetailsWidget(
                                title: "Maximum Budget",
                                subtitle: "৳ ${jobDetails.budget}",
                                icon: LineAwesomeIcons.hand_holding_us_dollar,
                                onPress: () {}),
                            JobDetailsWidget(
                                title: "Required Skill",
                                // subtitle: jobDetails.category != null
                                //     ? "Not Specified"
                                //     : "${jobDetails.category}",

                                subtitle: "${jobDetails.category}",
                                icon: LineAwesomeIcons.toolbox,
                                onPress: () {}),
                            const Divider(),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text("Job Descriptions", style: Theme.of(context).textTheme.headline5),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text("${jobDetails.description}", textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText1),
                            ),

                            const SizedBox(height: 20),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text("Additional Info", style: Theme.of(context).textTheme.headline5),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text("${jobDetails.additionalInfo}", textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText1),
                            ),

                            Divider(),

                            SizedBox(
                              width: double.infinity,
                              child: isMyPost
                                  ? Column(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(side: BorderSide.none, backgroundColor: TTS_PrimaryAccent),
                                            onPressed: () => Get.to(AllBidsByFilterScreen(
                                              filterByJobID: jobId,
                                              pageTitle: "Job Details: ${jobDetails.jobTitle}",
                                            )),
                                            child: Text("See Bids".toUpperCase()),
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Divider(),
                                        SizedBox(height: 20),
                                        isDelivered
                                            ? Column(
                                                children: [
                                                  SizedBox(
                                                    width: double.infinity,
                                                    child: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(side: BorderSide.none, backgroundColor: Colors.green),
                                                      onPressed: () {
                                                        Get.dialog(
                                                          AlertDialog(
                                                            title: Column(
                                                              children: [
                                                                Text(
                                                                  "Please Confirm?",
                                                                  style: Theme.of(context).textTheme.headline5!.apply(color: Colors.red),
                                                                ),
                                                                SizedBox(height: 10),
                                                                Divider(),
                                                              ],
                                                            ),
                                                            content: Text(
                                                              "Do you want to accept the deliverable/services provided by your bidder?",
                                                              style: Theme.of(context).textTheme.headline6,
                                                            ),
                                                            actions: [
                                                              Divider(),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        side: BorderSide.none,
                                                                        backgroundColor: TTS_LogoColor,
                                                                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0)),
                                                                    onPressed: () {
                                                                      jobController.acceptDelivery(jobID: jobId.toString());
                                                                    },
                                                                    child: Row(
                                                                      children: const [
                                                                        Icon(Icons.check),
                                                                        SizedBox(
                                                                          width: 5,
                                                                        ),
                                                                        Text("Accept Delivery"),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        side: BorderSide.none,
                                                                        backgroundColor: Colors.red,
                                                                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0)),
                                                                    onPressed: () => Get.back(),
                                                                    child: Row(
                                                                      children: const [
                                                                        Icon(Icons.close),
                                                                        SizedBox(
                                                                          width: 5,
                                                                        ),
                                                                        Text("Cancel"),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Icon(Icons.handshake),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text("Accept Deliverable".toUpperCase()),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 20),
                                                  FutureBuilder(
                                                    future: bidController.getAcceptedBidDetailsByJobID(jobId),
                                                    builder: (context, snapshot) {
                                                      if (snapshot.connectionState == ConnectionState.done) {
                                                        if (snapshot.hasData) {
                                                          final BidModel bidData = snapshot.data! as BidModel;
                                                          return FutureBuilder(
                                                            future: commonController.getUserDetailsByEmail(userEmail: bidData.bidderEmail!),
                                                            builder: (context, snapshot) {
                                                              if (snapshot.connectionState == ConnectionState.done) {
                                                                if (snapshot.hasData) {
                                                                  final UserModel userData = snapshot.data! as UserModel;
                                                                  return Container(
                                                                    margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                                                                    child: Card(
                                                                      color: Colors.grey.shade100,
                                                                      clipBehavior: Clip.antiAlias,
                                                                      elevation: 5,
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          SizedBox(
                                                                            height: 20,
                                                                          ),
                                                                          Container(
                                                                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                                                                            child: Row(
                                                                              children: [
                                                                                Text(
                                                                                  "BIDDER'S ",
                                                                                  style: Theme.of(context)
                                                                                      .textTheme
                                                                                      .headline5
                                                                                      ?.apply(color: Colors.teal),
                                                                                ),
                                                                                Text(
                                                                                  "CONTACT DETAILS",
                                                                                  style: Theme.of(context)
                                                                                      .textTheme
                                                                                      .headline5
                                                                                      ?.apply(color: Colors.black),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            // height: 140,
                                                                            child: Container(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  const Divider(color: Colors.black, thickness: 2),
                                                                                  const SizedBox(height: 5),
                                                                                  Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Row(
                                                                                        children: [
                                                                                          Icon(
                                                                                            Icons.person_3_rounded,
                                                                                            size: 20,
                                                                                            color: TTS_DarkColor,
                                                                                          ),
                                                                                          SizedBox(width: 5),
                                                                                          Text("${userData.fullName}",
                                                                                              style: TextStyle(color: TTS_DarkColor, fontSize: 20)),
                                                                                        ],
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  const SizedBox(height: 5),
                                                                                  const Divider(),
                                                                                  const SizedBox(height: 5),
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Row(
                                                                                            children: [
                                                                                              Icon(
                                                                                                Icons.phone,
                                                                                                size: 16,
                                                                                                color: TTS_DarkColor,
                                                                                              ),
                                                                                              SizedBox(width: 5),
                                                                                              Text(userData.phone,
                                                                                                  style:
                                                                                                      TextStyle(color: TTS_LogoColor, fontSize: 16)),
                                                                                            ],
                                                                                          ),
                                                                                          Row(
                                                                                            children: [
                                                                                              Icon(
                                                                                                Icons.email,
                                                                                                size: 16,
                                                                                                color: TTS_DarkColor,
                                                                                              ),
                                                                                              SizedBox(width: 5),
                                                                                              Text(userData.email,
                                                                                                  style:
                                                                                                      TextStyle(color: TTS_LogoColor, fontSize: 16)),
                                                                                            ],
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  const SizedBox(height: 5),
                                                                                  const Divider(),
                                                                                  const SizedBox(height: 5),
                                                                                  Row(
                                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                                    children: [
                                                                                      Text(
                                                                                        "You Will Pay: ",
                                                                                        maxLines: 1,
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                        style: Theme.of(context).textTheme.headline6?.apply(
                                                                                              color: TTS_DarkColor,
                                                                                              fontWeightDelta: -3,
                                                                                            ),
                                                                                      ),
                                                                                      Text(
                                                                                        "৳$bidPrice Taka",
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                        style: Theme.of(context).textTheme.headline5?.apply(
                                                                                              color: TTS_DarkColor,
                                                                                              fontWeightDelta: -1,
                                                                                            ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  const SizedBox(height: 5),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height: 60,
                                                                            child: Container(
                                                                              color: Colors.grey.shade300,
                                                                              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                                children: [
                                                                                  SizedBox(
                                                                                    child: ElevatedButton(
                                                                                      style: ElevatedButton.styleFrom(
                                                                                          side: BorderSide.none,
                                                                                          backgroundColor: TTS_PrimaryAccent,
                                                                                          padding:
                                                                                              EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0)),
                                                                                      onPressed: () => _makePhoneCall('tel:${userData.phone}'),
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Icon(Icons.phone),
                                                                                          SizedBox(
                                                                                            width: 5,
                                                                                          ),
                                                                                          Text("Call ${userData.phone}"),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
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
                                              )
                                            : isFinished
                                                ? Column(
                                                    children: [
                                                      SizedBox(
                                                        width: double.infinity,
                                                        child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(side: BorderSide.none, backgroundColor: TTS_PrimaryAccent),
                                                          onPressed: null,
                                                          child: Text("You Accepted Deliverable".toUpperCase()),
                                                        ),
                                                      ),
                                                      SizedBox(height: 20),
                                                      FutureBuilder(
                                                        future: bidController.getAcceptedBidDetailsByJobID(jobId),
                                                        builder: (context, snapshot) {
                                                          if (snapshot.connectionState == ConnectionState.done) {
                                                            if (snapshot.hasData) {
                                                              final BidModel bidData = snapshot.data! as BidModel;
                                                              return FutureBuilder(
                                                                future: commonController.getUserDetailsByEmail(userEmail: bidData.bidderEmail!),
                                                                builder: (context, snapshot) {
                                                                  if (snapshot.connectionState == ConnectionState.done) {
                                                                    if (snapshot.hasData) {
                                                                      final UserModel userData = snapshot.data! as UserModel;
                                                                      return Container(
                                                                        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                                                                        child: Card(
                                                                          color: Colors.grey.shade100,
                                                                          clipBehavior: Clip.antiAlias,
                                                                          elevation: 5,
                                                                          child: Column(
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: [
                                                                              SizedBox(
                                                                                height: 20,
                                                                              ),
                                                                              Container(
                                                                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                                                                child: Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      "BIDDER'S ",
                                                                                      style: Theme.of(context)
                                                                                          .textTheme
                                                                                          .headline5
                                                                                          ?.apply(color: Colors.teal),
                                                                                    ),
                                                                                    Text(
                                                                                      "CONTACT DETAILS",
                                                                                      style: Theme.of(context)
                                                                                          .textTheme
                                                                                          .headline5
                                                                                          ?.apply(color: Colors.black),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                // height: 140,
                                                                                child: Container(
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                                                                                  child: Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      const Divider(color: Colors.black, thickness: 2),
                                                                                      const SizedBox(height: 5),
                                                                                      Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Row(
                                                                                            children: [
                                                                                              Icon(
                                                                                                Icons.person_3_rounded,
                                                                                                size: 20,
                                                                                                color: TTS_DarkColor,
                                                                                              ),
                                                                                              SizedBox(width: 5),
                                                                                              Text("${userData.fullName}",
                                                                                                  style:
                                                                                                      TextStyle(color: TTS_DarkColor, fontSize: 20)),
                                                                                            ],
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      const SizedBox(height: 5),
                                                                                      const Divider(),
                                                                                      const SizedBox(height: 5),
                                                                                      Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        children: [
                                                                                          Column(
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              Row(
                                                                                                children: [
                                                                                                  Icon(
                                                                                                    Icons.phone,
                                                                                                    size: 16,
                                                                                                    color: TTS_DarkColor,
                                                                                                  ),
                                                                                                  SizedBox(width: 5),
                                                                                                  Text(userData.phone,
                                                                                                      style: TextStyle(
                                                                                                          color: TTS_LogoColor, fontSize: 16)),
                                                                                                ],
                                                                                              ),
                                                                                              Row(
                                                                                                children: [
                                                                                                  Icon(
                                                                                                    Icons.email,
                                                                                                    size: 16,
                                                                                                    color: TTS_DarkColor,
                                                                                                  ),
                                                                                                  SizedBox(width: 5),
                                                                                                  Text(userData.email,
                                                                                                      style: TextStyle(
                                                                                                          color: TTS_LogoColor, fontSize: 16)),
                                                                                                ],
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      const SizedBox(height: 5),
                                                                                      const Divider(),
                                                                                      const SizedBox(height: 5),
                                                                                      Row(
                                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                                        children: [
                                                                                          Text(
                                                                                            "You Will Pay: ",
                                                                                            maxLines: 1,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                            style: Theme.of(context).textTheme.headline6?.apply(
                                                                                                  color: TTS_DarkColor,
                                                                                                  fontWeightDelta: -3,
                                                                                                ),
                                                                                          ),
                                                                                          Text(
                                                                                            "৳$bidPrice Taka",
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                            style: Theme.of(context).textTheme.headline5?.apply(
                                                                                                  color: TTS_DarkColor,
                                                                                                  fontWeightDelta: -1,
                                                                                                ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      const SizedBox(height: 5),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 60,
                                                                                child: Container(
                                                                                  color: Colors.grey.shade300,
                                                                                  padding:
                                                                                      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: [
                                                                                      SizedBox(
                                                                                        child: ElevatedButton(
                                                                                          style: ElevatedButton.styleFrom(
                                                                                              side: BorderSide.none,
                                                                                              backgroundColor: TTS_PrimaryAccent,
                                                                                              padding: EdgeInsets.symmetric(
                                                                                                  vertical: 5.0, horizontal: 10.0)),
                                                                                          onPressed: () => _makePhoneCall('tel:${userData.phone}'),
                                                                                          child: Row(
                                                                                            children: [
                                                                                              Icon(Icons.phone),
                                                                                              SizedBox(
                                                                                                width: 5,
                                                                                              ),
                                                                                              Text("Call ${userData.phone}"),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
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
                                                  )
                                                : isProgress
                                                    ? Column(
                                                        children: [
                                                          SizedBox(
                                                            width: double.infinity,
                                                            child: ElevatedButton(
                                                              style:
                                                                  ElevatedButton.styleFrom(side: BorderSide.none, backgroundColor: TTS_PrimaryAccent),
                                                              onPressed: null,
                                                              child: Text("Bidder Still Working".toUpperCase()),
                                                            ),
                                                          ),
                                                          SizedBox(height: 20),
                                                          FutureBuilder(
                                                            future: bidController.getAcceptedBidDetailsByJobID(jobId),
                                                            builder: (context, snapshot) {
                                                              if (snapshot.connectionState == ConnectionState.done) {
                                                                if (snapshot.hasData) {
                                                                  final BidModel bidData = snapshot.data! as BidModel;
                                                                  return FutureBuilder(
                                                                    future: commonController.getUserDetailsByEmail(userEmail: bidData.bidderEmail!),
                                                                    builder: (context, snapshot) {
                                                                      if (snapshot.connectionState == ConnectionState.done) {
                                                                        if (snapshot.hasData) {
                                                                          final UserModel userData = snapshot.data! as UserModel;
                                                                          return Container(
                                                                            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                                                                            child: Card(
                                                                              color: Colors.grey.shade100,
                                                                              clipBehavior: Clip.antiAlias,
                                                                              elevation: 5,
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  SizedBox(
                                                                                    height: 20,
                                                                                  ),
                                                                                  Container(
                                                                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                                                                    child: Row(
                                                                                      children: [
                                                                                        Text(
                                                                                          "BIDDER'S ",
                                                                                          style: Theme.of(context)
                                                                                              .textTheme
                                                                                              .headline5
                                                                                              ?.apply(color: Colors.teal),
                                                                                        ),
                                                                                        Text(
                                                                                          "CONTACT DETAILS",
                                                                                          style: Theme.of(context)
                                                                                              .textTheme
                                                                                              .headline5
                                                                                              ?.apply(color: Colors.black),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    // height: 140,
                                                                                    child: Container(
                                                                                      padding:
                                                                                          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                                                                                      child: Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          const Divider(color: Colors.black, thickness: 2),
                                                                                          const SizedBox(height: 5),
                                                                                          Column(
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              Row(
                                                                                                children: [
                                                                                                  Icon(
                                                                                                    Icons.person_3_rounded,
                                                                                                    size: 20,
                                                                                                    color: TTS_DarkColor,
                                                                                                  ),
                                                                                                  SizedBox(width: 5),
                                                                                                  Text("${userData.fullName}",
                                                                                                      style: TextStyle(
                                                                                                          color: TTS_DarkColor, fontSize: 20)),
                                                                                                ],
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                          const SizedBox(height: 5),
                                                                                          const Divider(),
                                                                                          const SizedBox(height: 5),
                                                                                          Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                                            children: [
                                                                                              Column(
                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                children: [
                                                                                                  Row(
                                                                                                    children: [
                                                                                                      Icon(
                                                                                                        Icons.phone,
                                                                                                        size: 16,
                                                                                                        color: TTS_DarkColor,
                                                                                                      ),
                                                                                                      SizedBox(width: 5),
                                                                                                      Text(userData.phone,
                                                                                                          style: TextStyle(
                                                                                                              color: TTS_LogoColor, fontSize: 16)),
                                                                                                    ],
                                                                                                  ),
                                                                                                  Row(
                                                                                                    children: [
                                                                                                      Icon(
                                                                                                        Icons.email,
                                                                                                        size: 16,
                                                                                                        color: TTS_DarkColor,
                                                                                                      ),
                                                                                                      SizedBox(width: 5),
                                                                                                      Text(userData.email,
                                                                                                          style: TextStyle(
                                                                                                              color: TTS_LogoColor, fontSize: 16)),
                                                                                                    ],
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                          const SizedBox(height: 5),
                                                                                          const Divider(),
                                                                                          const SizedBox(height: 5),
                                                                                          Row(
                                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                                            children: [
                                                                                              Text(
                                                                                                "You Will Pay: ",
                                                                                                maxLines: 1,
                                                                                                overflow: TextOverflow.ellipsis,
                                                                                                style: Theme.of(context).textTheme.headline6?.apply(
                                                                                                      color: TTS_DarkColor,
                                                                                                      fontWeightDelta: -3,
                                                                                                    ),
                                                                                              ),
                                                                                              Text(
                                                                                                "৳$bidPrice Taka",
                                                                                                overflow: TextOverflow.ellipsis,
                                                                                                style: Theme.of(context).textTheme.headline5?.apply(
                                                                                                      color: TTS_DarkColor,
                                                                                                      fontWeightDelta: -1,
                                                                                                    ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                          const SizedBox(height: 5),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 60,
                                                                                    child: Container(
                                                                                      color: Colors.grey.shade300,
                                                                                      padding: const EdgeInsets.symmetric(
                                                                                          vertical: 10.0, horizontal: 20.0),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                                                        children: [
                                                                                          SizedBox(
                                                                                            child: ElevatedButton(
                                                                                              style: ElevatedButton.styleFrom(
                                                                                                  side: BorderSide.none,
                                                                                                  backgroundColor: TTS_PrimaryAccent,
                                                                                                  padding: EdgeInsets.symmetric(
                                                                                                      vertical: 5.0, horizontal: 10.0)),
                                                                                              onPressed: () =>
                                                                                                  _makePhoneCall('tel:${userData.phone}'),
                                                                                              child: Row(
                                                                                                children: [
                                                                                                  Icon(Icons.phone),
                                                                                                  SizedBox(
                                                                                                    width: 5,
                                                                                                  ),
                                                                                                  Text("Call ${userData.phone}"),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
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
                                                      )
                                                    : Text(""),
                                      ],
                                    )
                                  : isHiring
                                      ? FutureBuilder<List<BidModel>>(
                                          future:
                                              bidController.getAllBidsByFilter(filterByJobID: jobId, filterByEmail: commonController.getUserEmail()),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.done) {
                                              if (snapshot.hasData) {
                                                final isBidable = snapshot.data?.isEmpty;
                                                return isBidable!
                                                    ? SizedBox(
                                                        width: double.infinity,
                                                        child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(side: BorderSide.none),
                                                          onPressed: () => Get.to(BiddingOnJobScreen(jobID: jobId)),
                                                          child: Text("Bid For This Job".toUpperCase()),
                                                        ),
                                                      )
                                                    : SizedBox(
                                                        width: double.infinity,
                                                        child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(side: BorderSide.none),
                                                          onPressed: null,
                                                          child: Text("You Already Bid".toUpperCase()),
                                                        ),
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
                                        )
                                      : isOrder!
                                          ? isProgress
                                              ? Column(
                                                  children: [
                                                    SizedBox(height: 20),
                                                    SizedBox(
                                                      width: double.infinity,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton.styleFrom(side: BorderSide.none, backgroundColor: TTS_LogoColor),
                                                        onPressed: () {
                                                          Get.dialog(
                                                            AlertDialog(
                                                              title: Column(
                                                                children: [
                                                                  Text(
                                                                    "Please Confirm?",
                                                                    style: Theme.of(context).textTheme.headline5!.apply(color: Colors.red),
                                                                  ),
                                                                  SizedBox(height: 10),
                                                                  Divider(),
                                                                ],
                                                              ),
                                                              content: Text(
                                                                "Do you want to mark this job as completed?",
                                                                style: Theme.of(context).textTheme.headline6,
                                                              ),
                                                              actions: [
                                                                Divider(),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    ElevatedButton(
                                                                      style: ElevatedButton.styleFrom(
                                                                          side: BorderSide.none,
                                                                          backgroundColor: TTS_LogoColor,
                                                                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0)),
                                                                      onPressed: () {
                                                                        jobController.deliverOrder(jobID: jobId.toString());
                                                                      },
                                                                      child: Row(
                                                                        children: const [
                                                                          Icon(Icons.check),
                                                                          SizedBox(
                                                                            width: 5,
                                                                          ),
                                                                          Text("Mark Delivered"),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    ElevatedButton(
                                                                      style: ElevatedButton.styleFrom(
                                                                          side: BorderSide.none,
                                                                          backgroundColor: Colors.red,
                                                                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0)),
                                                                      onPressed: () => Get.back(),
                                                                      child: Row(
                                                                        children: const [
                                                                          Icon(Icons.close),
                                                                          SizedBox(
                                                                            width: 5,
                                                                          ),
                                                                          Text("Cancel"),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Icon(Icons.flight_takeoff_rounded),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text("Mark Delivered".toUpperCase()),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 20),
                                                    FutureBuilder(
                                                      future: commonController.getUserDetailsByEmail(userEmail: jobDetails.email!),
                                                      builder: (context, snapshot) {
                                                        if (snapshot.connectionState == ConnectionState.done) {
                                                          if (snapshot.hasData) {
                                                            final UserModel userData = snapshot.data! as UserModel;

                                                            return Container(
                                                              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                                                              child: Card(
                                                                color: Colors.grey.shade100,
                                                                clipBehavior: Clip.antiAlias,
                                                                elevation: 5,
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    SizedBox(
                                                                      height: 20,
                                                                    ),
                                                                    Container(
                                                                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                                                                      child: Row(
                                                                        children: [
                                                                          Text(
                                                                            "CLIENT'S ",
                                                                            style: Theme.of(context).textTheme.headline5?.apply(color: Colors.teal),
                                                                          ),
                                                                          Text(
                                                                            "CONTACT DETAILS",
                                                                            style: Theme.of(context).textTheme.headline5?.apply(color: Colors.black),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      // height: 140,
                                                                      child: Container(
                                                                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                                                                        child: Column(
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: [
                                                                            const Divider(color: Colors.black, thickness: 2),
                                                                            const SizedBox(height: 5),
                                                                            Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Row(
                                                                                  children: [
                                                                                    Icon(
                                                                                      Icons.person_3_rounded,
                                                                                      size: 20,
                                                                                      color: TTS_DarkColor,
                                                                                    ),
                                                                                    SizedBox(width: 5),
                                                                                    Text("${userData.fullName}",
                                                                                        style: TextStyle(color: TTS_DarkColor, fontSize: 20)),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            const SizedBox(height: 5),
                                                                            const Divider(),
                                                                            const SizedBox(height: 5),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Row(
                                                                                      children: [
                                                                                        Icon(
                                                                                          Icons.phone,
                                                                                          size: 16,
                                                                                          color: TTS_DarkColor,
                                                                                        ),
                                                                                        SizedBox(width: 5),
                                                                                        Text(userData.phone,
                                                                                            style: TextStyle(color: TTS_LogoColor, fontSize: 16)),
                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        Icon(
                                                                                          Icons.email,
                                                                                          size: 16,
                                                                                          color: TTS_DarkColor,
                                                                                        ),
                                                                                        SizedBox(width: 5),
                                                                                        Text(userData.email,
                                                                                            style: TextStyle(color: TTS_LogoColor, fontSize: 16)),
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            const SizedBox(height: 5),
                                                                            const Divider(),
                                                                            const SizedBox(height: 5),
                                                                            Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Text(
                                                                                  "You Will Get: ",
                                                                                  maxLines: 1,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: Theme.of(context).textTheme.headline6?.apply(
                                                                                        color: TTS_DarkColor,
                                                                                        fontWeightDelta: -3,
                                                                                      ),
                                                                                ),
                                                                                Text(
                                                                                  "৳$bidPrice Taka",
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: Theme.of(context).textTheme.headline5?.apply(
                                                                                        color: TTS_DarkColor,
                                                                                        fontWeightDelta: -1,
                                                                                      ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            const SizedBox(height: 5),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 60,
                                                                      child: Container(
                                                                        color: Colors.grey.shade300,
                                                                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                                          children: [
                                                                            SizedBox(
                                                                              child: ElevatedButton(
                                                                                style: ElevatedButton.styleFrom(
                                                                                    side: BorderSide.none,
                                                                                    backgroundColor: TTS_PrimaryAccent,
                                                                                    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0)),
                                                                                onPressed: () => _makePhoneCall('tel:${userData.phone}'),
                                                                                child: Row(
                                                                                  children: [
                                                                                    Icon(Icons.phone),
                                                                                    SizedBox(
                                                                                      width: 5,
                                                                                    ),
                                                                                    Text("Call ${userData.phone}"),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
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
                                                )
                                              : Column(
                                                  children: [
                                                    SizedBox(height: 20),
                                                    FutureBuilder(
                                                      future: commonController.getUserDetailsByEmail(userEmail: jobDetails.email!),
                                                      builder: (context, snapshot) {
                                                        if (snapshot.connectionState == ConnectionState.done) {
                                                          if (snapshot.hasData) {
                                                            final UserModel userData = snapshot.data! as UserModel;

                                                            return Container(
                                                              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                                                              child: Card(
                                                                color: Colors.grey.shade100,
                                                                clipBehavior: Clip.antiAlias,
                                                                elevation: 5,
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    SizedBox(
                                                                      height: 20,
                                                                    ),
                                                                    Container(
                                                                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                                                                      child: Row(
                                                                        children: [
                                                                          Text(
                                                                            "CLIENT'S ",
                                                                            style: Theme.of(context).textTheme.headline5?.apply(color: Colors.teal),
                                                                          ),
                                                                          Text(
                                                                            "CONTACT DETAILS",
                                                                            style: Theme.of(context).textTheme.headline5?.apply(color: Colors.black),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      // height: 140,
                                                                      child: Container(
                                                                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                                                                        child: Column(
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: [
                                                                            const Divider(color: Colors.black, thickness: 2),
                                                                            const SizedBox(height: 5),
                                                                            Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Row(
                                                                                  children: [
                                                                                    Icon(
                                                                                      Icons.person_3_rounded,
                                                                                      size: 20,
                                                                                      color: TTS_DarkColor,
                                                                                    ),
                                                                                    SizedBox(width: 5),
                                                                                    Text("${userData.fullName}",
                                                                                        style: TextStyle(color: TTS_DarkColor, fontSize: 20)),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            const SizedBox(height: 5),
                                                                            const Divider(),
                                                                            const SizedBox(height: 5),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Row(
                                                                                      children: [
                                                                                        Icon(
                                                                                          Icons.phone,
                                                                                          size: 16,
                                                                                          color: TTS_DarkColor,
                                                                                        ),
                                                                                        SizedBox(width: 5),
                                                                                        Text(userData.phone,
                                                                                            style: TextStyle(color: TTS_LogoColor, fontSize: 16)),
                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        Icon(
                                                                                          Icons.email,
                                                                                          size: 16,
                                                                                          color: TTS_DarkColor,
                                                                                        ),
                                                                                        SizedBox(width: 5),
                                                                                        Text(userData.email,
                                                                                            style: TextStyle(color: TTS_LogoColor, fontSize: 16)),
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            const SizedBox(height: 5),
                                                                            const Divider(),
                                                                            const SizedBox(height: 5),
                                                                            Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Text(
                                                                                  "You Will Get: ",
                                                                                  maxLines: 1,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: Theme.of(context).textTheme.headline6?.apply(
                                                                                        color: TTS_DarkColor,
                                                                                        fontWeightDelta: -3,
                                                                                      ),
                                                                                ),
                                                                                Text(
                                                                                  "৳$bidPrice Taka",
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: Theme.of(context).textTheme.headline5?.apply(
                                                                                        color: TTS_DarkColor,
                                                                                        fontWeightDelta: -1,
                                                                                      ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            const SizedBox(height: 5),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 60,
                                                                      child: Container(
                                                                        color: Colors.grey.shade300,
                                                                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                                          children: [
                                                                            SizedBox(
                                                                              child: ElevatedButton(
                                                                                style: ElevatedButton.styleFrom(
                                                                                    side: BorderSide.none,
                                                                                    backgroundColor: TTS_PrimaryAccent,
                                                                                    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0)),
                                                                                onPressed: () => _makePhoneCall('tel:${userData.phone}'),
                                                                                child: Row(
                                                                                  children: [
                                                                                    Icon(Icons.phone),
                                                                                    SizedBox(
                                                                                      width: 5,
                                                                                    ),
                                                                                    Text("Call ${userData.phone}"),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
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
                                                )
                                          : Column(
                                              children: [
                                                SizedBox(height: 20),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(side: BorderSide.none),
                                                    onPressed: null,
                                                    child: Text("Hired | Status: ${jobDetails.status}".toUpperCase()),
                                                  ),
                                                ),
                                              ],
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
      ),
    );
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could Not Call: $url';
    }
  }
}
