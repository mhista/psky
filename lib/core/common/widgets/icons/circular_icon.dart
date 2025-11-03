import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' hide IconButton;

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class PCircularIcon extends StatelessWidget {
  // Custom circular icon with a backgrund

  // properties
  //Container [width, height and backgroundColor]
// Icon [size, color and onPressed]
  const PCircularIcon({
    super.key,
   this.icon,
    this.color,
    this.backgroundColor,
    this.width,
    this.height,
    this.onPressed,
    this.size = PSizes.lg,
    this.animate = true,
    this.usesBadge = false,

    this.productId, this.widget,
  });

  final IconData? icon;
  final Color? color, backgroundColor;

  final double? width, height, size;
  final VoidCallback? onPressed;
  final bool animate, usesBadge;
  final String? productId;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunctions.isDarkMode(context);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: backgroundColor ??
              (isDark
                  ? PColors.primary.withValues(alpha:0.2)
                  : PColors.primary.withValues(alpha:0.2)),
          borderRadius: BorderRadius.circular(100)),
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
                onPressed: onPressed,
                icon:widget ?? Icon(
                  icon,
                  color: color ??PColors.primary ,
                  size: size,
                )),
                if(usesBadge)
                Positioned(
                  right: -3,
                  top: -5,
                  child: Badge(
                    backgroundColor: PColors.bg2,
                    textColor: PColors.white,
                    label: Text('9').xSmall.bold,
                  ),
                )
          ],
        ),
      ),
    );
  }
}
