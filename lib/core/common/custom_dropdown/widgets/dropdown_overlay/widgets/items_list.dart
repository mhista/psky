
// ==================== ITEMS LIST ====================

import 'package:ahiaa_web/core/common/custom_dropdown/models/list_item_decoration.dart';
import 'package:ahiaa_web/core/common/custom_dropdown/utils/signatures.dart';
import 'package:flutter/material.dart';

class ItemsList<T> extends StatelessWidget {
  final ScrollController scrollController;
  final T? selectedItem;
  final List<T> items, selectedItems;
  final Function(T) onItemSelect;
  final bool excludeSelected;
  final EdgeInsets itemsListPadding, listItemPadding;
  final ListItemBuilder<T> listItemBuilder;
  final ListItemDecoration? decoration;
  final DropdownType dropdownType;

  const ItemsList({
    super.key,
    required this.scrollController,
    required this.selectedItem,
    required this.items,
    required this.onItemSelect,
    required this.excludeSelected,
    required this.itemsListPadding,
    required this.listItemPadding,
    required this.listItemBuilder,
    required this.selectedItems,
    required this.decoration,
    required this.dropdownType,
  });

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: scrollController,
      child: ListView.builder(
        controller: scrollController,
        shrinkWrap: true,
        padding: itemsListPadding,
        itemCount: items.length,
        itemBuilder: (_, index) {
          final selected = switch (dropdownType) {
            DropdownType.singleSelect => !excludeSelected && selectedItem == items[index],
            DropdownType.multipleSelect => selectedItems.contains(items[index])
          };
          return Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: decoration?.splashColor ?? ListItemDecoration.defaultSplashColor,
              highlightColor: decoration?.highlightColor ?? ListItemDecoration.defaultHighlightColor,
              onTap: () => onItemSelect(items[index]),
              child: Ink(
                color: selected
                    ? (decoration?.selectedColor ?? ListItemDecoration.defaultSelectedColor)
                    : Colors.transparent,
                padding: listItemPadding,
                child: listItemBuilder(context, items[index], selected, () => onItemSelect(items[index])),
              ),
            ),
          );
        },
      ),
    );
  }
}