import 'package:ahiaa_web/core/common/custom_dropdown/custom_dropdown.dart';
import 'package:ahiaa_web/core/common/custom_dropdown/models/custom_dropdown_decoration.dart';
import 'package:ahiaa_web/core/common/custom_dropdown/models/search_field_dedcoration.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class KCustomDropdownWithSearch extends StatelessWidget {
  const KCustomDropdownWithSearch(
      {super.key, required this.items, this.onChanged});
  final List<String> items;
  final Function(String? value)? onChanged;
  @override
  Widget build(BuildContext context) {
    return

        /// EXAMPLE 2: Search Dropdown
        /// ```dart
        CustomDropdown<String>.search(
      items: items,
      hintText: items[0],
      closedHeaderPadding:
          const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      searchHintText: 'Type to search...',
      onChanged: onChanged,
      decoration: CustomDropdownDecoration(
        closedBorder: null, // Remove border
        expandedBorder: null, // Remove border
        closedShadow: [], // Remove shadow
        expandedShadow: [], // Remove shadow
        closedBorderRadius: BorderRadius.circular(28),
        expandedBorderRadius: BorderRadius.circular(28),
        closedFillColor: Colors.white,
        expandedFillColor: PColors.light,
        searchFieldDecoration: SearchFieldDecoration(
          fillColor: PColors.light,
              hintStyle:
            Theme.of(context).textTheme.bodySmall!.apply(fontSizeDelta: -1),
        textStyle:
            Theme.of(context).textTheme.bodySmall!.apply(fontSizeDelta: -1),
            // suffixIcon:(v)=>  const Icon(Iconsax.search_normal)
            // border: Border.all()
        ),
        // closedBorderRadius: BorderRadius.circular(16),
        hintStyle:
            Theme.of(context).textTheme.bodySmall!.apply(fontSizeDelta: -1),
        listItemStyle:
            Theme.of(context).textTheme.bodySmall!.apply(fontSizeDelta: -1),
        headerStyle:
            Theme.of(context).textTheme.bodySmall!.apply(fontSizeDelta: -1),
      ),
      initialItem: items[0],
    );

    /// `;
  }
}
