import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tasking/src/constants/colors.dart';
import 'package:tasking/src/features/core/views/dash/dashboard_view.dart';

import '../../controllers/job_controller.dart';
import '../../models/job_model.dart';
import 'job_details_screen.dart';

class AllJobsScreen extends StatelessWidget {
  const AllJobsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    final controller = Get.put(JobPostController());

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
          "List of All Jobs",
          style: Theme.of(context).textTheme.headline5,
        ),
        actions: [IconButton(color: TTS_DarkColor, onPressed: () {}, icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))],
      ),
      // bottomNavigationBar: TTS_BottomNavBar(),
      body: Container(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: FutureBuilder<List<JobModel>>(
            future: controller.getAllJobs(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  final jobData = snapshot.data!;
                  return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemExtent: 110,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                              onTap: () {
                                final String? jobId = jobData[index].id;
                                final jobDate = DateFormat.yMMMMd().format(jobData[index].date);
                                Get.to(JobDetailScreen(jobId: jobId));
                                print(jobData[index].id);
                              },
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 1.0, color: TTS_LightBlack),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              textColor: TTS_DarkColor,
                              iconColor: TTS_LogoColor,
                              tileColor: Colors.black12,
                              leading: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CircleAvatar(
                                    child: const Icon(Icons.bookmark_added_outlined),
                                    backgroundColor: TTS_DarkColor,
                                  ),
                                ],
                              ),
                              title: Text(
                                "${jobData[index].jobTitle}",
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                                maxLines: 1,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${jobData[index].description}", style: TextStyle(fontSize: 14.0), maxLines: 1),
                                  Row(
                                    children: [
                                      Icon(Icons.pin_drop_outlined, size: 14),
                                      SizedBox(width: 5),
                                      Text("${jobData[index].location}", style: TextStyle(color: TTS_LogoColor)),
                                      SizedBox(width: 5),
                                      Text("|", style: TextStyle(color: TTS_LogoColor)),
                                      SizedBox(width: 5),
                                      Text("${DateFormat.MMMd().format(jobData[index].date)}", style: TextStyle(color: TTS_LogoColor)),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("৳ ${jobData[index].budget}", style: Theme.of(context).textTheme.headline5!.apply(color: TTS_LogoColor)),
                                  // SizedBox(
                                  //   width: 80,
                                  //   height: 26,
                                  //   child: ElevatedButton(
                                  //     style: ElevatedButton.styleFrom(
                                  //       backgroundColor: Colors.white38,
                                  //       foregroundColor: TTS_DarkColor,
                                  //       padding: EdgeInsets.all(0),
                                  //       shape: RoundedRectangleBorder(
                                  //         borderRadius: BorderRadius.circular(25),
                                  //       ),
                                  //     ),
                                  //     onPressed: () {},
                                  //     child: Text("Details", style: Theme.of(context).textTheme.bodySmall),
                                  //   ),
                                  // ),
                                ],
                              ),
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
