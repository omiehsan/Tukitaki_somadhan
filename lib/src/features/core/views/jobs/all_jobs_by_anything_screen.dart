import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:tasking/src/constants/colors.dart';
import 'package:tasking/src/features/core/views/dash/dashboard_view.dart';

import '../../../../repository/common_repo/common_controller.dart';
import '../../controllers/bid_controller.dart';
import '../../controllers/job_controller.dart';
import '../../models/bid_model.dart';
import '../../models/job_model.dart';
import 'job_details_screen.dart';

class AllJobsByFilterScreen extends StatelessWidget {
  AllJobsByFilterScreen({
    Key? key,
    this.filterByCat,
    this.filterByEmail,
    this.pageTitle,
    this.filterByStatus,
  }) : super(key: key) {
    pageTitle = pageTitle ??= "All Jobs";
  }

  final String? filterByEmail;
  final String? filterByCat;
  final String? filterByStatus;
  String? pageTitle;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    final controller = Get.put(JobPostController());
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
          padding: EdgeInsets.all(20.0),
          child: FutureBuilder<List<JobModel>>(
            future: controller.getAllJobsByFilter(filterByCat: filterByCat, filterByEmail: filterByEmail, filterByStatus: filterByStatus),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  final jobFilterData = snapshot.data!;
                  return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemExtent: 200,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final bidController = Get.put(BidPostController());
                        final jobId = jobFilterData[index].id;
                        final isMyPost = jobFilterData[index].email == commonController.getUserEmail();
                        final onlyHiring = jobFilterData[index].status.toString() == "Hiring";
                        // final onlyHiring = jobFilterData[index].status.toString() == "Hiring";
                        // print(filterByStatus);
                        // print(jobFilterData.length);
                        // print(onlyHiring);
                        if (filterByStatus == "Hiring") {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ListTile(
                                // minVerticalPadding: 10,
                                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                onTap: () {
                                  final String? jobId = jobFilterData[index].id;
                                  final jobDate = DateFormat.yMMMMd().format(jobFilterData[index].date);
                                  Get.to(JobDetailScreen(jobId: jobId));
                                  print(jobFilterData[index].id);
                                },
                                shape: RoundedRectangleBorder(
                                  side: isMyPost ? BorderSide(width: 2.0, color: TTS_LightBlack) : BorderSide(width: 2.0, color: TTS_LogoColor),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                textColor: TTS_DarkColor,
                                iconColor: TTS_LogoColor,
                                tileColor: isMyPost ? Colors.black12 : Colors.white38,
                                // leading: Column(
                                //   mainAxisAlignment: MainAxisAlignment.end,
                                //   children: const [
                                //     CircleAvatar(
                                //       child: Icon(Icons.bookmark_added_outlined),
                                //       backgroundColor: TTS_DarkColor,
                                //     ),
                                //   ],
                                // ),
                                title: Row(
                                  children: [
                                    isMyPost ? const Icon(Icons.check, color: TTS_LogoColor) : const Text(""),
                                    isMyPost ? const SizedBox(width: 5) : const Text(""),
                                    Text(
                                      jobFilterData[index].jobTitle,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(jobFilterData[index].description,
                                        style: TextStyle(fontSize: 14.0), maxLines: 1, overflow: TextOverflow.ellipsis),
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
                                                Text(jobFilterData[index].location, style: TextStyle(color: TTS_LogoColor)),
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
                                                Text(DateFormat('MMM dd, yyyy - hh:mm a').format(jobFilterData[index].date),
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
                                                Text("${jobFilterData[index].status}", style: TextStyle(color: TTS_LogoColor)),
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
                                                SizedBox(
                                                  width: 150,
                                                  child: Text(
                                                    isMyPost ? "You" : "${jobFilterData[index].createdBy}",
                                                    style: isMyPost ? TextStyle(color: Colors.red) : TextStyle(color: TTS_LogoColor),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Divider(color: Colors.black45),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Budget: ", style: Theme.of(context).textTheme.headline5!.apply(color: TTS_DarkColor)),
                                        Text("৳${jobFilterData[index].budget}",
                                            style: Theme.of(context).textTheme.headline5!.apply(color: TTS_LogoColor)),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            FutureBuilder<List<BidModel>>(
                                              future: bidController.getAllBidsByFilter(filterByJobID: jobId),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState == ConnectionState.done) {
                                                  if (snapshot.hasData) {
                                                    final bidCount = snapshot.data?.length;
                                                    return Row(
                                                      children: [
                                                        Text(" ($bidCount Applied)",
                                                            style: Theme.of(context).textTheme.headline5!.apply(color: TTS_PrimaryAccent)),
                                                      ],
                                                    );
                                                  } else if (snapshot.hasError) {
                                                    // return const Center(child: Text("Something Went Wrong!"));
                                                    return Center(child: Text(snapshot.error.toString()));
                                                  } else {
                                                    return const Center(child: Text("Something Went Wrong!"));
                                                  }
                                                } else {
                                                  // return const Center(child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator()));
                                                  return Center(
                                                    child: SizedBox(
                                                        height: 30,
                                                        child: Lottie.network('https://assets1.lottiefiles.com/packages/lf20_p8bfn5to.json',
                                                            repeat: true, animate: true)),
                                                  );
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    // Positioned(
                                    //   child: Icon(Icons.flash_on_rounded),
                                    //   bottom: 0,
                                    //   right: 0,
                                    // ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          );
                        } else {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ListTile(
                                // minVerticalPadding: 10,
                                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                onTap: () {
                                  final String? jobId = jobFilterData[index].id;
                                  final jobDate = DateFormat.yMMMMd().format(jobFilterData[index].date);
                                  Get.to(JobDetailScreen(jobId: jobId));
                                  print(jobFilterData[index].id);
                                },
                                shape: RoundedRectangleBorder(
                                  side: isMyPost ? BorderSide(width: 2.0, color: TTS_LightBlack) : BorderSide(width: 2.0, color: TTS_LogoColor),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                textColor: TTS_DarkColor,
                                iconColor: TTS_LogoColor,
                                tileColor: isMyPost ? Colors.black12 : Colors.white38,
                                // leading: Column(
                                //   mainAxisAlignment: MainAxisAlignment.end,
                                //   children: const [
                                //     CircleAvatar(
                                //       child: Icon(Icons.bookmark_added_outlined),
                                //       backgroundColor: TTS_DarkColor,
                                //     ),
                                //   ],
                                // ),
                                title: Row(
                                  children: [
                                    isMyPost ? const Icon(Icons.check, color: TTS_LogoColor) : const Text(""),
                                    isMyPost ? const SizedBox(width: 5) : const Text(""),
                                    Text(
                                      jobFilterData[index].jobTitle,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(jobFilterData[index].description,
                                        style: TextStyle(fontSize: 14.0), maxLines: 1, overflow: TextOverflow.ellipsis),
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
                                                Text(jobFilterData[index].location, style: TextStyle(color: TTS_LogoColor)),
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
                                                Text(DateFormat('MMM dd, yyyy - hh:mm a').format(jobFilterData[index].date),
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
                                                Text("${jobFilterData[index].status}", style: TextStyle(color: TTS_LogoColor)),
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
                                                SizedBox(
                                                  width: 150,
                                                  child: Text(
                                                    isMyPost ? "You" : "${jobFilterData[index].createdBy}",
                                                    style: isMyPost ? TextStyle(color: Colors.red) : TextStyle(color: TTS_LogoColor),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Divider(color: Colors.black45),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Budget: ", style: Theme.of(context).textTheme.headline5!.apply(color: TTS_DarkColor)),
                                        Text("৳${jobFilterData[index].budget}",
                                            style: Theme.of(context).textTheme.headline5!.apply(color: TTS_LogoColor)),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            FutureBuilder<List<BidModel>>(
                                              future: bidController.getAllBidsByFilter(filterByJobID: jobId),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState == ConnectionState.done) {
                                                  if (snapshot.hasData) {
                                                    final bidCount = snapshot.data?.length;
                                                    return Row(
                                                      children: [
                                                        Text(" ($bidCount Applied)",
                                                            style: Theme.of(context).textTheme.headline5!.apply(color: TTS_PrimaryAccent)),
                                                      ],
                                                    );
                                                  } else if (snapshot.hasError) {
                                                    // return const Center(child: Text("Something Went Wrong!"));
                                                    return Center(child: Text(snapshot.error.toString()));
                                                  } else {
                                                    return const Center(child: Text("Something Went Wrong!"));
                                                  }
                                                } else {
                                                  // return const Center(child: CircularProgressIndicator());
                                                  return Center(
                                                    child: SizedBox(
                                                        height: 30,
                                                        child: Lottie.network('https://assets1.lottiefiles.com/packages/lf20_p8bfn5to.json',
                                                            repeat: true, animate: true)),
                                                  );
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                // trailing: Column(
                                //   mainAxisAlignment: MainAxisAlignment.end,
                                //   children: [
                                //     // const SizedBox(height: 30),
                                //     Text("৳ ${jobFilterData[index].budget}", style: Theme.of(context).textTheme.headline5!.apply(color: TTS_LogoColor)),
                                //   ],
                                // ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          );
                        }
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
