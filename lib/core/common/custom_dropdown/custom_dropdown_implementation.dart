import 'package:ahiaa_web/core/common/custom_dropdown/custom_dropdown.dart';
import 'package:ahiaa_web/core/common/custom_dropdown/models/custom_dropdown_decoration.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class KCustomDropdown extends StatelessWidget {
  const KCustomDropdown({super.key, required this.items, this.onChanged});

  final List<String> items;
  final Function(String? value)? onChanged;
  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunctions.isDarkMode(context);

    return CustomDropdown(
      // expandedHeaderPadding: EdgeInsets.all(0),

      closedHeaderPadding:
          const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      // expandedHeaderPadding:
      //     const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: CustomDropdownDecoration(
        closedBorder: null, // Remove border
        expandedBorder: null, // Remove border
        closedShadow: [], // Remove shadow
        expandedShadow: [], // Remove shadow
        closedBorderRadius: BorderRadius.circular(28),
        expandedBorderRadius: BorderRadius.circular(28),
        closedFillColor: PColors.white,
        expandedFillColor: PColors.light,
        // closedBorderRadius: BorderRadius.circular(16),
        hintStyle:
            Theme.of(context).textTheme.bodySmall!.apply(fontSizeDelta: -1),
        listItemStyle:
            Theme.of(context).textTheme.bodySmall!.apply(fontSizeDelta: -1),
        headerStyle:
            Theme.of(context).textTheme.bodySmall!.apply(fontSizeDelta: -1),
      ),
      items: items,
      hintText: items[0],
      initialItem: items[0],
      onChanged: onChanged,
    );
  }
}
