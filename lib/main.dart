import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasking/src/features/core/views/dash/dashboard_view.dart';
import 'package:tasking/src/repository/auth_repo/auth_repo.dart';

import 'firebase_options.dart';
import 'src/utilities/theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
    (value) => Get.put(AuthRepo()),
  );
  runApp(const TTS_App());
}

class TTS_App extends StatelessWidget {
  const TTS_App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: TTS_Theme.lightTheme,
      darkTheme: TTS_Theme.darkTheme,
      themeMode: ThemeMode.system,
      defaultTransition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      home: const Center(child: CircularProgressIndicator()),
      // home: const SplashScreen(),
      // home: const OnBoardScreen(),
      // home: const WelcomeScreen(),
      // home: const LoginScreen(),
      // home: const SignUpScreen(),
      // home: const DashboardScreen(),
      // home: const TaskingHome(),
    );
  }
}

class TaskingHome extends StatelessWidget {
  const TaskingHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("./Tuki Taki Somadhan"),
          leading: const Icon(Icons.list_alt)),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
      ),
      // floatingActionButton: FloatingActionButton(child: const Icon(Icons.plus_one_rounded)),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Text("Welcome", style: Theme.of(context).textTheme.headline2),
            const SizedBox(height: 20),
            Text("Hello There!!!",
                style: Theme.of(context).textTheme.subtitle2),
            const SizedBox(height: 20),
            Text("Nice To See You Again.",
                style: Theme.of(context).textTheme.bodyText1),
            const SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.number,
              validator: (value) {
                // Is Empty Validation
                if (value == null || value.isEmpty) {
                  return 'Email is Required!';
                }
                // Email Field Validation
                if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                  return "Please Enter a Valid Email";
                }
                // Return Null If Valid
                return null;
              },
              decoration: const InputDecoration(
                label: Text("Email Address"),
                hintText: "Email Address",
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Sign In"),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {},
              child: const Text("Sign Up"),
            ),
            const Padding(
                padding: EdgeInsets.all(20),
                child: Image(image: AssetImage("assets/images/dizzy_face.png")))
          ],
        ),
      ),
    );
  }
}
