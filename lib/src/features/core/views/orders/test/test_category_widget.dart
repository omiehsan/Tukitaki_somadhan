import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasking/src/features/core/views/jobs/all_jobs_screen.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/texts.dart';
import '../../../controllers/job_controller.dart';
import '../../../models/dash_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tasking/src/constants/colors.dart';
import 'package:tasking/src/features/core/views/dash/dashboard_view.dart';



class TestCategoryWidget extends StatelessWidget {
  TestCategoryWidget({
    Key? key,
    required this.textTheme,
  }) : super(key: key);

  final TextTheme textTheme;
  final catItems = DashCategoriesModel.catItems;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    final controller = Get.put(JobPostController());
    
    
    
    return  Container(
      padding: EdgeInsetsDirectional.all(20),
      child: SizedBox(
        width: double.infinity,
        height: 2500 ,

        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: catItems.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              // final catName = catItems[index].catName;
              // print(catItems);
              // Get.to(AllJobsScreen());
            },
            child: Container(
              padding: EdgeInsets.only(left: 16, top: 10, bottom: 10),
              child: Card(
                elevation: 3.0,
                clipBehavior: Clip.antiAlias,
                child: Container(
                  height: 300.0,
                  width: 140.0,
                  // padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: Image(image: AssetImage(catItems[index].catImage), fit: BoxFit.cover),
                      ),
                      SizedBox(
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.circle, color: Colors.green, size: 8.0),
                                SizedBox(width: 3.0),
                                Text("${catItems[index].catJobs}", style: TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(width: 3.0),
                                Text(TTS_Experts),
                              ],
                            ),
                            Divider(height: 1),
                            SizedBox(
                              height: 40,
                              width: 130,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(catItems[index].catName,
                                    textAlign: TextAlign.center,
                                    style: textTheme.headline6?.apply(color: Colors.black),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                            Divider(height: 1),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.check, color: TTS_LogoColor, size: 15.0),
                                SizedBox(width: 3.0),
                                Text("${catItems[index].catJobs}", style: TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(width: 3.0),
                                Text(TTS_Jobs_Posted),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
