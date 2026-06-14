import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'evently_assets.dart';
class EventlyStyles {
 static TextStyle bold20black=GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: EventlyColors.main_text
  );
 static TextStyle bold20white=GoogleFonts.poppins(
     fontSize: 20,
     fontWeight: FontWeight.bold,
     color: EventlyColors.white_color
 );
 static TextStyle regular14grey=GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: EventlyColors.sec_text
  );
 static TextStyle regular16grey=GoogleFonts.poppins(
     fontSize: 16,
     fontWeight: FontWeight.w400,
     color: EventlyColors.sec_text
 );
 static TextStyle regular16dark_grey=GoogleFonts.poppins(
     fontSize: 16,
     fontWeight: FontWeight.w400,
     color: EventlyColors.sec_text
 );
 static TextStyle regular14dark_grey=GoogleFonts.poppins(
     fontSize: 14,
     fontWeight: FontWeight.w400,
     color: EventlyColors.dark_sec_text
 );
 static TextStyle medium16white=GoogleFonts.poppins(
     fontSize: 16,
     fontWeight: FontWeight.w500,
     color: EventlyColors.white_color
 );
 static TextStyle medium16black=GoogleFonts.poppins(
     fontSize: 16,
     fontWeight: FontWeight.w500,
     color: EventlyColors.main_text
 );
 static TextStyle bold16main_blue=GoogleFonts.poppins(
     fontSize: 16,
     fontWeight: FontWeight.bold,
     color: EventlyColors.main_blue
 );
 static TextStyle bold16main_dark_blue=GoogleFonts.poppins(
     fontSize: 16,
     fontWeight: FontWeight.bold,
     color: EventlyColors.main_dark_blue
 );
 static TextStyle medium18black=GoogleFonts.poppins(
     fontSize: 18,
     fontWeight: FontWeight.w500,
     color: EventlyColors.main_text
 );
 static TextStyle medium16main_dark_blue=GoogleFonts.poppins(
     fontSize: 16,
     fontWeight: FontWeight.w500,
     color: EventlyColors.main_dark_blue
 );
 static TextStyle medium18white=GoogleFonts.poppins(
     fontSize: 18,
     fontWeight: FontWeight.w500,
     color: EventlyColors.white_color
 );
 static TextStyle medium18main=GoogleFonts.poppins(
     fontSize: 18,
     fontWeight: FontWeight.w500,
     color: EventlyColors.main_blue
 );
 static TextStyle regular14main_blue=GoogleFonts.poppins(
   decoration: TextDecoration.underline,
     decorationColor: EventlyColors.main_blue,
     decorationThickness: 2,
     decorationStyle: TextDecorationStyle.solid,
     fontSize: 14,
     fontWeight: FontWeight.w400,
     color: EventlyColors.main_blue
 );
 static TextStyle regular14main_dark_blue=GoogleFonts.poppins(
     decoration: TextDecoration.underline,
     decorationColor: EventlyColors.main_dark_blue,
     decorationThickness: 2,
     decorationStyle: TextDecorationStyle.solid,
     fontSize: 14,
     fontWeight: FontWeight.w400,
     color: EventlyColors.main_dark_blue
 );
 static TextStyle bold24main=GoogleFonts.poppins(
     fontSize: 24,
     fontWeight: FontWeight.bold,
     color: EventlyColors.main_blue
 );
 static TextStyle bold24white=GoogleFonts.poppins(
     fontSize: 24,
     fontWeight: FontWeight.bold,
     color: EventlyColors.white_color
 );
 static TextStyle medium16disable=GoogleFonts.poppins(
     fontSize: 16,
     fontWeight: FontWeight.w500,
     color: EventlyColors.disable
 );
 static TextStyle medium16dark_sec=GoogleFonts.poppins(
     fontSize: 16,
     fontWeight: FontWeight.w500,
     color: EventlyColors.dark_sec_text
 );
}