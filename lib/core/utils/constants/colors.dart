import 'package:flutter/material.dart';

class PColors {
  PColors._();
  // app basic colors
  // static const Color primary = Color(0xFFde5d1d);
  static const Color primary = Color(0xFF6750a4);
  static const Color primary2 = Color(0xFF50388c);
  static const Color primary3 = Color(0xFF614491);
  static const Color primary4 = Color(0xFF81609e);
  static const Color primary5 = Color(0xFF21005D);
  static const Color sec1 = Color(0xFFFF6607);
  static const Color sec2 = Color(0xFFFF8307);



  static const Color tertiary = Color(0xFFEFB8C8);
  static const Color review = Color(0xFF625B71);

  
  // #625B71
  static const Color secondary = Color(0xffffe24b);
  static const Color accent = Color(0xffb0c7ff);
  static const Color accent2 = Color(0xffF0FDF4);
   static const Color secondary1= Color(0xff1EB352);
  static const Color secondary2= Color(0xff16A34A); 
  static const Color bg1= Color(0xffD0BCFF);
  static const Color bg2= Color(0xffB3261E);
  static const Color bg4= Color(0xff410E0B);

  static const Color bg3= Color(0xff3766C6);






  // gradiant colors
  static const Gradient linearGradient = LinearGradient(
      begin: Alignment(0.0, 0.0),
      end: Alignment(0.707, -0.707),
      colors: [
        Color(0xffff9a9e),
        Color(0xfffad0c4),
        Color(0xfffad0c4),
      ]);

  // Text Colors
  static const Color textPrimary = Color(0xff333333);
  static const Color textSecondary = Color(0xff6c7570);
  static const Color textWhite = Colors.white;

  // Background Colors
  static const Color light = Color(0xfff6f6f6);
  static const Color dark = Color(0xff272727);
  static const Color primaryBackground = Color(0xfff3f5ff);
  static const Color transparent = Colors.transparent;

//   background color containers
  static const Color lightContainer = Color(0xfff6f6f6);
  static Color darkContainer = PColors.white.withOpacity(0.1);

  // Button Colors
  static const Color buttonPrimary = Color(0xff4b68ff);
  static const Color buttonSecondary = Color(0xff6c7570);
  static const Color buttonDisabled = Color(0xffc4c4c4);

//   Border Colors
  static const Color borderPrimary = Color(0xffd9d9d9);
  static const Color borderSecondary = Color(0xffe6e6e6);

  // error and validation colors
  static const Color error = Color(0xffd32f2f);
  static const Color success = Color(0xff388e3c);
  static const Color warning = Color(0xfff57c00);
  static const Color info = Color(0xff1976d2);

//   natural shades

  static const Color black = Color(0xff2b2a33);
  static const Color deepBlack = Color(0xff000000);

  static const Color darkerGrey = Color(0xff4f4f4f);
  static const Color darkGrey = Color(0xff939393);
  static const Color grey = Color(0xffe0e0e0);
  static const Color softGrey = Color(0xfff4f4f4);
  static const Color lightGrey = Color(0xfff9f9f9);
  static const Color white = Color(0xffffffff);
}
