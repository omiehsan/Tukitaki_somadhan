import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tasking/src/constants/colors.dart';
import 'package:tasking/src/constants/texts.dart';
import 'package:tasking/src/features/core/views/dash/dashboard_view.dart';

import '../../../auth/models/users_model.dart';
import '../../controllers/profile_controller.dart';

class AllUsersScreen extends StatelessWidget {
  const AllUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    final controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TTS_WhiteColor,
        leading: IconButton(
            icon: const Icon(LineAwesomeIcons.window_close),
            color: TTS_DarkColor,
            onPressed: () {
              Get.to(const DashboardScreen());
            }),
        title: Text(
          TTS_All_Users,
          style: Theme.of(context).textTheme.headline4,
        ),
        actions: [IconButton(color: TTS_DarkColor, onPressed: () {}, icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))],
      ),
      // bottomNavigationBar: TTS_BottomNavBar(),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder<List<UserModel>>(
          future: controller.getAllUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final userData = snapshot.data;
                return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemExtent: 110,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 1.0, color: TTS_LogoAccent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            textColor: TTS_DarkColor,
                            iconColor: TTS_LogoColor,
                            tileColor: Colors.black12,
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  child: Icon(Icons.account_circle_outlined),
                                  backgroundColor: TTS_DarkColor,
                                ),
                              ],
                            ),
                            title: Text(
                              "${userData![index].fullName}",
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                              maxLines: 1,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${userData[index].email}", style: TextStyle(fontSize: 14.0), maxLines: 1),
                                Row(
                                  children: [
                                    Icon(Icons.phone_in_talk_outlined, size: 14),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text("${userData[index].phone}", style: TextStyle(color: TTS_LogoColor)),
                                  ],
                                ),
                              ],
                            ),
                            trailing: Icon(Icons.verified_user),
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
    );
  }
}
