
import 'package:flutter/material.dart';

/// List item decoration
class ListItemDecoration {
  final Color? splashColor;
  final Color? highlightColor;
  final Color? selectedColor;
  final Color? selectedIconColor;
  final BorderSide? selectedIconBorder;
  final OutlinedBorder? selectedIconShape;

  const ListItemDecoration({
    this.splashColor,
    this.highlightColor,
    this.selectedColor,
    this.selectedIconColor,
    this.selectedIconBorder,
    this.selectedIconShape,
  });

  static const defaultSplashColor = Colors.transparent;
  static const defaultHighlightColor = Color(0xFFEEEEEE);
  static const defaultSelectedColor = Color(0xFFF5F5F5);
}
