import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../constants/texts.dart';
import '../email/forget_pass_email.dart';
import 'forget_pass_btn_widget.dart';

class ForgetPassBottomSheetModal {
  static Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(TTS_Forget_Pass_Title, style: Theme.of(context).textTheme.headline2),
            Text(TTS_Forget_Pass_Subtitle, style: Theme.of(context).textTheme.subtitle1),
            const SizedBox(height: 30.0),
            Forget_Pass_BTN_Widget(
              onTap: () {
                Navigator.pop(context);
                Get.to(() => ForgetPassEmailScreen());
              },
              btnIcon: Icons.email,
              btnTitle: TTS_Email,
              btnSubtitle: TTS_Reset_Pass_Email,
            ),
            const SizedBox(height: 20.0),
            Forget_Pass_BTN_Widget(
              onTap: (){},
              btnIcon: Icons.perm_phone_msg_rounded,
              btnTitle: TTS_Phone,
              btnSubtitle: TTS_Reset_Pass_Phone,
            ),
          ],
        ),
      ),
    );
  }
}
