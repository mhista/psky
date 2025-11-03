// ==================== DROPDOWN FIELD ====================

import 'package:ahiaa_web/core/common/custom_dropdown/models/controllers.dart';
import 'package:ahiaa_web/core/common/custom_dropdown/models/custom_dropdown_decoration.dart';
import 'package:ahiaa_web/core/common/custom_dropdown/utils/signatures.dart';
import 'package:flutter/material.dart';

class DropDownField<T> extends StatefulWidget {
  final VoidCallback onTap;
  final SingleSelectController<T?> selectedItemNotifier;
  final String hintText;
  final Color? fillColor;
  final BoxBorder? border;
  final BorderRadius? borderRadius;
  final TextStyle? headerStyle, hintStyle;
  final Widget? prefixIcon, suffixIcon;
  final List<BoxShadow>? shadow;
  final EdgeInsets? headerPadding;
  final int maxLines;
  final HeaderBuilder<T>? headerBuilder;
  final HeaderListBuilder<T>? headerListBuilder;
  final HintBuilder? hintBuilder;
  final DropdownType dropdownType;
  final bool enabled;
  final MultiSelectController<T> selectedItemsNotifier;

  const DropDownField({
    super.key,
    required this.onTap,
    required this.selectedItemNotifier,
    required this.maxLines,
    required this.dropdownType,
    required this.selectedItemsNotifier,
    this.hintText = 'Select value',
    this.fillColor,
    this.border,
    this.borderRadius,
    this.hintStyle,
    this.headerStyle,
    this.headerBuilder,
    this.shadow,
    this.headerListBuilder,
    this.hintBuilder,
    this.prefixIcon,
    this.suffixIcon,
    this.headerPadding,
    this.enabled = true,
  });

  @override
  State<DropDownField<T>> createState() => DropDownFieldState<T>();
}

class DropDownFieldState<T> extends State<DropDownField<T>> {
  T? selectedItem;
  late List<T> selectedItems;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.selectedItemNotifier.value;
    selectedItems = widget.selectedItemsNotifier.value;
  }

  @override
  void didUpdateWidget(covariant DropDownField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    switch (widget.dropdownType) {
      case DropdownType.singleSelect:
        selectedItem = widget.selectedItemNotifier.value;
      case DropdownType.multipleSelect:
        selectedItems = widget.selectedItemsNotifier.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: widget.headerPadding ?? defaultHeaderPadding,
        decoration: BoxDecoration(
          color: widget.fillColor ??
              (widget.enabled
                  ? CustomDropdownDecoration.defaultFillColor
                  : CustomDropdownDecoration.defaultFillColor.withOpacity(.5)),
          border: widget.border,
          borderRadius: widget.borderRadius ?? defaultBorderRadius,
          boxShadow: widget.shadow,
        ),
        child: Row(
          children: [
            if (widget.prefixIcon != null) ...[
              widget.prefixIcon!,
              const SizedBox(width: 12),
            ],
            Expanded(
              child: switch (widget.dropdownType) {
                DropdownType.singleSelect => selectedItem != null
                    ? (widget.headerBuilder != null
                        ? widget.headerBuilder!(context, selectedItem as T, widget.enabled)
                        : Text(
                            selectedItem.toString(),
                            maxLines: widget.maxLines,
                            overflow: TextOverflow.ellipsis,
                            style: widget.headerStyle ??
                                TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: widget.enabled ? null : Colors.black.withOpacity(.5),
                                ),
                          ))
                    : (widget.hintBuilder != null
                        ? widget.hintBuilder!(context, widget.hintText, widget.enabled)
                        : Text(
                            widget.hintText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: widget.hintStyle ?? const TextStyle(fontSize: 16, color: Color(0xFFA7A7A7)),
                          )),
                DropdownType.multipleSelect => selectedItems.isNotEmpty
                    ? (widget.headerListBuilder != null
                        ? widget.headerListBuilder!(context, selectedItems, widget.enabled)
                        : Text(
                            selectedItems.join(', '),
                            maxLines: widget.maxLines,
                            overflow: TextOverflow.ellipsis,
                            style: widget.headerStyle ??
                                TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: widget.enabled ? null : Colors.black.withOpacity(.5),
                                ),
                          ))
                    : (widget.hintBuilder != null
                        ? widget.hintBuilder!(context, widget.hintText, widget.enabled)
                        : Text(
                            widget.hintText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: widget.hintStyle ?? const TextStyle(fontSize: 16, color: Color(0xFFA7A7A7)),
                          )),
              },
            ),
            const SizedBox(width: 12),
            widget.suffixIcon ??
                (widget.enabled
                    ? defaultOverlayIconDown
                    : Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black.withOpacity(.5), size: 20)),
          ],
        ),
      ),
    );
  }
}
