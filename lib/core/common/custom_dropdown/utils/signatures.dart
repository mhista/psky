
import 'package:flutter/material.dart';

/// Filter mixin
mixin CustomDropdownListFilter {
  bool filter(String query);
}

// ==================== TYPEDEFS ====================

typedef ListItemBuilder<T> = Widget Function(
  BuildContext context,
  T item,
  bool isSelected,
  VoidCallback onItemSelect,
);

typedef HeaderBuilder<T> = Widget Function(
  BuildContext context,
  T selectedItem,
  bool enabled,
);

typedef HeaderListBuilder<T> = Widget Function(
  BuildContext context,
  List<T> selectedItems,
  bool enabled,
);

typedef HintBuilder = Widget Function(
  BuildContext context,
  String hint,
  bool enabled,
);

typedef NoResultFoundBuilder = Widget Function(
  BuildContext context,
  String text,
);

// ==================== ENUMS ====================

enum DropdownType { singleSelect, multipleSelect }
enum SearchType { onListData, onRequestData }

// ==================== CONSTANTS ====================

const defaultErrorColor = Colors.red;
const defaultBorderRadius = BorderRadius.all(Radius.circular(12));
final Border defaultErrorBorder = Border.all(color: defaultErrorColor, width: 1.5);
const defaultErrorStyle = TextStyle(color: defaultErrorColor, fontSize: 14, height: 0.5);
const defaultOverlayIconDown = Icon(Icons.keyboard_arrow_down_rounded, size: 20);
const defaultOverlayIconUp = Icon(Icons.keyboard_arrow_up_rounded, size: 20);
const defaultHeaderPadding = EdgeInsets.all(16.0);
const overlayOuterPadding = EdgeInsetsDirectional.only(bottom: 12, start: 12, end: 12);
const defaultOverlayShadowOffset = Offset(0, 6);
const defaultListItemPadding = EdgeInsets.symmetric(vertical: 12, horizontal: 16);
