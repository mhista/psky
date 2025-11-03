
// ==================== MAIN WIDGET ====================

import 'package:ahiaa_web/core/common/custom_dropdown/models/controllers.dart';
import 'package:ahiaa_web/core/common/custom_dropdown/models/custom_dropdown_decoration.dart';
import 'package:ahiaa_web/core/common/custom_dropdown/models/disabled_dedcoration.dart';
import 'package:ahiaa_web/core/common/custom_dropdown/utils/signatures.dart';
import 'package:ahiaa_web/core/common/custom_dropdown/widgets/dropdown_field.dart';
import 'package:ahiaa_web/core/common/custom_dropdown/widgets/dropdown_overlay/dropdown_overlay.dart';
import 'package:ahiaa_web/core/common/custom_dropdown/widgets/overlay_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CustomDropdown<T> extends StatefulWidget {
  final List<T>? items;
  final T? initialItem;
  final List<T>? initialItems;
  final ScrollController? itemsScrollController;
  final String? hintText;
  final String? searchHintText;
  final String? Function(T?)? validator;
  final String? Function(List<T>)? listValidator;
  final bool validateOnChange;
  final Function(T?)? onChanged;
  final Function(List<T>)? onListChanged;
  final bool excludeSelected;
  final bool canCloseOutsideBounds;
  final bool hideSelectedFieldWhenExpanded;
  final Future<List<T>> Function(String)? futureRequest;
  final String? noResultFoundText;
  final Duration? futureRequestDelay;
  final int maxlines;
  final EdgeInsets? closedHeaderPadding;
  final EdgeInsets? expandedHeaderPadding;
  final EdgeInsets? itemsListPadding;
  final EdgeInsets? listItemPadding;
  final Widget? searchRequestLoadingIndicator;
  final double? overlayHeight;
  final ListItemBuilder<T>? listItemBuilder;
  final HeaderBuilder<T>? headerBuilder;
  final HintBuilder? hintBuilder;
  final NoResultFoundBuilder? noResultFoundBuilder;
  final HeaderListBuilder<T>? headerListBuilder;
  final CustomDropdownDecoration? decoration;
  final bool enabled;
  final CustomDropdownDisabledDecoration? disabledDecoration;
  final bool closeDropDownOnClearFilterSearch;
  final OverlayPortalController? overlayController;
  final SingleSelectController<T?>? controller;
  final MultiSelectController<T>? multiSelectController;
  final Function(bool)? visibility;
  final SearchType? _searchType;
  final DropdownType _dropdownType;

  CustomDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.controller,
    this.itemsScrollController,
    this.initialItem,
    this.hintText,
    this.decoration,
    this.validator,
    this.validateOnChange = true,
    this.visibility,
    this.overlayController,
    this.listItemBuilder,
    this.headerBuilder,
    this.hintBuilder,
    this.maxlines = 1,
    this.overlayHeight,
    this.closedHeaderPadding,
    this.expandedHeaderPadding,
    this.itemsListPadding,
    this.listItemPadding,
    this.canCloseOutsideBounds = true,
    this.hideSelectedFieldWhenExpanded = false,
    this.excludeSelected = true,
    this.enabled = true,
    this.disabledDecoration,
  })  : _searchType = null,
        _dropdownType = DropdownType.singleSelect,
        futureRequest = null,
        futureRequestDelay = null,
        noResultFoundBuilder = null,
        noResultFoundText = null,
        searchHintText = null,
        initialItems = null,
        onListChanged = null,
        listValidator = null,
        headerListBuilder = null,
        searchRequestLoadingIndicator = null,
        closeDropDownOnClearFilterSearch = false,
        multiSelectController = null;

  CustomDropdown.search({
    super.key,
    required this.items,
    required this.onChanged,
    this.controller,
    this.itemsScrollController,
    this.initialItem,
    this.hintText,
    this.decoration,
    this.visibility,
    this.overlayController,
    this.searchHintText,
    this.noResultFoundText,
    this.listItemBuilder,
    this.headerBuilder,
    this.hintBuilder,
    this.noResultFoundBuilder,
    this.validator,
    this.validateOnChange = true,
    this.maxlines = 1,
    this.overlayHeight,
    this.closedHeaderPadding,
    this.expandedHeaderPadding,
    this.itemsListPadding,
    this.listItemPadding,
    this.excludeSelected = true,
    this.canCloseOutsideBounds = true,
    this.hideSelectedFieldWhenExpanded = false,
    this.enabled = true,
    this.disabledDecoration,
    this.closeDropDownOnClearFilterSearch = false,
  })  : _searchType = SearchType.onListData,
        _dropdownType = DropdownType.singleSelect,
        futureRequest = null,
        futureRequestDelay = null,
        initialItems = null,
        onListChanged = null,
        listValidator = null,
        headerListBuilder = null,
        searchRequestLoadingIndicator = null,
        multiSelectController = null;

  const CustomDropdown.searchRequest({
    super.key,
    required this.futureRequest,
    required this.onChanged,
    this.futureRequestDelay,
    this.initialItem,
    this.items,
    this.controller,
    this.itemsScrollController,
    this.hintText,
    this.decoration,
    this.visibility,
    this.overlayController,
    this.searchHintText,
    this.noResultFoundText,
    this.listItemBuilder,
    this.headerBuilder,
    this.hintBuilder,
    this.noResultFoundBuilder,
    this.validator,
    this.validateOnChange = true,
    this.maxlines = 1,
    this.overlayHeight,
    this.closedHeaderPadding,
    this.expandedHeaderPadding,
    this.itemsListPadding,
    this.listItemPadding,
    this.searchRequestLoadingIndicator,
    this.excludeSelected = true,
    this.canCloseOutsideBounds = true,
    this.hideSelectedFieldWhenExpanded = false,
    this.enabled = true,
    this.disabledDecoration,
    this.closeDropDownOnClearFilterSearch = false,
  })  : _searchType = SearchType.onRequestData,
        _dropdownType = DropdownType.singleSelect,
        initialItems = null,
        onListChanged = null,
        listValidator = null,
        headerListBuilder = null,
        multiSelectController = null;

  CustomDropdown.multiSelect({
    super.key,
    required this.items,
    required this.onListChanged,
    this.multiSelectController,
    this.controller,
    this.initialItems,
    this.overlayController,
    this.itemsScrollController,
    this.listValidator,
    this.visibility,
    this.headerListBuilder,
    this.hintText,
    this.decoration,
    this.validateOnChange = true,
    this.listItemBuilder,
    this.hintBuilder,
    this.canCloseOutsideBounds = true,
    this.hideSelectedFieldWhenExpanded = false,
    this.maxlines = 1,
    this.overlayHeight,
    this.closedHeaderPadding,
    this.expandedHeaderPadding,
    this.itemsListPadding,
    this.listItemPadding,
    this.enabled = true,
    this.disabledDecoration,
  })  : _searchType = null,
        _dropdownType = DropdownType.multipleSelect,
        initialItem = null,
        noResultFoundText = null,
        validator = null,
        headerBuilder = null,
        onChanged = null,
        excludeSelected = false,
        futureRequest = null,
        futureRequestDelay = null,
        noResultFoundBuilder = null,
        searchHintText = null,
        searchRequestLoadingIndicator = null,
        closeDropDownOnClearFilterSearch = false;

  CustomDropdown.multiSelectSearch({
    super.key,
    required this.items,
    required this.onListChanged,
    this.multiSelectController,
    this.initialItems,
    this.controller,
    this.visibility,
    this.itemsScrollController,
    this.overlayController,
    this.listValidator,
    this.listItemBuilder,
    this.hintBuilder,
    this.decoration,
    this.headerListBuilder,
    this.noResultFoundText,
    this.noResultFoundBuilder,
    this.hintText,
    this.searchHintText,
    this.validateOnChange = true,
    this.canCloseOutsideBounds = true,
    this.hideSelectedFieldWhenExpanded = false,
    this.maxlines = 1,
    this.overlayHeight,
    this.closedHeaderPadding,
    this.expandedHeaderPadding,
    this.itemsListPadding,
    this.listItemPadding,
    this.enabled = true,
    this.disabledDecoration,
    this.closeDropDownOnClearFilterSearch = false,
  })  : _searchType = SearchType.onListData,
        _dropdownType = DropdownType.multipleSelect,
        initialItem = null,
        onChanged = null,
        validator = null,
        excludeSelected = false,
        headerBuilder = null,
        futureRequest = null,
        futureRequestDelay = null,
        searchRequestLoadingIndicator = null;

  const CustomDropdown.multiSelectSearchRequest({
    super.key,
    required this.futureRequest,
    required this.onListChanged,
    this.multiSelectController,
    this.futureRequestDelay,
    this.initialItems,
    this.items,
    this.controller,
    this.itemsScrollController,
    this.overlayController,
    this.visibility,
    this.hintText,
    this.decoration,
    this.searchHintText,
    this.noResultFoundText,
    this.headerListBuilder,
    this.listItemBuilder,
    this.hintBuilder,
    this.noResultFoundBuilder,
    this.listValidator,
    this.validateOnChange = true,
    this.maxlines = 1,
    this.overlayHeight,
    this.searchRequestLoadingIndicator,
    this.closedHeaderPadding,
    this.expandedHeaderPadding,
    this.itemsListPadding,
    this.listItemPadding,
    this.canCloseOutsideBounds = true,
    this.hideSelectedFieldWhenExpanded = false,
    this.enabled = true,
    this.disabledDecoration,
    this.closeDropDownOnClearFilterSearch = false,
  })  : _searchType = SearchType.onRequestData,
        _dropdownType = DropdownType.multipleSelect,
        initialItem = null,
        onChanged = null,
        headerBuilder = null,
        excludeSelected = false,
        validator = null;

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  final layerLink = LayerLink();
  late SingleSelectController<T?> selectedItemNotifier;
  late MultiSelectController<T> selectedItemsNotifier;
  FormFieldState<(T?, List<T>)>? _formFieldState;

  @override
  void initState() {
    super.initState();
    selectedItemNotifier = widget.controller ?? SingleSelectController(widget.initialItem);
    selectedItemsNotifier = widget.multiSelectController ?? MultiSelectController(widget.initialItems ?? []);

    selectedItemNotifier.addListener(() {
      widget.onChanged?.call(selectedItemNotifier.value);
      _formFieldState?.didChange((selectedItemNotifier.value, []));
      if (widget.validateOnChange) _formFieldState?.validate();
    });

    selectedItemsNotifier.addListener(() {
      widget.onListChanged?.call(selectedItemsNotifier.value);
      _formFieldState?.didChange((null, selectedItemsNotifier.value));
      if (widget.validateOnChange) _formFieldState?.validate();
    });
  }

  @override
  void didUpdateWidget(covariant CustomDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialItem != oldWidget.initialItem && selectedItemNotifier.value != widget.initialItem) {
      SchedulerBinding.instance.addPostFrameCallback((_) => selectedItemNotifier.value = widget.initialItem);
    }
    if (widget.initialItems != oldWidget.initialItems && selectedItemsNotifier.value != widget.initialItems) {
      SchedulerBinding.instance.addPostFrameCallback((_) => selectedItemsNotifier.value = widget.initialItems ?? []);
    }
    if (widget.controller != oldWidget.controller && widget.controller != null) {
      selectedItemNotifier = widget.controller!;
    }
    if (widget.multiSelectController != oldWidget.multiSelectController && widget.multiSelectController != null) {
      selectedItemsNotifier = widget.multiSelectController!;
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) selectedItemNotifier.dispose();
    if (widget.multiSelectController == null) selectedItemsNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final enabled = widget.enabled;
    final decoration = widget.decoration;
    final disabledDecoration = widget.disabledDecoration;
    final safeHintText = widget.hintText ?? 'Select value';

    return IgnorePointer(
      ignoring: !enabled,
      child: FormField<(T?, List<T>)>(
        initialValue: (selectedItemNotifier.value, selectedItemsNotifier.value),
        validator: (val) {
          if (widget._dropdownType == DropdownType.singleSelect && widget.validator != null) {
            return widget.validator!(val?.$1);
          }
          if (widget._dropdownType == DropdownType.multipleSelect && widget.listValidator != null) {
            return widget.listValidator!(val?.$2 ?? []);
          }
          return null;
        },
        builder: (formFieldState) {
          _formFieldState = formFieldState;
          return InputDecorator(
            decoration: InputDecoration(
              errorStyle: decoration?.errorStyle ?? defaultErrorStyle,
              errorText: formFieldState.errorText,
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            child: OverlayBuilder(
              overlayPortalController: widget.overlayController,
              visibility: widget.visibility,
              overlay: (size, hideCallback) => DropdownOverlay<T>(
                onItemSelect: (T value) {
                  switch (widget._dropdownType) {
                    case DropdownType.singleSelect:
                      selectedItemNotifier.value = value;
                    case DropdownType.multipleSelect:
                      final currentVal = selectedItemsNotifier.value.toList();
                      if (currentVal.contains(value)) {
                        currentVal.remove(value);
                      } else {
                        currentVal.add(value);
                      }
                      selectedItemsNotifier.value = currentVal;
                  }
                },
                noResultFoundText: widget.noResultFoundText ?? 'No result found.',
                noResultFoundBuilder: widget.noResultFoundBuilder,
                items: widget.items ?? [],
                itemsScrollCtrl: widget.itemsScrollController,
                selectedItemNotifier: selectedItemNotifier,
                selectedItemsNotifier: selectedItemsNotifier,
                size: size,
                listItemBuilder: widget.listItemBuilder,
                layerLink: layerLink,
                hideOverlay: hideCallback,
                hintStyle: decoration?.hintStyle,
                headerStyle: decoration?.headerStyle,
                noResultFoundStyle: decoration?.noResultFoundStyle,
                listItemStyle: decoration?.listItemStyle,
                headerBuilder: widget.headerBuilder,
                headerListBuilder: widget.headerListBuilder,
                hintText: safeHintText,
                searchHintText: widget.searchHintText ?? 'Search',
                hintBuilder: widget.hintBuilder,
                decoration: decoration,
                overlayHeight: widget.overlayHeight,
                excludeSelected: widget.excludeSelected,
                canCloseOutsideBounds: widget.canCloseOutsideBounds,
                searchType: widget._searchType,
                futureRequest: widget.futureRequest,
                futureRequestDelay: widget.futureRequestDelay,
                hideSelectedFieldWhenOpen: widget.hideSelectedFieldWhenExpanded,
                maxLines: widget.maxlines,
                headerPadding: widget.expandedHeaderPadding,
                itemsListPadding: widget.itemsListPadding,
                listItemPadding: widget.listItemPadding,
                searchRequestLoadingIndicator: widget.searchRequestLoadingIndicator,
                dropdownType: widget._dropdownType,
              ),
              child: (showCallback) => CompositedTransformTarget(
                link: layerLink,
                child: DropDownField<T>(
                  onTap: showCallback,
                  selectedItemNotifier: selectedItemNotifier,
                  border: formFieldState.hasError
                      ? (decoration?.closedErrorBorder ?? defaultErrorBorder)
                      : enabled
                          ? decoration?.closedBorder
                          : disabledDecoration?.border,
                  borderRadius: formFieldState.hasError
                      ? decoration?.closedErrorBorderRadius
                      : enabled
                          ? decoration?.closedBorderRadius
                          : disabledDecoration?.borderRadius,
                  shadow: enabled ? decoration?.closedShadow : disabledDecoration?.shadow,
                  hintStyle: enabled ? decoration?.hintStyle : disabledDecoration?.hintStyle,
                  headerStyle: enabled ? decoration?.headerStyle : disabledDecoration?.headerStyle,
                  hintText: safeHintText,
                  hintBuilder: widget.hintBuilder,
                  headerBuilder: widget.headerBuilder,
                  headerListBuilder: widget.headerListBuilder,
                  prefixIcon: enabled ? decoration?.prefixIcon : disabledDecoration?.prefixIcon,
                  suffixIcon: enabled ? decoration?.closedSuffixIcon : disabledDecoration?.suffixIcon,
                  fillColor: enabled ? decoration?.closedFillColor : disabledDecoration?.fillColor,
                  maxLines: widget.maxlines,
                  headerPadding: widget.closedHeaderPadding,
                  dropdownType: widget._dropdownType,
                  selectedItemsNotifier: selectedItemsNotifier,
                  enabled: enabled,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}