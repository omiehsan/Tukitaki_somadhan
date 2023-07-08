import 'package:flutter/material.dart';

import '../../../../constants/image_list.dart';
import '../../../../constants/texts.dart';
import '../../../../widgets/form_header_widget.dart';
import 'login_footer_widget.dart';
import 'login_form_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TTS_MQuery = MediaQuery.of(context);
    final deviceSize = TTS_MQuery.size;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /* -- Start Section 1 -- */
            FormPageHeader(
              logo: TTS_Logo_Circle,
              logoHeight: 120.0,
              pageTitle: TTS_LPage_Title,
              pageSubtitle: TTS_LPage_Subtitle,
            ),
            /* -- Start Section 2 -- */
            LoginFormSection(),

            /* -- Start Section 3 -- */
            LoginPageFooter(),
          ],
        ),
      ),
    );
  }
}
