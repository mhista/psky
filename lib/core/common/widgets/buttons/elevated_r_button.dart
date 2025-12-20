import 'package:ahiaa_web/core/common/loaders/loading_button.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class TElevatedButton extends StatelessWidget {
  const TElevatedButton(
      {super.key,
      required this.text,
      this.bgColor = PColors.white,
      this.color = PColors.primary,
      this.density = -4,
      this.verticalPadding = 0,
      this.size = 6,
      this.onTap,
      this.isLoading = false});
  final String text;
  final Color bgColor, color;
  final double size, density, verticalPadding;
  final Function()? onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          padding:
              EdgeInsets.symmetric(vertical: verticalPadding, horizontal: 15),
          visualDensity: VisualDensity(vertical: density),
          backgroundColor: bgColor),
      child: isLoading
          ? const LoadingAnimator()
          : ResponsiveText(
              text,
              letterSpacing: 1.0,
            ).responsive.labelMedium.withColor(color).withSize(size).exBold,
    );
  }
}
