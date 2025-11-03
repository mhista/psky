import "package:flutter/material.dart";

import "../../constants/colors.dart";

class TTextTheme {
  TTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
      headlineLarge: const TextStyle().copyWith(
          fontSize: 50, fontWeight: FontWeight.w700, color: PColors.deepBlack),
      headlineMedium: const TextStyle().copyWith(
          fontSize: 24.0, fontWeight: FontWeight.w600, color: PColors.deepBlack),
      headlineSmall: const TextStyle().copyWith(
          fontSize: 18.0, fontWeight: FontWeight.w600, color: PColors.deepBlack),
      titleLarge: const TextStyle().copyWith(
          fontSize: 16.0, fontWeight: FontWeight.w600, color: PColors.deepBlack),
      titleMedium: const TextStyle().copyWith(
          fontSize: 16.0, fontWeight: FontWeight.w500, color: PColors.deepBlack),
      titleSmall: const TextStyle().copyWith(
          fontSize: 16.0, fontWeight: FontWeight.w400, color: PColors.deepBlack),
      bodyLarge: const TextStyle().copyWith(
          fontSize: 14.0, fontWeight: FontWeight.w500, color: PColors.deepBlack),
      bodyMedium: const TextStyle().copyWith(
          fontSize: 14.0, fontWeight: FontWeight.normal, color: PColors.deepBlack),
      bodySmall: const TextStyle().copyWith(
          fontSize: 13.0,
          fontWeight: FontWeight.w500,
          color: PColors.deepBlack.withOpacity(0.5)),
      labelLarge: const TextStyle().copyWith(
          fontSize: 12.0, fontWeight: FontWeight.normal, color: PColors.deepBlack),
      labelMedium: const TextStyle().copyWith(
          fontSize: 12.0,
          fontWeight: FontWeight.normal,
          color: PColors.deepBlack.withOpacity(0.5)));
  static TextTheme darkTextTheme = TextTheme(
      headlineLarge: const TextStyle().copyWith(
          fontSize: 50, fontWeight: FontWeight.bold, color: PColors.light),
      headlineMedium: const TextStyle().copyWith(
          fontSize: 24.0, fontWeight: FontWeight.w600, color: PColors.light),
      headlineSmall: const TextStyle().copyWith(
          fontSize: 18.0, fontWeight: FontWeight.w600, color: PColors.light),
      titleLarge: const TextStyle().copyWith(
          fontSize: 16.0, fontWeight: FontWeight.w600, color: PColors.light),
      titleMedium: const TextStyle().copyWith(
          fontSize: 16.0, fontWeight: FontWeight.w500, color: PColors.light),
      titleSmall: const TextStyle().copyWith(
          fontSize: 16.0, fontWeight: FontWeight.w400, color: PColors.light),
      bodyLarge: const TextStyle().copyWith(
          fontSize: 14.0, fontWeight: FontWeight.w500, color: PColors.light),
      bodyMedium: const TextStyle().copyWith(
          fontSize: 14.0, fontWeight: FontWeight.normal, color: PColors.light),
      bodySmall: const TextStyle().copyWith(
          fontSize: 13.0,
          fontWeight: FontWeight.w500,
          color: PColors.light.withOpacity(0.5)),
      labelLarge: const TextStyle().copyWith(
          fontSize: 12.0, fontWeight: FontWeight.normal, color: PColors.light),
      labelMedium: const TextStyle().copyWith(
          fontSize: 12.0,
          fontWeight: FontWeight.normal,
          color: PColors.light.withOpacity(0.5)));
}
