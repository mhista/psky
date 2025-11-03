import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class SubHeader extends StatelessWidget {
  const SubHeader({
    super.key,
    required this.title,
    required this.subTitle,
    required this.color,
  });
  final String title, subTitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);
    final isMobile = responsive.isMobile;

    return Padding(
      padding:  EdgeInsets.only(top: 22, left:isMobile?0: 27),
      child: Column(
        crossAxisAlignment:isMobile? CrossAxisAlignment.center: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall!.apply(
                // fontWeightDelta: 2,
                fontSizeDelta:isMobile? -2: 7,

                color: color),
                  textAlign: isMobile? TextAlign.center:null,

          ),
          SizedBox(
            width:isMobile? 270: 311,
            child: Text(
              subTitle,
              style: Theme.of(context).textTheme.titleSmall!.apply(
                  // fontWeightDelta: 2,
                  fontSizeDelta: isMobile? -4: -2,
                  color: color.withValues(alpha: 0.6)),
                  textAlign: isMobile? TextAlign.center:null,
            ),
          ),
        ],
      ),
    );
  }
}

