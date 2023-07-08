import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tasking/src/constants/colors.dart';
import 'package:tasking/src/constants/texts.dart';
import 'package:tasking/src/features/core/views/dash/dashboard_view.dart';
import 'package:tasking/src/features/core/views/profile/update_profile_screen.dart';
import 'package:tasking/src/features/core/views/profile/widgets/profile_menu.dart';

import '../../../../repository/auth_repo/auth_repo.dart';
import '../../../auth/models/users_model.dart';
import '../../controllers/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TTS_WhiteColor,
        leading: IconButton(
          color: TTS_DarkColor,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const DashboardScreen();
            }));
          },
          icon: Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          TTS_Profile,
          style: Theme.of(context).textTheme.headline4,
        ),
        actions: [IconButton(color: TTS_DarkColor, onPressed: () {}, icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(Material.defaultSplashRadius),
          child: Column(
            children: [
              FutureBuilder(
                future: controller.getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      UserModel userData = snapshot.data as UserModel;
                      return Column(
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                width: 120,
                                height: 120,
                                child: Container(
                                  decoration: BoxDecoration(
                                    // color: TTS_WhiteColor,
                                    border: Border.all(width: 4, color: TTS_LogoColor),
                                    shape: BoxShape.circle,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image(
                                      image: NetworkImage("https://source.unsplash.com/random/200x200/?face-${userData.fullName}"),
                                      height: 200,
                                      width: 200,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.red,
                                  ),
                                  child: const Icon(
                                    LineAwesomeIcons.alternate_pencil,
                                    size: 20.0,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text("${userData.fullName}", style: Theme.of(context).textTheme.headline4),
                          Text("${userData.email}", style: Theme.of(context).textTheme.bodyText1),
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

              const SizedBox(height: 10),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => UpdateProfileScreen()),
                  child: const Text(TTS_Edit_Profile, style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(backgroundColor: TTS_PrimaryColor, side: BorderSide.none, shape: StadiumBorder()),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),
              //menu
              ProfileMenuWidget(title: "Settings", icon: LineAwesomeIcons.cog, onPress: () {}),
              ProfileMenuWidget(title: "Billing Details ", icon: LineAwesomeIcons.wallet, onPress: () {}),
              ProfileMenuWidget(title: "User Management", icon: LineAwesomeIcons.user_check, onPress: () {}),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(title: "Information", icon: LineAwesomeIcons.info, onPress: () {}),
              ProfileMenuWidget(
                  title: "Logout",
                  icon: LineAwesomeIcons.alternate_sign_out,
                  textColor: Colors.red,
                  endicon: false,
                  onPress: () {
                    AuthRepo.instance.logOut();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
