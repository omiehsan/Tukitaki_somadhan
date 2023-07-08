import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/sizes.dart';
import '../../../../../constants/texts.dart';

class ForgetPassOTPScreen extends StatelessWidget {
  const ForgetPassOTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TTS_MQuery = MediaQuery.of(context);
    final deviceSize = TTS_MQuery.size;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(TTS_OTP_Title,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w900,
                  fontSize: 80,
                  color: TTS_LogoColor,
                )),
            Text(TTS_OTP_Subtitle.toUpperCase(), style: Theme.of(context).textTheme.headline4),
            const SizedBox(height: 40.0),
            Text(
              "$TTS_OTP_Message mahid@tukitakisomadhan.com",
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: TTS_DefaultSize),
            OtpTextField(
              numberOfFields: 6,
              borderWidth: 4.0,
              margin: EdgeInsets.all(7.0),
              enabledBorderColor: Colors.deepPurple,
              focusedBorderColor: TTS_LogoColor,
              fieldWidth: 50,
              fillColor: Colors.black.withOpacity(0.1),
              filled: true,
              onSubmit: (code) {
                print(code);
              },
            ),
            const SizedBox(height: TTS_DefaultSize),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(TTS_Verify, style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
