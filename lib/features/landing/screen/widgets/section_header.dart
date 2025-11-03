import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.subtitle,
    required this.title,
  });
  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);
    final isMobile = responsive.isMobile;
    return Column(
      spacing: 8,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium!.apply(
                // fontWeightDelta: 2,
                fontSizeDelta:isMobile? -2: 7,
              ),
        ),
        SizedBox(
          width:isMobile? 300: 476,
          child: Text(
            subtitle,
            style: Theme.of(context).textTheme.titleSmall!.apply(
                // fontWeightDelta: 2,
                fontSizeDelta:isMobile? -4: 0,

                ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
