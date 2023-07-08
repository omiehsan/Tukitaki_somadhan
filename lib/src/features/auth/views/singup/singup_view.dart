import 'package:flutter/material.dart';

import '../../../../constants/image_list.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/texts.dart';
import '../../../../widgets/form_header_widget.dart';
import 'signup_form_widget.dart';
import 'signup_page_footer.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TTS_MQuery = MediaQuery.of(context);
    final deviceSize = TTS_MQuery.size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(TTS_DefaultSize),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* -- Start Section 1 -- */
              FormPageHeader(
                logo: TTS_Logo_Circle,
                logoHeight: 120.0,
                pageTitle: TTS_RPage_Title,
                pageSubtitle: TTS_RPage_Subtitle,
              ),

              /* -- Start Section 2 -- */
              SignUpFormSection(),

              /* -- Start Section 3 -- */
              SignUpPageFooter()
            ],
          ),
        ),
      ),
    );
  }
}
