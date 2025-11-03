
import 'package:flutter/material.dart';

/// Disabled decoration
class CustomDropdownDisabledDecoration {
  final Color? fillColor;
  final List<BoxShadow>? shadow;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final BoxBorder? border;
  final BorderRadius? borderRadius;
  final TextStyle? hintStyle;
  final TextStyle? headerStyle;

  const CustomDropdownDisabledDecoration({
    this.fillColor,
    this.shadow,
    this.suffixIcon,
    this.prefixIcon,
    this.border,
    this.borderRadius,
    this.headerStyle,
    this.hintStyle,
  });
}
