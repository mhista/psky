import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_framework/responsive_framework.dart';

class SectionShimmerContainer extends StatelessWidget {
  const SectionShimmerContainer({
    super.key,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.height,
    required this.width,
  });
  final Color color;
  final double height, width;
  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
     final responsive = ResponsiveBreakpoints.of(context);
    final isMobile = responsive.isMobile;
    return TRoundedContainer(
      showShadow: true,
      height: height,
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TRoundedContainer(
                radius: 75,
                padding: const EdgeInsets.all(0),
                backgroundColor: color.withValues(alpha: 0.2),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
                  child: Center(
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 9, color: color),
                    ),
                  ),
                ),
              ),
              TRoundedContainer(
                height: 20,
                width: 56,
                radius: 75,
                padding: const EdgeInsets.all(0),
                backgroundColor: color.withValues(alpha: 0.2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.timer,
                      size: 14,
                      color: color,
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 9, color: color),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              TRoundedContainer(
                height: 6,
                width: 269,
                backgroundColor: color.withValues(alpha: 0.2),
              ),
              TRoundedContainer(
                height: 6,
                width: 269,
                backgroundColor: color.withValues(alpha: 0.2),
              ),
              TRoundedContainer(
                height: 6,
                width: 186,
                backgroundColor: color.withValues(alpha: 0.2),
              ),
            ],
          ),
          const Gap(20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              TRoundedContainer(
                height: 40,
                width: 295,
                radius: 8,
                backgroundColor: color.withValues(alpha: 0.2),
              ),
              const Gap(4),
              TRoundedContainer(
                height: 40,
                width: 295,
                radius: 8,
                backgroundColor: color.withValues(alpha: 0.2),
              ),
              TRoundedContainer(
                height: 40,
                width: 295,
                radius: 8,
                backgroundColor: color.withValues(alpha: 0.2),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
