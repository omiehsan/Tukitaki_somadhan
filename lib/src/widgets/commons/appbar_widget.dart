import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasking/src/features/core/views/jobs/all_jobs_by_anything_screen.dart';

import '../../constants/colors.dart';
import '../../constants/image_list.dart';
import '../../features/auth/models/users_model.dart';
import '../../features/core/controllers/profile_controller.dart';
import '../../features/core/views/profile/profile_screens.dart';

class TTS_AppBar extends StatelessWidget implements PreferredSizeWidget {
  TTS_AppBar({
    Key? key,
  }) : super(key: key);

  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(onPressed: () => Get.to(AllJobsByFilterScreen()), icon: const Icon(Icons.grid_view_rounded, color: Colors.black)),
      // title: Text(TTS_AppName, style: Theme.of(context).textTheme.headline5),
      title: Image(image: AssetImage(TTS_Logo_Square_Text), height: 50),
      centerTitle: true,
      elevation: 3,
      backgroundColor: Colors.white,
      actions: [
        FutureBuilder(
          future: controller.getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                UserModel user = snapshot.data as UserModel;
                return GestureDetector(
                  onTap: () => Get.to(ProfileScreen()),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: TTS_WhiteColor,
                      border: Border.all(width: 2, color: TTS_PrimaryAccent_Alt),
                      shape: BoxShape.circle,
                      // image: NetworkImage("https://source.unsplash.com/random/200x200/?face-${user.fullName}"),
                      // image: DecorationImage(image: AssetImage(TTS_All_User_Profile)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(
                        image: NetworkImage("https://source.unsplash.com/random/200x200/?face-${user.fullName}"),
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                // return const Center(child: Text("Something Went Wrong!"));
                return Center(child: Text(snapshot.error.toString()));
              } else {
                return const Text("");
              }
            } else {
              return const Text("");
            }
          },
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(55);
}
