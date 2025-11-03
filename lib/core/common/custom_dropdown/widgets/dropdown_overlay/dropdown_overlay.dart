
// ==================== DROPDOWN OVERLAY ====================

import 'package:ahiaa_web/core/common/custom_dropdown/models/controllers.dart';
import 'package:ahiaa_web/core/common/custom_dropdown/models/custom_dropdown_decoration.dart';
import 'package:ahiaa_web/core/common/custom_dropdown/utils/signatures.dart';
import 'package:ahiaa_web/core/common/custom_dropdown/widgets/animated_section.dart';
import 'package:ahiaa_web/core/common/custom_dropdown/widgets/dropdown_overlay/widgets/items_list.dart';
import 'package:ahiaa_web/core/common/custom_dropdown/widgets/dropdown_overlay/widgets/serach_field.dart';
import 'package:flutter/material.dart';

class DropdownOverlay<T> extends StatefulWidget {
  final List<T> items;
  final ScrollController? itemsScrollCtrl;
  final SingleSelectController<T?> selectedItemNotifier;
  final MultiSelectController<T> selectedItemsNotifier;
  final Function(T) onItemSelect;
  final Size size;
  final LayerLink layerLink;
  final VoidCallback hideOverlay;
  final String hintText, searchHintText, noResultFoundText;
  final bool excludeSelected, hideSelectedFieldWhenOpen, canCloseOutsideBounds;
  final SearchType? searchType;
  final Future<List<T>> Function(String)? futureRequest;
  final Duration? futureRequestDelay;
  final int maxLines;
  final double? overlayHeight;
  final TextStyle? hintStyle, headerStyle, noResultFoundStyle, listItemStyle;
  final EdgeInsets? headerPadding, listItemPadding, itemsListPadding;
  final Widget? searchRequestLoadingIndicator;
  final ListItemBuilder<T>? listItemBuilder;
  final HeaderBuilder<T>? headerBuilder;
  final HeaderListBuilder<T>? headerListBuilder;
  final HintBuilder? hintBuilder;
  final NoResultFoundBuilder? noResultFoundBuilder;
  final CustomDropdownDecoration? decoration;
  final DropdownType dropdownType;

  const DropdownOverlay({
    Key? key,
    required this.items,
    required this.itemsScrollCtrl,
    required this.size,
    required this.layerLink,
    required this.hideOverlay,
    required this.hintText,
    required this.searchHintText,
    required this.selectedItemNotifier,
    required this.selectedItemsNotifier,
    required this.excludeSelected,
    required this.onItemSelect,
    required this.noResultFoundText,
    required this.canCloseOutsideBounds,
    required this.maxLines,
    required this.overlayHeight,
    required this.dropdownType,
    required this.decoration,
    required this.hintStyle,
    required this.headerStyle,
    required this.listItemStyle,
    required this.noResultFoundStyle,
    required this.hideSelectedFieldWhenOpen,
    required this.searchRequestLoadingIndicator,
    required this.headerPadding,
    required this.itemsListPadding,
    required this.listItemPadding,
    required this.headerBuilder,
    required this.hintBuilder,
    required this.searchType,
    required this.futureRequest,
    required this.futureRequestDelay,
    required this.listItemBuilder,
    required this.headerListBuilder,
    required this.noResultFoundBuilder,
  });

  @override
  _DropdownOverlayState<T> createState() => _DropdownOverlayState<T>();
}

class _DropdownOverlayState<T> extends State<DropdownOverlay<T>> {
  bool displayOverly = true, displayOverlayBottom = true;
  bool isSearchRequestLoading = false;
  bool? mayFoundSearchRequestResult;
  late List<T> items;
  late T? selectedItem;
  late List<T> selectedItems;
  late ScrollController scrollController;
  final key1 = GlobalKey(), key2 = GlobalKey();

