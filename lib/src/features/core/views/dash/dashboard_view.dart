import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasking/src/features/core/controllers/job_controller.dart';
import 'package:tasking/src/features/core/views/bids/all_bids_by_anything_screen.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/texts.dart';
import '../../../../repository/common_repo/common_controller.dart';
import '../../../../widgets/commons/appbar_widget.dart';
import '../../../../widgets/commons/bottombar_widget.dart';
import '../../../auth/models/users_model.dart';
import '../../controllers/bid_controller.dart';
import '../../controllers/profile_controller.dart';
import '../../models/bid_model.dart';
import '../../models/job_model.dart';
import '../jobs/all_jobs_by_anything_screen.dart';
import '../jobs/post_job_view.dart';
import 'widgets/blogtiles_widget.dart';
import 'widgets/category_widget.dart';
import 'widgets/searchbox_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final textTheme = Theme.of(context).textTheme;
    final dashController = Get.put(ProfileController());
    final jobController = Get.put(JobPostController());
    final bidController = Get.put(BidPostController());
    final commonController = Get.put(CommonUseController());

    return Scaffold(
      extendBody: true,
      appBar: TTS_AppBar(),
      bottomNavigationBar: TTS_BottomNavBar(),
      body: SingleChildScrollView(
        child: Container(
          // padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0),

              FutureBuilder(
                future: dashController.getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      UserModel userData = snapshot.data as UserModel;
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(TTS_App_Welcome, style: textTheme.subtitle1),
                            Text("${userData.fullName}", style: textTheme.headline3),
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      // return const Center(child: Text("Something Went Wrong!"));
                      return Center(child: Text(snapshot.error.toString()));
                    } else {
                      return const Center(child: Text("Something Went Wrong!"));
                    }
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(TTS_App_Welcome, style: textTheme.subtitle1),
                        Text("You", style: textTheme.headline3),
                      ],
                    );
                  }
                },
              ),

              // Account Stats
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: InkWell(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                            decoration: const BoxDecoration(
                              color: TTS_LightWhite,
                              border: Border(
                                bottom: BorderSide(width: 4, color: TTS_BlackColor),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(Icons.work_history, size: 50.0, color: Colors.deepOrange),
                                const SizedBox(width: 10.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FutureBuilder<List<JobModel>>(
                                      future: jobController.getAllJobsByFilter(filterByEmail: commonController.getUserEmail()),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.done) {
                                          if (snapshot.hasData) {
                                            // final jobFilterData = snapshot.data!;
                                            final jobCount = snapshot.data!.length;
                                            // return ListView.builder(
                                            //     shrinkWrap: true,
                                            //     scrollDirection: Axis.vertical,
                                            //     itemExtent: 110,
                                            //     itemCount: snapshot.data!.length,
                                            //     itemBuilder: (context, index) {
                                            //       return Text(numberofJobs.toString(), style: textTheme.headline2);
                                            //     });
                                            // print(jobCount.runtimeType);
                                            return Text("${jobCount.toString()}", style: textTheme.headline2);
                                            return Text("0", style: textTheme.headline2);
                                          } else if (snapshot.hasError) {
                                            return Center(child: Text(snapshot.error.toString(), style: textTheme.headline2));
                                          } else {
                                            return Center(child: Text("0", style: textTheme.headline2));
                                          }
                                        } else {
                                          return Center(child: Text("0", style: textTheme.headline2));
                                        }
                                      },
                                    ),
                                    const SizedBox(height: 3.0),
                                    Text("My Posts", style: textTheme.subtitle2),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          onTap: () => Get.to(AllJobsByFilterScreen(
                            filterByEmail: commonController.getUserEmail(),
                            pageTitle: "My Posted Jobs",
                          )),
                        ),
                      ),
                    ),
                    VerticalDivider(),
                    Expanded(
                      child: SizedBox(
                        child: InkWell(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                            decoration: const BoxDecoration(
                              color: TTS_LightWhite,
                              border: Border(
                                bottom: BorderSide(width: 4, color: TTS_BlackColor),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.stacked_line_chart_rounded, size: 50.0, color: Colors.green),
                                const SizedBox(width: 10.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FutureBuilder<List<BidModel>>(
                                      future: bidController.getAllBidsByFilter(filterByEmail: commonController.getUserEmail()),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.done) {
                                          if (snapshot.hasData) {
                                            // final jobFilterData = snapshot.data!;
                                            final bidCount = snapshot.data!.length;
                                            // return ListView.builder(
                                            //     shrinkWrap: true,
                                            //     scrollDirection: Axis.vertical,
                                            //     itemExtent: 110,
                                            //     itemCount: snapshot.data!.length,
                                            //     itemBuilder: (context, index) {
                                            //       return Text(numberofJobs.toString(), style: textTheme.headline2);
                                            //     });
                                            return Text(bidCount.toString(), style: textTheme.headline2);
                                          } else if (snapshot.hasError) {
                                            return Center(child: Text(snapshot.error.toString(), style: textTheme.headline2));
                                          } else {
                                            return Center(child: Text("0", style: textTheme.headline2));
                                          }
                                        } else {
                                          return Center(child: Text("0", style: textTheme.headline2));
                                        }
                                      },
                                    ),
                                    const SizedBox(height: 3.0),
                                    Text("My Bids", style: textTheme.subtitle2),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          onTap: () => Get.to(AllBidsByFilterScreen(
                            filterByEmail: commonController.getUserEmail(),
                            pageTitle: "My Bids",
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),

              // Account Details
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(child: const Icon(Icons.linear_scale_sharp, color: TTS_LogoColor), backgroundColor: TTS_WhiteColor),
                      title: Text("All Open Jobs", style: textTheme.subtitle1?.apply(color: Colors.black)),
                      subtitle: Text("Tap To View All Jobs", style: textTheme.bodyText2?.apply(color: Colors.black.withOpacity(0.8))),
                      trailing:
                          CircleAvatar(child: const Icon(Icons.bookmark_added, color: TTS_DarkColor, size: 40), backgroundColor: Colors.transparent),
                      tileColor: Colors.grey.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 2, color: TTS_LightBlack),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      onTap: () => Get.to(AllJobsByFilterScreen(pageTitle: "All Open Jobs", filterByStatus: "Hiring")),
                    ),
                    const SizedBox(height: TTS_DefaultSize - 10.0),
                    ListTile(
                      leading: CircleAvatar(child: const Icon(Icons.arrow_forward, color: TTS_LogoColor), backgroundColor: TTS_WhiteColor),
                      title: Text("Post Job", style: textTheme.subtitle1?.apply(color: Colors.black)),
                      subtitle: Text("Create A New Job Post", style: textTheme.bodyText2?.apply(color: Colors.black.withOpacity(0.8))),
                      trailing: CircleAvatar(child: const Icon(Icons.add, color: TTS_DarkColor, size: 40), backgroundColor: Colors.transparent),
                      tileColor: TTS_PrimaryAccent.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 2, color: TTS_LightBlack),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      onTap: () => Get.to(() => PostJobScreen()),
                    ),
                  ],
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20.0),
                child: Divider(
                  height: 1.0,
                ),
              ),

              // Search Box
              DashSearchWidget(textTheme: textTheme),

              const SizedBox(height: 15.0),

              // Services Categories
              DashCategoryWidget(textTheme: textTheme),

              const SizedBox(height: 40.0),

              // Curated Blogs Section
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Divider(
                      height: 30,
                    ),
                    Text("Support Center", style: textTheme.headline4?.apply(color: TTS_LogoColor)),
                    SizedBox(
                      height: 10,
                    ),
                    Text("16110 (২৪ ঘন্টা)", style: textTheme.headline5?.apply(color: TTS_DarkColor, fontWeightDelta: 600)),
                  ],
                ),
              ),

              const SizedBox(height: 10.0),

              // Curated Blogs Tiles
              DashBlogTiles(textTheme: textTheme),

              const SizedBox(height: 50.0),
            ],
          ),
        ),
      ),
    );
  }
}
