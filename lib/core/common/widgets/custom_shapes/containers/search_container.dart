import 'package:ahiaa_web/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_functions.dart';

// class PSearchContainer extends StatelessWidget {
//   const PSearchContainer(
//       {super.key,
//       required this.text,
//       this.icon = Iconsax.search_normal,
//       this.showBackground = true,
//       this.showBorder = true,
//       this.onTap,
//       this.padding =
//           const EdgeInsets.symmetric(horizontal: PSizes.defaultSpace)});
//   final String text;
//   final IconData? icon;
//   final bool showBackground, showBorder;
//   final void Function()? onTap;
//   final EdgeInsetsGeometry padding;

//   @override
//   Widget build(BuildContext context) {
//     final isDark = PHelperFunctions.isDarkMode(context);
//     return GestureDetector(
//       onTap: onTap,
//       child: Padding(
//         padding: padding,
//         child: Container(
//           width: PDeviceUtils.getScreenWidth(context),
//           padding: const EdgeInsets.all(PSizes.md),
//           decoration: BoxDecoration(
//             color: showBackground
//                 ? isDark
//                     ? PColors.dark
//                     : PColors.white
//                 : Colors.transparent,
//             borderRadius: BorderRadius.circular(PSizes.cardRadiusLg),
//             border: showBorder ? Border.all(color: PColors.grey) : null,
//           ),
//           child: Row(
//             children: [
//               Icon(
//                 icon,
//                 color: PColors.darkGrey,
//               ),
//               const SizedBox(
//                 width: (PSizes.spaceBtwItems),
//               ),
//               Text(
//                 text,
//                 style: Theme.of(context).textTheme.bodySmall,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class PSearchContainer extends StatelessWidget implements PreferredSizeWidget {
  const PSearchContainer(
      {super.key,
      this.color,
      required this.text,
      this.useSuffix = false,
      this.useBorder = true,
      this.hasColor = false,
      this.inverse = false,
      this.isSmall = false,
      this.radius = 28,
      this.textFieldWidget,
      this.textController,
      this.usePrefixSuffix = false,
      this.onChanged,
      this.prefixWidget,
      this.focusNode,
      this.onTap});

  // to add the background color to tabs, wrap with material widget.
  final Color? color;
  final String text;
  final bool useSuffix, useBorder, hasColor, usePrefixSuffix, inverse, isSmall;
  final double? radius;
  final Widget? textFieldWidget, prefixWidget;
  final TextEditingController? textController;
  final Function(String)? onChanged;
  final Function()? onTap;

  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunctions.isDarkMode(context);
    return TextField(
      onTap: onTap,
      focusNode: focusNode,
      onChanged: onChanged,
      controller: textController,
      style: TextStyle(color: inverse ? Colors.white : null),
      decoration: InputDecoration(
          fillColor: hasColor
              ? color
              : isDark
                  ? PColors.black
                  : PColors.white,
          filled: true,
          contentPadding: useSuffix
              ? const EdgeInsets.symmetric(vertical: 15, horizontal: 10)
              : EdgeInsets.symmetric(
                  vertical: isSmall ? 20 : 15, horizontal: 8),
          hintText: text,
          hintStyle: Theme.of(context)
              .textTheme
              .labelMedium!
              .apply(color: inverse ? Colors.white : null),
          suffixIcon: useSuffix || usePrefixSuffix
              ? Padding(
                  padding: isSmall
                      ? const EdgeInsets.only(bottom: 18.0)
                      : const EdgeInsets.all(0),
                  child: textFieldWidget ?? SearchIcon(isDark: isDark),
                )
              : null,
          prefixIcon: !useSuffix ? prefixWidget : SearchIcon(isDark: isDark),
          border: inputBorder(isDark, useBorder, radius),
          focusedBorder: inputBorder(isDark, useBorder, radius),
          enabledBorder: inputBorder(isDark, useBorder, radius)),
    );
  }

  OutlineInputBorder inputBorder(bool isDark, bool useBorder, double? radius) {
    return OutlineInputBorder(
      borderSide: useBorder
          ? BorderSide(
              color: isDark ? PColors.grey.withOpacity(0.2) : PColors.grey)
          : BorderSide.none,
      borderRadius: BorderRadius.all(
        Radius.circular(radius ?? 14.0),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(PDeviceUtils.getAppBarHeight());
}

class SearchIcon extends StatelessWidget {
  const SearchIcon({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(10.0),
      child: Icon(
        Iconsax.search_normal_1,
        size: 20,
        // color: isDark ? PColors.black : PColors.white,

        // color: Colors.white,
      ),
    );
  }
}
