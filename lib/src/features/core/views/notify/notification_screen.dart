import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:tasking/src/constants/colors.dart';
import 'package:tasking/src/features/core/views/dash/dashboard_view.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

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
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          "Notifications",
          style: Theme.of(context).textTheme.headline4,
        ),
        actions: [IconButton(color: TTS_DarkColor, onPressed: () {}, icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))],
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(Material.defaultSplashRadius),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.notifications_active, size: 60, color: TTS_LogoColor),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 50,
                      width: 50,
                      child: Center(
                        child: Lottie.network('https://assets1.lottiefiles.com/packages/lf20_p8bfn5to.json', repeat: true, animate: true),
                      )),
                  const SizedBox(width: 15),
                  Text("Under Construction", style: Theme.of(context).textTheme.headline4),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
