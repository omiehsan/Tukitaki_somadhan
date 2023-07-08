import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tasking/src/constants/colors.dart';
import 'package:tasking/src/features/core/views/dash/dashboard_view.dart';

import '../../../../repository/common_repo/common_controller.dart';
import '../../controllers/bid_controller.dart';
import '../../controllers/job_controller.dart';
import '../../models/bid_model.dart';
import '../../models/job_model.dart';
import 'bid_details_screen.dart';

class AllBidsByFilterScreen extends StatelessWidget {
  AllBidsByFilterScreen({Key? key, this.filterByJobID, this.filterByEmail, this.pageTitle}) : super(key: key) {
    pageTitle = pageTitle ??= "All Bids";
  }

  final String? filterByEmail;
  final String? filterByJobID;
  String? pageTitle;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    final bidController = Get.put(BidPostController());

    final commonController = Get.put(CommonUseController());

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
          "$pageTitle",
          style: Theme.of(context).textTheme.headline5,
        ),
        actions: [IconButton(color: TTS_DarkColor, onPressed: () {}, icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))],
      ),
      // bottomNavigationBar: TTS_BottomNavBar(),
      body: Container(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: FutureBuilder<List<BidModel>>(
            future: bidController.getAllBidsByFilter(filterByJobID: filterByJobID, filterByEmail: filterByEmail),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  final bidFilterData = snapshot.data!;
                  final jobController = Get.put(JobPostController());
                  return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      // itemExtent: 110,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final isMyBid = bidFilterData[index].bidderEmail == commonController.getUserEmail();
                        final isAccepted = bidFilterData[index].status == "Accepted";
                        final isVoided = bidFilterData[index].status == "Void";
                        final jobIDFromBid = bidFilterData[index].jobID;
                        return Column(
                          children: [
                            FutureBuilder(
                              future: jobController.getJobDetails(jobIDFromBid),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.done) {
                                  if (snapshot.hasData) {
                                    final JobModel jobDetailsData = snapshot.data! as JobModel;

                                    return Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                      child: Card(
                                        clipBehavior: Clip.antiAlias,
                                        elevation: 5,
                                        child: Column(
                                          children: [
                                            Container(
                                              color: isAccepted ? TTS_LogoColor : Colors.grey.shade700,
                                              height: 75,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  ListTile(
                                                    tileColor: isAccepted ? TTS_LogoColor : Colors.grey.shade700,
                                                    leading: CircleAvatar(
                                                      radius: 22,
                                                      backgroundColor: Colors.white,
                                                      child: CircleAvatar(
                                                        radius: 20,
                                                        backgroundImage: NetworkImage(
                                                            "https://source.unsplash.com/random/100x100/?face-${bidFilterData[index].bidderName}"),
                                                        backgroundColor: Colors.white,
                                                      ),
                                                    ),
                                                    trailing: Container(
                                                      width: 150,
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          SizedBox(
                                                            width: 125,
                                                            child: Text(
                                                              "${bidFilterData[index].location}",
                                                              style: Theme.of(context).textTheme.bodyText2?.apply(color: TTS_WhiteColor),
                                                              overflow: TextOverflow.ellipsis,
                                                              maxLines: 1,
                                                              textAlign: TextAlign.end,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Icon(
                                                            Icons.pin_drop,
                                                            color: Colors.amberAccent,
                                                            size: 20,
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    // Row(
                                                    //   children: [
                                                    //   ],
                                                    // ),
                                                    title: Text(
                                                      "${bidFilterData[index].bidderName}",
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: Theme.of(context).textTheme.subtitle1?.apply(color: Colors.white),
                                                    ),
                                                    subtitle: Row(
                                                      children: [
                                                        const Icon(Icons.circle, color: Colors.green, size: 12.0),
                                                        const SizedBox(
                                                          width: 3.0,
                                                        ),
                                                        Text(
                                                          "Available",
                                                          style: Theme.of(context).textTheme.bodyText2?.apply(color: Colors.white.withOpacity(0.8)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 180,
                                              child: Container(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          Container(
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Column(
                                                                  children: [
                                                                    Text(
                                                                      "৳ ${jobDetailsData.budget}",
                                                                      maxLines: 1,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      style: Theme.of(context).textTheme.headline5?.apply(
                                                                            color: TTS_LogoColor,
                                                                            fontWeightDelta: -2,
                                                                          ),
                                                                      textAlign: TextAlign.center,
                                                                    ),
                                                                    Text(
                                                                      "Budget",
                                                                      maxLines: 1,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      style: Theme.of(context).textTheme.headline6?.apply(
                                                                            color: Colors.black,
                                                                            fontWeightDelta: 600,
                                                                          ),
                                                                      textAlign: TextAlign.center,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(height: 40, child: VerticalDivider(color: Colors.red)),
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Text(
                                                                "৳ ${bidFilterData[index].askingPrice}",
                                                                maxLines: 1,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: Theme.of(context).textTheme.headline5?.apply(
                                                                      color: TTS_LogoColor,
                                                                      fontWeightDelta: -2,
                                                                    ),
                                                                textAlign: TextAlign.center,
                                                              ),
                                                              Text(
                                                                "Asking Price",
                                                                maxLines: 1,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: Theme.of(context).textTheme.headline6?.apply(
                                                                      color: Colors.black,
                                                                      fontWeightDelta: 600,
                                                                    ),
                                                                textAlign: TextAlign.center,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const Divider(
                                                      height: 30,
                                                    ),
                                                    // Text(
                                                    //   "Offer Message:",
                                                    //   maxLines: 1,
                                                    //   overflow: TextOverflow.ellipsis,
                                                    //   style: Theme.of(context).textTheme.bodyText1?.apply(
                                                    //         color: Colors.black,
                                                    //         fontWeightDelta: 600,
                                                    //       ),
                                                    //   textAlign: TextAlign.justify,
                                                    // ),
                                                    Text(
                                                      "${bidFilterData[index].bidderDescription}",
                                                      maxLines: 3,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle2
                                                          ?.apply(color: Colors.black.withOpacity(0.9), fontWeightDelta: -3, fontSizeDelta: 1.2),
                                                      textAlign: TextAlign.justify,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 60,
                                              child: Container(
                                                color: Colors.grey.shade200,
                                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    // TextButton(child: const Text(TTS_Read_More), onPressed: () {}),
                                                    SizedBox(
                                                      // width: 35,
                                                      child: isMyBid
                                                          ? Row(
                                                              children: [
                                                                Text("Status: ",
                                                                    style:
                                                                        TextStyle(color: TTS_DarkColor, fontWeight: FontWeight.w700, fontSize: 14)),
                                                                Text("${bidFilterData[index].status}",
                                                                    style: TextStyle(
                                                                        color: isAccepted
                                                                            ? Colors.green
                                                                            : isVoided
                                                                                ? TTS_BlackColor
                                                                                : TTS_DarkColor,
                                                                        fontWeight: FontWeight.w500,
                                                                        fontSize: 14)),
                                                              ],
                                                            )
                                                          : ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                  side: BorderSide.none,
                                                                  backgroundColor: Colors.deepPurple.shade600,
                                                                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0)),
                                                              onPressed: () {
                                                                final String? bidId = bidFilterData[index].id;
                                                                Get.to(BidDetailScreen(bidId: bidId));
                                                                print(bidFilterData[index].id);
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  Icon(Icons.info_rounded),
                                                                ],
                                                              ),
                                                            ),
                                                    ),
                                                    SizedBox(
                                                      child: isMyBid
                                                          ? ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                  side: BorderSide.none,
                                                                  backgroundColor: Colors.deepPurpleAccent,
                                                                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0)),
                                                              onPressed: () {
                                                                final String? bidId = bidFilterData[index].id;
                                                                Get.to(BidDetailScreen(bidId: bidId));
                                                                print(bidFilterData[index].id);
                                                              },
                                                              child: Row(
                                                                children: const [
                                                                  Icon(Icons.content_paste_go_rounded),
                                                                  SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Text("My Bid Details"),
                                                                ],
                                                              ),
                                                            )
                                                          : isVoided
                                                              ? ElevatedButton(
                                                                  style: ElevatedButton.styleFrom(
                                                                      side: BorderSide.none,
                                                                      backgroundColor: TTS_LogoColor,
                                                                      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0)),
                                                                  onPressed: null,
                                                                  child: Row(
                                                                    children: const [
                                                                      Icon(Icons.close),
                                                                      SizedBox(
                                                                        width: 5,
                                                                      ),
                                                                      Text("Void"),
                                                                    ],
                                                                  ),
                                                                )
                                                              : isAccepted
                                                                  ? ElevatedButton(
                                                                      style: ElevatedButton.styleFrom(
                                                                          side: BorderSide.none,
                                                                          backgroundColor: TTS_LogoColor,
                                                                          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0)),
                                                                      onPressed: null,
                                                                      child: Row(
                                                                        children: const [
                                                                          Icon(Icons.check),
                                                                          SizedBox(
                                                                            width: 5,
                                                                          ),
                                                                          Text("Accepted"),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  : ElevatedButton(
                                                                      style: ElevatedButton.styleFrom(
                                                                          side: BorderSide.none,
                                                                          backgroundColor: TTS_LogoColor,
                                                                          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0)),
                                                                      onPressed: () {
                                                                        Get.dialog(
                                                                          AlertDialog(
                                                                            title: Column(
                                                                              children: [
                                                                                Text(
                                                                                  "Please Confirm?",
                                                                                  style:
                                                                                      Theme.of(context).textTheme.headline5!.apply(color: Colors.red),
                                                                                ),
                                                                                SizedBox(height: 10),
                                                                                Divider(),
                                                                              ],
                                                                            ),
                                                                            content: Text(
                                                                              "Do you want to accept the offered price BDT - ৳${bidFilterData[index].askingPrice} for this job?",
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
                                                                                        padding:
                                                                                            EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0)),
                                                                                    onPressed: () {
                                                                                      bidController.acceptBidPost(
                                                                                          bidID: bidFilterData[index].id.toString(),
                                                                                          jobID: bidFilterData[index].jobID.toString());
                                                                                      print("Bid ID: " + bidFilterData[index].id.toString());
                                                                                      print("Job ID: " + bidFilterData[index].jobID.toString());
                                                                                    },
                                                                                    child: Row(
                                                                                      children: const [
                                                                                        Icon(Icons.check),
                                                                                        SizedBox(
                                                                                          width: 5,
                                                                                        ),
                                                                                        Text("Accept"),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  ElevatedButton(
                                                                                    style: ElevatedButton.styleFrom(
                                                                                        side: BorderSide.none,
                                                                                        backgroundColor: Colors.red,
                                                                                        padding:
                                                                                            EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0)),
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
                                                                        // bidController.acceptBidPost(
                                                                        //     bidID: bidFilterData[index].id.toString(),
                                                                        //     jobID: bidFilterData[index].jobID.toString());
                                                                        print("Bid ID: " + bidFilterData[index].id.toString());
                                                                        print("Job ID: " + bidFilterData[index].jobID.toString());
                                                                      },
                                                                      child: Row(
                                                                        children: const [
                                                                          Icon(Icons.check),
                                                                          SizedBox(
                                                                            width: 5,
                                                                          ),
                                                                          Text("Accept Offer"),
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
                                  return const Text("");
                                }
                              },
                            ),
                            const SizedBox(height: 10),
                          ],
                        );
                      });
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
        ),
      ),
    );
  }
}
