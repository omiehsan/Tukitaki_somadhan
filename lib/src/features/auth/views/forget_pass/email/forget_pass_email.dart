import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../constants/image_list.dart';
import '../../../../../constants/sizes.dart';
import '../../../../../constants/texts.dart';
import '../../../../../widgets/form_header_widget.dart';
import '../otp/forget_pass_opt.dart';

class ForgetPassEmailScreen extends StatelessWidget {
  const ForgetPassEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TTS_MQuery = MediaQuery.of(context);
    final deviceSize = TTS_MQuery.size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: TTS_DefaultSize),
              FormPageHeader(
                logo: TTS_Forget_Pass_Img_1,
                logoHeight: deviceSize.height * 0.3,
                pageTitle: TTS_ForgetPassword,
                pageSubtitle: TTS_Reset_Pass_Email_Subtitle,
              ),
              SizedBox(height: TTS_DefaultSize),
              Form(
                  child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text(TTS_Email),
                      hintText: TTS_Email,
                      prefixIcon: Icon(Icons.mail),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Get.to(() => ForgetPassOTPScreen()),
                      child: Text(TTS_Next, style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
