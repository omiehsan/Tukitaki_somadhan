import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tasking/src/constants/colors.dart';
import 'package:tasking/src/features/core/views/dash/dashboard_view.dart';
import 'package:tasking/src/features/core/views/jobs/job_details_screen.dart';

import '../../../../repository/common_repo/common_controller.dart';
import '../../controllers/bid_controller.dart';
import '../../controllers/job_controller.dart';
import '../../models/bid_model.dart';
import '../../models/job_model.dart';

class AllOrdersByFilterScreen extends StatelessWidget {
  AllOrdersByFilterScreen({
    Key? key,
    // this.filterByJobID,
    // this.filterByEmail,
    this.pageTitle,
  }) : super(key: key) {
    pageTitle = pageTitle ??= "All Orders";
  }

  // final String? filterByEmail;
  // final String? filterByJobID;
  String? pageTitle;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    final bidController = Get.put(BidPostController());
    final jobController = Get.put(JobPostController());
    final commonController = Get.put(CommonUseController());
    final myEmailBids = commonController.getUserEmail();
    RxDouble myRxBalance = 0.00.obs;
    RxDouble myRxInProgress = 0.00.obs;
    double myBalance = 0.00;
    double myInProgress = 0.00;

    updateAccountBalance() async {
      await Future.delayed(const Duration(milliseconds: 2000));
      myRxBalance.value = myBalance;
      myRxInProgress.value = myInProgress;
    }

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
        // padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 2, color: Colors.deepPurple.shade400),
                ),
                color: Colors.grey.shade200, // Your desired background color
                // borderRadius: BorderRadius.circular(5.0),
                // boxShadow: [
                //   BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 8, spreadRadius: 1),
                // ],
              ),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.black45),
                        color: Colors.deepPurple.shade400, // Your desired background color
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 8, spreadRadius: 1),
                        ]),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(backgroundColor: TTS_WhiteColor, child: Icon(Icons.monetization_on, color: TTS_LogoColor)),
                              const SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Balance", style: Theme.of(context).textTheme.subtitle1?.apply(color: Colors.black)),
                                  Text("From Finished Jobs",
                                      style: Theme.of(context).textTheme.bodyText2?.apply(color: Colors.black.withOpacity(0.8))),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "৳ ",
                                style: Theme.of(context).textTheme.headline5?.apply(
                                      color: TTS_DarkColor,
                                      fontWeightDelta: 3,
                                    ),
                              ),
                              Obx(
                                () => Text(
                                  "$myRxBalance",
                                  style: Theme.of(context).textTheme.headline5?.apply(
                                        color: TTS_DarkColor,
                                        fontWeightDelta: 3,
                                      ),
                                ),
                              ),
                            ],
                          ),

                          // FutureBuilder<List<BidModel>>(
                          //     future: bidController.getBalanceByAcceptedBid(balanceByBidEmail: myEmailBids),
                          //     builder: (context, snapshot) {
                          //       if (snapshot.connectionState == ConnectionState.done) {
                          //         if (snapshot.hasData) {
                          //           final bidData = snapshot.data!;
                          //
                          //           // num accountBalance = 0.00;
                          //
                          //           for (var result in bidData) {
                          //             // accountBalance = accountBalance + result.askingPrice;
                          //           }
                          //
                          //           return Text(
                          //             "৳ $accountBalance2",
                          //             style: Theme.of(context).textTheme.headline5?.apply(
                          //                   color: TTS_DarkColor,
                          //                   fontWeightDelta: 3,
                          //                 ),
                          //           );
                          //         } else if (snapshot.hasError) {
                          //           return Text(
                          //             "Error!",
                          //             style: Theme.of(context).textTheme.headline5?.apply(
                          //                   color: TTS_DarkColor,
                          //                   fontWeightDelta: 3,
                          //                 ),
                          //           );
                          //         } else {
                          //           return Text(
                          //             "Wrong",
                          //             style: Theme.of(context).textTheme.headline5?.apply(
                          //                   color: TTS_DarkColor,
                          //                   fontWeightDelta: 3,
                          //                 ),
                          //           );
                          //         }
                          //       } else {
                          //         return const Center(child: CircularProgressIndicator());
                          //       }
                          //     }),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.black45),
                        color: Colors.grey.shade500, // Your desired background color
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 8, spreadRadius: 1),
                        ]),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(backgroundColor: TTS_WhiteColor, child: Icon(Icons.linear_scale_sharp, color: TTS_LogoColor)),
                              const SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Earning (In-Progress)", style: Theme.of(context).textTheme.subtitle1?.apply(color: Colors.black)),
                                  Text("From Running Jobs",
                                      style: Theme.of(context).textTheme.bodyText2?.apply(color: Colors.black.withOpacity(0.8))),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "৳ ",
                                style: Theme.of(context).textTheme.headline5?.apply(
                                      color: TTS_DarkColor,
                                      fontWeightDelta: 3,
                                    ),
                              ),
                              Obx(
                                () => Text(
                                  "$myRxInProgress",
                                  style: Theme.of(context).textTheme.headline5?.apply(
                                        color: TTS_DarkColor,
                                        fontWeightDelta: 3,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(height: 8),
            FutureBuilder<List<BidModel>>(
              future: bidController.getAllBidsByFilter(filterByEmail: myEmailBids),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    final bidFilterData = snapshot.data!;

                    return Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          // itemExtent: 110,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final isMyPost = commonController.getUserEmail() == bidFilterData[index].bidderName;
                            final jobIDFromBid = bidFilterData[index].jobID;
                            final isBidAccepted = bidFilterData[index].status == "Accepted";
                            if (isBidAccepted) {
                              return Column(
                                children: [
                                  FutureBuilder(
                                    future: jobController.getJobDetails(jobIDFromBid),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.done) {
                                        if (snapshot.hasData) {
                                          final JobModel jobDetailsData = snapshot.data! as JobModel;
                                          final isProgress = jobDetailsData.status == "In-Progress";
                                          final isDelivered = jobDetailsData.status == "Delivered";
                                          final isFinished = jobDetailsData.status == "Finished";
                                          var myIncome = bidFilterData[index].askingPrice;
                                          myBalance = myBalance + (isFinished ? myIncome : 0.00);
                                          myInProgress = myInProgress + (!isFinished ? myIncome : 0.00);
                                          updateAccountBalance();

                                          return Container(
                                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                            child: Card(
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
                                                          "ORDER #",
                                                          style: Theme.of(context).textTheme.headline5?.apply(color: Colors.black),
                                                        ),
                                                        Text(
                                                          "${bidFilterData[index].id?.substring(0, 7).toUpperCase()}",
                                                          style: Theme.of(context).textTheme.headline5?.apply(color: Colors.teal),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 140,
                                                    child: Container(
                                                      padding: const EdgeInsets.all(16.0),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          const Divider(color: Colors.black45),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons.maps_home_work_rounded,
                                                                        size: 12,
                                                                        color: TTS_DarkColor,
                                                                      ),
                                                                      SizedBox(width: 5),
                                                                      Text(jobDetailsData.location, style: TextStyle(color: TTS_LogoColor)),
                                                                      // Text("Uttara, Dhaka", style: TextStyle(color: TTS_LogoColor)),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons.timelapse,
                                                                        size: 12,
                                                                        color: TTS_DarkColor,
                                                                      ),
                                                                      SizedBox(width: 5),
                                                                      // Text("Mar 27, 2023 - 03:56 AM", style: TextStyle(color: TTS_LogoColor)),
                                                                      Text(DateFormat('MMM dd, yyyy - hh:mm a').format(jobDetailsData.date),
                                                                          style: TextStyle(color: TTS_LogoColor)),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                              Container(
                                                                height: 30,
                                                                child: const VerticalDivider(
                                                                  color: Colors.red,
                                                                  width: 20,
                                                                ),
                                                              ),
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons.wifi,
                                                                        size: 12,
                                                                        color: TTS_DarkColor,
                                                                      ),
                                                                      SizedBox(width: 5),
                                                                      // Text("In-Progress", style: TextStyle(color: TTS_LogoColor)),
                                                                      Text("${jobDetailsData.status}", style: TextStyle(color: TTS_LogoColor)),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons.account_circle_rounded,
                                                                        size: 12,
                                                                        color: TTS_DarkColor,
                                                                      ),
                                                                      SizedBox(width: 5),
                                                                      // Text("Marzia Sultana", style: TextStyle(color: TTS_LogoColor)),
                                                                      Text(isMyPost ? "You" : "${jobDetailsData.createdBy}",
                                                                          style: isMyPost
                                                                              ? TextStyle(color: Colors.red)
                                                                              : TextStyle(color: TTS_LogoColor)),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          const Divider(color: Colors.black45),
                                                          const SizedBox(height: 8),

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
                                                          // Text(
                                                          //   "${bidFilterData[index].bidderDescription}",
                                                          //   maxLines: 1,
                                                          //   overflow: TextOverflow.ellipsis,
                                                          //   style: Theme.of(context)
                                                          //       .textTheme
                                                          //       .subtitle2
                                                          //       ?.apply(color: Colors.black.withOpacity(0.9), fontWeightDelta: -3, fontSizeDelta: 1.2),
                                                          //   textAlign: TextAlign.justify,
                                                          // ),

                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Text(
                                                                "Job Earning: ",
                                                                maxLines: 1,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: Theme.of(context).textTheme.headline6?.apply(
                                                                      color: Colors.black,
                                                                      fontWeightDelta: -3,
                                                                    ),
                                                              ),
                                                              Text(
                                                                "৳${bidFilterData[index].askingPrice} Taka",
                                                                overflow: TextOverflow.ellipsis,
                                                                style: Theme.of(context).textTheme.headline5?.apply(
                                                                      color: TTS_LogoColor,
                                                                      fontWeightDelta: -1,
                                                                    ),
                                                              ),
                                                            ],
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
                                                          isDelivered
                                                              ? SizedBox(
                                                                  // width: 35,
                                                                  child: ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        side: BorderSide.none,
                                                                        backgroundColor: Colors.deepPurple.shade700,
                                                                        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0)),
                                                                    onPressed: null,
                                                                    child: Row(
                                                                      children: [
                                                                        Icon(Icons.flight_takeoff_rounded),
                                                                        SizedBox(
                                                                          width: 5,
                                                                        ),
                                                                        Text("Delivered"),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )
                                                              : isFinished
                                                                  ? SizedBox(
                                                                      // width: 35,
                                                                      child: ElevatedButton(
                                                                        style: ElevatedButton.styleFrom(
                                                                            side: BorderSide.none,
                                                                            backgroundColor: Colors.deepPurple.shade700,
                                                                            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0)),
                                                                        onPressed: null,
                                                                        child: Row(
                                                                          children: [
                                                                            Icon(Icons.flight_takeoff_rounded),
                                                                            SizedBox(
                                                                              width: 5,
                                                                            ),
                                                                            Text("Finished"),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : SizedBox(
                                                                      // width: 35,
                                                                      child: ElevatedButton(
                                                                        style: ElevatedButton.styleFrom(
                                                                            side: BorderSide.none,
                                                                            backgroundColor: Colors.deepPurple.shade700,
                                                                            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0)),
                                                                        onPressed: () {
                                                                          Get.dialog(
                                                                            AlertDialog(
                                                                              title: Column(
                                                                                children: [
                                                                                  Text(
                                                                                    "Please Confirm?",
                                                                                    style: Theme.of(context)
                                                                                        .textTheme
                                                                                        .headline5!
                                                                                        .apply(color: Colors.red),
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
                                                                                          padding:
                                                                                              EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0)),
                                                                                      onPressed: () {
                                                                                        jobController.deliverOrder(
                                                                                            jobID: jobDetailsData.id.toString());
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
                                                                        },
                                                                        child: Row(
                                                                          children: [
                                                                            Icon(Icons.flight_takeoff_rounded),
                                                                            SizedBox(
                                                                              width: 5,
                                                                            ),
                                                                            Text("Finish"),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                          SizedBox(
                                                            child: ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                  side: BorderSide.none,
                                                                  backgroundColor: TTS_LogoColor,
                                                                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0)),
                                                              onPressed: () {
                                                                final orderNumber = bidFilterData[index].id?.substring(0, 8).toUpperCase();
                                                                Get.to(JobDetailScreen(
                                                                  jobId: jobDetailsData.id,
                                                                  isOrder: true,
                                                                  bidPrice: bidFilterData[index].askingPrice,
                                                                  pageTitle: "Order Details #$orderNumber",
                                                                ));
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  Icon(Icons.content_paste_go_rounded),
                                                                  SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Text("Order Details"),
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
                                  const SizedBox(height: 10),
                                ],
                              );
                            }
                          }),
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
    );
  }
}
