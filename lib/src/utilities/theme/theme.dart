import 'package:flutter/material.dart';
import 'package:tasking/src/utilities/theme/widgets/elevated_button_theme.dart';
import 'package:tasking/src/utilities/theme/widgets/form_input_fields_theme.dart';
import 'package:tasking/src/utilities/theme/widgets/outline_button_theme.dart';
import 'package:tasking/src/utilities/theme/widgets/text_theme.dart';

class TTS_Theme {
  TTS_Theme._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: TTS_TextTheme.lightTextTheme,
    outlinedButtonTheme: TTS_OutlinedButtonTheme.lightOutlinedButtonTheme,
    elevatedButtonTheme: TTS_ElevateddButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: TTS_InputDecorationTheme.lightInputDecorationTheme,

    // primarySwatch: Colors.deepOrange,
    // primarySwatch: MaterialColor(0xFFFFE200, <int, Color>{
    //   50   : Color(0x1AFFE200),
    //   100  : Color(0x33FFE200),
    //   200  : Color(0x4DFFE200),
    //   300  : Color(0x66FFE200),
    //   400  : Color(0x80FFE200),
    //   500  : Color(0x80FFE200),
    //   600  : Color(0xB3FFE200),
    //   700  : Color(0xCCFFE200),
    //   800  : Color(0xE6FFE200),
    //   900  : Color(0xFFFFE200),
    // }),
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: TTS_TextTheme.darkTextTheme,
    outlinedButtonTheme: TTS_OutlinedButtonTheme.darkOutlinedButtonTheme,
    elevatedButtonTheme: TTS_ElevateddButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: TTS_InputDecorationTheme.darkInputDecorationTheme,
    // TextFormField: TTS_InputDecorationTheme.darkTextFormFieldTheme,
    // primarySwatch: Colors.deepOrange,
  );
} // ThemeData
