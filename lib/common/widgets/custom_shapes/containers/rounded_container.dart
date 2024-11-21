import 'package:flutter/material.dart';
import 'package:ahiaa_web/utils/constants/sizes.dart';

import '../../../../utils/constants/colors.dart';

class TRoundedContainer extends StatelessWidget {
  const TRoundedContainer({
    super.key,
    this.width,
    this.height,
    this.radius = PSizes.cardRadiusLg,
    this.backgroundColor = PColors.white,
    this.borderColor = PColors.borderPrimary,
    this.child,
    this.margin,
    this.padding = const EdgeInsets.all(PSizes.md),
    this.showBorder = false,
    this.showShadow = true,
    this.onTap,
  });
  final double? width, height;
  final double radius;
  final Color backgroundColor, borderColor;
  final Widget? child;
  final EdgeInsetsGeometry? margin, padding;
  final bool showBorder, showShadow;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: backgroundColor,
            border: showBorder ? Border.all(color: borderColor) : null,
            boxShadow: [
              if (showShadow)
                BoxShadow(
                    color: PColors.grey.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 8,
                    offset: const Offset(
                      0,
                      3,
                    ))
            ]),
        child: child,
      ),
    );
  }
}
