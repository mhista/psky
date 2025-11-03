
// ==================== SEARCH FIELD ====================

import 'dart:async';

import 'package:ahiaa_web/core/common/custom_dropdown/models/search_field_dedcoration.dart';
import 'package:ahiaa_web/core/common/custom_dropdown/utils/signatures.dart';
import 'package:flutter/material.dart';

class SearchField<T> extends StatefulWidget {
  final List<T> items;
  final ValueChanged<List<T>> onSearchedItems;
  final String searchHintText;
  final SearchType? searchType;
  final Future<List<T>> Function(String)? futureRequest;
  final Duration? futureRequestDelay;
  final ValueChanged<bool>? onFutureRequestLoading, mayFoundResult;
  final SearchFieldDecoration? decoration;

  const SearchField.forListData({
    super.key,
    required this.items,
    required this.onSearchedItems,
    required this.searchHintText,
    required this.decoration,
  })  : searchType = SearchType.onListData,
        futureRequest = null,
        futureRequestDelay = null,
        onFutureRequestLoading = null,
        mayFoundResult = null;

  const SearchField.forRequestData({
    super.key,
    required this.items,
    required this.onSearchedItems,
    required this.searchHintText,
    required this.futureRequest,
    required this.futureRequestDelay,
    required this.onFutureRequestLoading,
    required this.mayFoundResult,
    required this.decoration,
  }) : searchType = SearchType.onRequestData;

  @override
  State<SearchField<T>> createState() => SearchFieldState<T>();
}

class SearchFieldState<T> extends State<SearchField<T>> {
  final searchCtrl = TextEditingController();
  bool isFieldEmpty = false;
  FocusNode focusNode = FocusNode();
  Timer? _delayTimer;

  @override
  void initState() {
    super.initState();
    if (widget.searchType == SearchType.onRequestData && widget.items.isEmpty) {
      focusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    _delayTimer?.cancel();
    super.dispose();
  }

  void onSearch(String query) {
    final result = widget.items.where((item) {
      if (item is CustomDropdownListFilter) {
        return item.filter(query);
      } else {
        return item.toString().toLowerCase().contains(query.toLowerCase());
      }
    }).toList();
    widget.onSearchedItems(result);
  }

  void onClear() {
    if (searchCtrl.text.isNotEmpty) {
      searchCtrl.clear();
      widget.onSearchedItems(widget.items);
    }
  }

  void searchRequest(String val) async {
    List<T> result = [];
    try {
      result = await widget.futureRequest!(val);
      widget.onFutureRequestLoading!(false);
    } catch (_) {
      widget.onFutureRequestLoading!(false);
    }
    widget.onSearchedItems(isFieldEmpty ? widget.items : result);
    widget.mayFoundResult!(result.isNotEmpty);
    if (isFieldEmpty) isFieldEmpty = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        focusNode: focusNode,
        style: widget.decoration?.textStyle,
        onChanged: (val) async {
          if (val.isEmpty) {
            isFieldEmpty = true;
          } else if (isFieldEmpty) {
            isFieldEmpty = false;
          }

          if (widget.searchType != null && widget.searchType == SearchType.onRequestData && val.isNotEmpty) {
            widget.onFutureRequestLoading!(true);
            if (widget.futureRequestDelay != null) {
              _delayTimer?.cancel();
              _delayTimer = Timer(widget.futureRequestDelay ?? Duration.zero, () => searchRequest(val));
            } else {
              searchRequest(val);
            }
          } else if (widget.searchType == SearchType.onListData) {
            onSearch(val);
          } else {
            widget.onSearchedItems(widget.items);
          }
        },
        controller: searchCtrl,
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.decoration?.fillColor ?? SearchFieldDecoration.defaultFillColor,
          constraints: widget.decoration?.constraints ?? const BoxConstraints.tightFor(height: 40),
          contentPadding: widget.decoration?.contentPadding ?? const EdgeInsets.all(8),
          hintText: widget.searchHintText,
          hintStyle: widget.decoration?.hintStyle,
          prefixIcon: widget.decoration?.prefixIcon ?? const Icon(Icons.search, size: 22),
          suffixIcon: widget.decoration?.suffixIcon?.call(onClear) ??
              GestureDetector(onTap: onClear, child: const Icon(Icons.close, size: 20)),
          border: widget.decoration?.border ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.withOpacity(.25), width: 1),
              ),
          enabledBorder: widget.decoration?.border ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.withOpacity(.25), width: 1),
              ),
          focusedBorder: widget.decoration?.focusedBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.withOpacity(.25), width: 1),
              ),
        ),
      ),
    );
  }
}