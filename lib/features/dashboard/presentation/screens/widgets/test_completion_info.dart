import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class TestTracker extends StatelessWidget {
  const TestTracker({
    super.key,
    this.isExpanded = false
  });
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final data = List.generate(20, (index) => index);
    return TRoundedContainer(
      padding: const EdgeInsets.all(8),
      height: 128,
      width: 178,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: const ResponsiveText('75%')
              .withSize(28)
              .bold
              .withColor(PColors.primary5),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: SizedBox(
              width: 80,
              child: const ResponsiveText('Test Completion Rate')
                  .withSize(8)
                  .withColor(PColors.primary5)),
        ),
       const Gap(1),

        Row(
          spacing: 2,
          mainAxisAlignment: MainAxisAlignment.center,
          children: data
              .map((i) =>  TRoundedContainer(
                    width:isExpanded? 10: 6,
                    height: 35,
                    radius: 1000,
                    backgroundColor: PColors.primary,
                  ))
              .toList(),
        )
      ]),
    );
  }
}
