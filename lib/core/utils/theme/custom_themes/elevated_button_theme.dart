import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: PColors.white,
          backgroundColor: PColors.primary,
          disabledForegroundColor: Colors.grey,
          disabledBackgroundColor: Colors.grey,
          // side: const BorderSide(color: PColors.primary),
          padding: const EdgeInsets.symmetric( horizontal: 24,vertical: 18),
          textStyle: const TextStyle(
              fontSize: 14, color: PColors.white, fontWeight: FontWeight.w500),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))));

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: PColors.white,
          backgroundColor: PColors.primary,
          disabledForegroundColor: Colors.grey,
          disabledBackgroundColor: Colors.grey,
          // side: const BorderSide(color: PColors.primary),
          padding: const EdgeInsets.symmetric( horizontal: 24,vertical: 10,),
          textStyle: const TextStyle(
              fontSize: 14, color: PColors.white, fontWeight: FontWeight.w500),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))));
}
