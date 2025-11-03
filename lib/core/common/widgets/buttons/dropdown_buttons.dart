import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class KDropDownButton extends StatelessWidget {
  const KDropDownButton(
      {super.key,
      this.animate = false,
      this.isActive = true,
      this.showBorder = false,
      required this.text,
      this.bgColor,
      this.onTap,
      this.size = 6});
  final bool animate, isActive, showBorder;
  final String text;
  final Function()? onTap;
  final double size;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? PColors.deepBlack : PColors.darkGrey;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: TRoundedContainer(
        onTap: onTap,
        // width: 107,
        height: 25,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        backgroundColor:
            showBorder ? PColors.transparent : bgColor ?? PColors.white,
        showBorder: showBorder,
        borderColor: showBorder
            ? isActive
                ? PColors.deepBlack
                : PColors.darkGrey
            : null,
        radius: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ResponsiveText(text).withSize(size).withColor(color),
            // const Gap(5),
            Icon(
              Icons.arrow_drop_down_rounded,
              size: 17,
              color: isActive ? null : PColors.darkGrey,
            )
          ],
        ),
      ),
    );
  }
}
