import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/texts.dart';
import '../../../controllers/search_box_controller.dart';

class DashSearchWidget extends StatelessWidget {
  DashSearchWidget({
    Key? key,
    required this.textTheme,
  }) : super(key: key);

  final TextTheme textTheme;
  final SearchBoxController searchBoxController = Get.put(SearchBoxController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TTS_Dash_Title, style: textTheme.headline4),
          const SizedBox(height: 10.0),
          Container(
            padding: const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
            decoration: const BoxDecoration(border: Border(left: BorderSide(width: 4, color: TTS_PrimaryAccent))),
            child: TextButton(
              onPressed: () {
                Get.to(() => Scaffold(
                      appBar: AppBar(
                        backgroundColor: Colors.white,
                        iconTheme: IconThemeData(
                          color: Colors.black, // Set the back button color to black
                        ),
                        title: TextFormField(
                          onChanged: (query) {
                            searchBoxController.search(query);
                          },
                          decoration: InputDecoration(
                            hintText: "Search",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      body: Obx(() => ListView.builder(
                            itemCount: searchBoxController.searchResults.length,
                            itemBuilder: (context, index) {
                              final jobList = searchBoxController.searchResults[index];
                              return GestureDetector(
                                onTap: () {
                                  // Get.to(JobDetailScreen(jobId: item['id']));

                                  print('User Clicked! ${jobList['JobTitle']}');
                                },
                                child: ListTile(
                                  title: Text(jobList['JobTitle']),
                                  subtitle: Text(jobList['Location']),
                                  trailing: Text("৳ ${jobList['Budget']}"),
                                ),
                              );
                            },
                          )),
                    ));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(TTS_Search, style: textTheme.headline3?.apply(color: Colors.grey.withOpacity(0.5))),
                  Icon(Icons.mic),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// TextButton(
// onPressed: () {
// Get.to(() => Scaffold(
// appBar: AppBar(
// backgroundColor: Colors.white,
// iconTheme: IconThemeData(
// color: Colors.black, // Set the back button color to black
// ),
// title: TextFormField(
// onChanged: (query) {
// searchBoxController.search(query.toLowerCase());
// },
// decoration: InputDecoration(
// hintText: "Search",
// border: InputBorder.none,
// ),
// ),
// ),
// body: Obx(() => ListView.builder(
// itemCount: searchBoxController.searchResults.length,
// itemBuilder: (context, index) {
// var item = searchBoxController.searchResults[index];
// return ListTile(
// title: Text(item['FullName']),
// subtitle: Text(item['Email']),
// );
// },
// )),
// ));
// },