  @override
  void initState() {
    super.initState();
    scrollController = widget.itemsScrollCtrl ?? ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final render1 = key1.currentContext?.findRenderObject() as RenderBox;
      final render2 = key2.currentContext?.findRenderObject() as RenderBox;
      final screenHeight = MediaQuery.of(context).size.height;
      double y = render1.localToGlobal(Offset.zero).dy;
      if (screenHeight - y < render2.size.height) {
        displayOverlayBottom = false;
        setState(() {});
      }
    });

    selectedItem = widget.selectedItemNotifier.value;
    selectedItems = widget.selectedItemsNotifier.value;
    widget.selectedItemNotifier.addListener(singleSelectListener);
    widget.selectedItemsNotifier.addListener(multiSelectListener);

    if (widget.excludeSelected && widget.items.length > 1 && selectedItem != null) {
      T value = selectedItem as T;
      items = widget.items.where((item) => item != value).toList();
    } else {
      items = widget.items;
    }
  }

  @override
  void dispose() {
    widget.selectedItemNotifier.removeListener(singleSelectListener);
    widget.selectedItemsNotifier.removeListener(multiSelectListener);
    if (widget.itemsScrollCtrl == null) scrollController.dispose();
    super.dispose();
  }

  void singleSelectListener() {
    if (mounted) selectedItem = widget.selectedItemNotifier.value;
  }

  void multiSelectListener() {
    if (mounted) selectedItems = widget.selectedItemsNotifier.value;
  }

  void onItemSelect(T value) {
    widget.onItemSelect(value);
    if (widget.dropdownType == DropdownType.singleSelect) {
      setState(() => displayOverly = false);
    }
  }

  Widget _buildDefaultListItem(BuildContext context, T result, bool isSelected, VoidCallback onItemSelect) {
    return Row(
      children: [
        Expanded(
          child: Text(
            result.toString(),
            maxLines: widget.maxLines,
            overflow: TextOverflow.ellipsis,
            style: widget.listItemStyle ?? const TextStyle(fontSize: 16),
          ),
        ),
        if (widget.dropdownType == DropdownType.multipleSelect)
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 12.0),
            child: Checkbox(
              onChanged: (_) => onItemSelect(),
              value: isSelected,
              activeColor: widget.decoration?.listItemDecoration?.selectedIconColor,
              side: widget.decoration?.listItemDecoration?.selectedIconBorder,
              shape: widget.decoration?.listItemDecoration?.selectedIconShape,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final decoration = widget.decoration;
    final onSearch = widget.searchType != null;
    final overlayOffset = Offset(-12, displayOverlayBottom ? 0 : 64);
    final listPadding = onSearch ? const EdgeInsets.only(top: 8) : EdgeInsets.zero;

    final list = items.isNotEmpty
        ? ItemsList<T>(
            scrollController: scrollController,
            listItemBuilder: widget.listItemBuilder ?? _buildDefaultListItem,
            excludeSelected: items.length > 1 ? widget.excludeSelected : false,
            selectedItem: selectedItem,
            selectedItems: selectedItems,
            items: items,
            itemsListPadding: widget.itemsListPadding ?? listPadding,
            listItemPadding: widget.listItemPadding ?? defaultListItemPadding,
            onItemSelect: onItemSelect,
            decoration: decoration?.listItemDecoration,
            dropdownType: widget.dropdownType,
          )
        : (mayFoundSearchRequestResult != null && !mayFoundSearchRequestResult!) ||
                widget.searchType == SearchType.onListData
            ? (widget.noResultFoundBuilder != null
                ? widget.noResultFoundBuilder!(context, widget.noResultFoundText)
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        widget.noResultFoundText,
                        style: widget.noResultFoundStyle ?? const TextStyle(fontSize: 16),
                      ),
                    ),
                  ))
            : const SizedBox(height: 12);

    final child = Stack(
      children: [
        Positioned(
          width: widget.size.width + 24,
          child: CompositedTransformFollower(
            link: widget.layerLink,
            followerAnchor: displayOverlayBottom ? Alignment.topLeft : Alignment.bottomLeft,
            showWhenUnlinked: false,
            offset: overlayOffset,
            child: Container(
              key: key1,
              margin: overlayOuterPadding,
              decoration: BoxDecoration(
                color: decoration?.expandedFillColor ?? CustomDropdownDecoration.defaultFillColor,
                border: decoration?.expandedBorder,
                borderRadius: decoration?.expandedBorderRadius ?? defaultBorderRadius,
                boxShadow: decoration?.expandedShadow ??
                    [
                      BoxShadow(
                        blurRadius: 24.0,
                        color: Colors.black.withOpacity(.08),
                        offset: defaultOverlayShadowOffset,
                      ),
                    ],
              ),
              child: Material(
                color: Colors.transparent,
                child: AnimatedSection(
                  animationDismissed: widget.hideOverlay,
                  expand: displayOverly,
                  axisAlignment: displayOverlayBottom ? 1.0 : -1.0,
                  child: SizedBox(
                    key: key2,
                    height: items.length > 4 ? widget.overlayHeight ?? (onSearch ? 270 : 225) : null,
                    child: ClipRRect(
                      borderRadius: decoration?.expandedBorderRadius ?? defaultBorderRadius,
                      child: NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (notification) {
                          notification.disallowIndicator();
                          return true;
                        },
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            scrollbarTheme: decoration?.overlayScrollbarDecoration ??
                                ScrollbarThemeData(
                                  thumbVisibility: MaterialStateProperty.all(true),
                                  thickness: MaterialStateProperty.all(5),
                                  radius: const Radius.circular(4),
                                  thumbColor: MaterialStateProperty.all(Colors.grey[300]),
                                ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (!widget.hideSelectedFieldWhenOpen)
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () => setState(() => displayOverly = false),
                                  child: Padding(
                                    padding: widget.headerPadding ?? defaultHeaderPadding,
                                    child: Row(
                                      children: [
                                        if (widget.decoration?.prefixIcon != null) ...[
                                          widget.decoration!.prefixIcon!,
                                          const SizedBox(width: 12),
                                        ],
                                        Expanded(
                                          child: switch (widget.dropdownType) {
                                            DropdownType.singleSelect => selectedItem != null
                                                ? (widget.headerBuilder != null
                                                    ? widget.headerBuilder!(context, selectedItem as T, true)
                                                    : Text(
                                                        selectedItem.toString(),
                                                        maxLines: widget.maxLines,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: widget.headerStyle ??
                                                            const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                                      ))
                                                : (widget.hintBuilder != null
                                                    ? widget.hintBuilder!(context, widget.hintText, true)
                                                    : Text(
                                                        widget.hintText,
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: widget.hintStyle ??
                                                            const TextStyle(fontSize: 16, color: Color(0xFFA7A7A7)),
                                                      )),
                                            DropdownType.multipleSelect => selectedItems.isNotEmpty
                                                ? (widget.headerListBuilder != null
                                                    ? widget.headerListBuilder!(context, selectedItems, true)
                                                    : Text(
                                                        selectedItems.join(', '),
                                                        maxLines: widget.maxLines,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: widget.headerStyle ??
                                                            const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                                      ))
                                                : (widget.hintBuilder != null
                                                    ? widget.hintBuilder!(context, widget.hintText, true)
                                                    : Text(
                                                        widget.hintText,
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: widget.hintStyle ??
                                                            const TextStyle(fontSize: 16, color: Color(0xFFA7A7A7)),
                                                      )),
                                          },
                                        ),
                                        const SizedBox(width: 12),
                                        decoration?.expandedSuffixIcon ?? defaultOverlayIconUp,
                                      ],
                                    ),
                                  ),
                                ),
                              if (onSearch && widget.searchType == SearchType.onListData)
                                SearchField<T>.forListData(
                                  items: widget.items,
                                  searchHintText: widget.searchHintText,
                                  onSearchedItems: (val) => setState(() => items = val),
                                  decoration: decoration?.searchFieldDecoration,
                                )
                              else if (onSearch && widget.searchType == SearchType.onRequestData)
                                SearchField<T>.forRequestData(
                                  items: widget.items,
                                  searchHintText: widget.searchHintText,
                                  onFutureRequestLoading: (val) => setState(() => isSearchRequestLoading = val),
                                  futureRequest: widget.futureRequest,
                                  futureRequestDelay: widget.futureRequestDelay,
                                  onSearchedItems: (val) => setState(() => items = val),
                                  mayFoundResult: (val) => mayFoundSearchRequestResult = val,
                                  decoration: decoration?.searchFieldDecoration,
                                ),
                              if (isSearchRequestLoading)
                                widget.searchRequestLoadingIndicator ??
                                    const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 20.0),
                                      child: Center(
                                        child: SizedBox(
                                          width: 25,
                                          height: 25,
                                          child: CircularProgressIndicator(strokeWidth: 3),
                                        ),
                                      ),
                                    )
                              else
                                items.length > 4 ? Expanded(child: list) : list
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );

    if (widget.canCloseOutsideBounds) {
      return Stack(
        children: [
          GestureDetector(
            onTap: () => setState(() => displayOverly = false),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
            ),
          ),
          child,
        ],
      );
    }
    return child;
  }
}