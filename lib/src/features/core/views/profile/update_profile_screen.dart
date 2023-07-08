import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tasking/src/features/core/views/profile/profile_screens.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/texts.dart';
import '../../../auth/models/users_model.dart';
import '../../controllers/profile_controller.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    final controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TTS_WhiteColor,
        leading: IconButton(
          color: TTS_DarkColor,
          onPressed: () => Get.to(ProfileScreen()),
          icon: Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          TTS_Edit_Profile,
          style: Theme.of(context).textTheme.headline4,
        ),
        actions: [
          IconButton(color: TTS_DarkColor, onPressed: () {}, icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon)),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(Material.defaultSplashRadius),
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel user = snapshot.data as UserModel;

                  final fullName = TextEditingController(text: user.fullName);
                  final phone = TextEditingController(text: user.phone);
                  final email = TextEditingController(text: user.email);
                  final password = TextEditingController(text: user.password);

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
                                  image: NetworkImage("https://source.unsplash.com/random/200x200/?face-${user.fullName}"),
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
                                LineAwesomeIcons.camera,
                                size: 20.0,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 60.0),
                      Form(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: fullName,
                              // initialValue: userData.fullName,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                label: Text(TTS_Full_Name),
                                // hintText: TTS_Full_Name),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: email,
                              // initialValue: userData.email,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email_outlined),
                                label: Text(TTS_Email),
                                // hintText: TTS_Email),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: phone,
                              // initialValue: userData.email,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.phone_android_outlined),
                                label: Text(TTS_Phone),
                                // hintText: TTS_Email),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: password,
                              // initialValue: userData.password,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.fingerprint),
                                label: Text(TTS_Password),
                                // hintText: TTS_Password),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  final userData = UserModel(
                                    fullName: fullName.text.trim(),
                                    phone: phone.text.trim(),
                                    email: email.text.trim(),
                                    password: password.text.trim(),
                                  );
                                  await controller.updateRecord(user);
                                  Get.to(ProfileScreen());
                                },
                                child: const Text("Update Profile", style: TextStyle(color: Colors.white)),
                                style: ElevatedButton.styleFrom(backgroundColor: TTS_PrimaryColor, side: BorderSide.none, shape: StadiumBorder()),
                              ),
                            ),
                          ],
                        ),
                      )
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
        ),
      ),
    );
  }
}
