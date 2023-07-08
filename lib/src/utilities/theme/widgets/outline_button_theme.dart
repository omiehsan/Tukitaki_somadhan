import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';

/* -- Light & Dark Outline Button Themes -- */

class TTS_OutlinedButtonTheme {
  TTS_OutlinedButtonTheme._();

  /* -- Light Theme -- */
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
      ),
      foregroundColor: TTS_SecondaryColor,
      side: BorderSide(color: TTS_SecondaryColor),
      padding: EdgeInsets.symmetric(vertical: TTS_DefaultButtonSize),

    ),
  );

  /* -- Dark Theme -- */
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
      ),
      foregroundColor: TTS_WhiteColor,
      side: BorderSide(color: TTS_WhiteColor),
      padding: EdgeInsets.symmetric(vertical: TTS_DefaultButtonSize),
    ),
  );

}