import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';

/* -- Light & Dark Outline Button Themes -- */

class TTS_ElevateddButtonTheme {
  TTS_ElevateddButtonTheme._();

  /* -- Light Theme -- */
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
      ),
      foregroundColor: TTS_WhiteColor,
      backgroundColor: TTS_SecondaryColor,
      side: BorderSide(color: TTS_SecondaryColor),

      padding: const EdgeInsets.symmetric(vertical: TTS_DefaultButtonSize),

    ),
  );

  /* -- Dark Theme -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
      ),
      foregroundColor: TTS_SecondaryColor,
      backgroundColor: TTS_WhiteColor,
      side: BorderSide(color: TTS_WhiteColor),
      padding: const EdgeInsets.symmetric(vertical: TTS_DefaultButtonSize),
    ),
  );

}