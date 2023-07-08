import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/texts.dart';
import '../../../auth/views/login/login_view.dart';

class JobPostPageFooter extends StatelessWidget {
  const JobPostPageFooter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("OR", style: Theme.of(context).textTheme.bodyText1),
        const SizedBox(
          height: TTS_DefaultSize - 10,
        ),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            icon: FaIcon(FontAwesomeIcons.google, size: 15.0),
            onPressed: () {},
            label: Text(TTS_Login_W_Google.toUpperCase()),
          ),
        ),
        const SizedBox(
          height: TTS_DefaultSize - 10,
        ),
        TextButton(
          onPressed: () => Get.to(() => LoginScreen()),
          child: Text.rich(
            TextSpan(
              text: TTS_Account_Exists,
              style: Theme.of(context).textTheme.bodyText1,
              children: [
                TextSpan(
                  text: TTS_Login.toUpperCase(),
                  style: TextStyle(color: TTS_LogoColor),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
