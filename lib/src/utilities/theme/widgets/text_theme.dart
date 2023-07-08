import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TTS_TextTheme {
  TTS_TextTheme._();

  static TextTheme lightTextTheme = TextTheme(
      headline1: GoogleFonts.ubuntu(fontSize: 36, color: Colors.black87, fontWeight: FontWeight.w600),
      headline2: GoogleFonts.ubuntu(fontSize: 32, color: Colors.black87, fontWeight: FontWeight.w600),
      headline3: GoogleFonts.ubuntu(fontSize: 28, color: Colors.black87, fontWeight: FontWeight.w600),
      headline4: GoogleFonts.ubuntu(fontSize: 24, color: Colors.black87, fontWeight: FontWeight.w600),
      headline5: GoogleFonts.ubuntu(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.w600),
      headline6: GoogleFonts.ubuntu(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w600),

      subtitle1: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
      subtitle2: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),

      bodyText1: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400),
      bodyText2: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400),
  );

  static TextTheme darkTextTheme = TextTheme(
      headline1: GoogleFonts.ubuntu(fontSize: 36, color: Colors.white, fontWeight: FontWeight.w600,),
      headline2: GoogleFonts.ubuntu(fontSize: 32, color: Colors.white, fontWeight: FontWeight.w600,),
      headline3: GoogleFonts.ubuntu(fontSize: 28, color: Colors.white, fontWeight: FontWeight.w600,),
      headline4: GoogleFonts.ubuntu(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w600,),
      headline5: GoogleFonts.ubuntu(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600,),
      headline6: GoogleFonts.ubuntu(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600,),

      subtitle1: GoogleFonts.poppins(fontSize: 18, color: Colors.white70, fontWeight: FontWeight.w500,),
      subtitle2: GoogleFonts.poppins(fontSize: 14, color: Colors.white70, fontWeight: FontWeight.w500,),

      bodyText1: GoogleFonts.poppins(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400,),
      bodyText2: GoogleFonts.poppins(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w400,),
  );
}
