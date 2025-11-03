import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class TOutlinedButton extends StatelessWidget {
  const TOutlinedButton(
      {super.key,
      required this.text,
      this.bgColor = PColors.white,
      this.color = PColors.primary,
      this.density = -4,
      this.verticalPadding = 0,
      this.size = 6,
      this.onTap});
  final String text;
  final Color bgColor, color;
  final double size, density, verticalPadding;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
          padding:
              EdgeInsets.symmetric(vertical: verticalPadding, horizontal: 15),
          visualDensity: VisualDensity(vertical: density),
          ),
      child: ResponsiveText(
        text,
        letterSpacing: 1.0,
      ).responsive.labelMedium.withColor(color).withSize(size).exBold,
    );
  }
}
