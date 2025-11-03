import 'dart:async';
import 'package:ahiaa_web/core/common/custom_dropdown/models/list_item_decoration.dart';
import 'package:ahiaa_web/core/common/custom_dropdown/models/search_field_dedcoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// ==================== MODELS ====================

/// Decoration for CustomDropdown
class CustomDropdownDecoration {
  final Color? closedFillColor;
  final Color? expandedFillColor;
  final List<BoxShadow>? closedShadow;
  final List<BoxShadow>? expandedShadow;
  final Widget? closedSuffixIcon;
  final Widget? expandedSuffixIcon;
  final Widget? prefixIcon;
  
  // ENHANCED: Better border control
  final BoxBorder? closedBorder;
  final BorderRadius? closedBorderRadius;
  final BoxBorder? closedErrorBorder;
  final BorderRadius? closedErrorBorderRadius;
  final BoxBorder? expandedBorder;
  final BorderRadius? expandedBorderRadius;
  
  final TextStyle? hintStyle;
  final TextStyle? headerStyle;
  final TextStyle? noResultFoundStyle;
  final TextStyle? errorStyle;
  final TextStyle? listItemStyle;
  final ScrollbarThemeData? overlayScrollbarDecoration;
  final SearchFieldDecoration? searchFieldDecoration;
  final ListItemDecoration? listItemDecoration;

  const CustomDropdownDecoration({
    this.closedFillColor,
    this.expandedFillColor,
    this.closedShadow,
    this.expandedShadow,
    this.closedSuffixIcon,
    this.expandedSuffixIcon,
    this.prefixIcon,
    this.closedBorder,
    this.closedBorderRadius,
    this.closedErrorBorder,
    this.closedErrorBorderRadius,
    this.expandedBorder,
    this.expandedBorderRadius,
    this.hintStyle,
    this.headerStyle,
    this.noResultFoundStyle,
    this.errorStyle,
    this.listItemStyle,
    this.overlayScrollbarDecoration,
    this.searchFieldDecoration,
    this.listItemDecoration,
  });

  static const Color defaultFillColor = Colors.white;
}
