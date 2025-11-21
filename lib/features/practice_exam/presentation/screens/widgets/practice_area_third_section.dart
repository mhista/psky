
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PracticeExamThirdSection extends StatelessWidget {
  const PracticeExamThirdSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: const EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ResponsiveText('Focus on weak areas')
                    .withSize(9)
                    .bold,
                const Gap(4),
                const ResponsiveText(
                        "We'll mix questions evenly across topics")
                    .withSize(9),
              ],
            ),
            Switch(value: true, onChanged: (v) {})
          ],
        ),
      ),
    );
  }
}
