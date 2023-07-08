import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

/* -- Light & Dark Outline Button Themes -- */

class TTS_InputDecorationTheme {
  TTS_InputDecorationTheme._();

  /* -- Light Theme -- */
  static final lightTextFormFieldTheme = TextFormField(
    cursorColor: TTS_LogoColor,
  );

  static final lightInputDecorationTheme = InputDecorationTheme(
    // labelStyle: TextStyle(color: TTS_SecondaryColor),
    floatingLabelStyle: TextStyle(color: TTS_LogoColor),
    prefixIconColor: TTS_LightBlack,
    focusColor: TTS_BlackColor,
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2.0, color: TTS_DangerColor),
    ),
    border: OutlineInputBorder(
        // borderRadius: BorderRadius.circular(5.0),
        ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 2.0,
        color: TTS_SecondaryColor,
      ),
    ),
  );

  /* -- Dark Theme -- */
  static final darkTextFormFieldTheme = TextFormField(
    cursorColor: TTS_WhiteColor,
  );
  static final darkInputDecorationTheme = InputDecorationTheme(
    // labelStyle: TextStyle(color: TTS_SecondaryColor),
    floatingLabelStyle: TextStyle(color: TTS_WhiteColor),
    prefixIconColor: TTS_LightWhite,
    focusColor: TTS_WhiteColor,
    border: OutlineInputBorder(
        // borderRadius: BorderRadius.circular(5.0),
        ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2.0, color: TTS_DangerColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 2.0,
        color: TTS_LogoColor,
      ),
    ),
  );
}
