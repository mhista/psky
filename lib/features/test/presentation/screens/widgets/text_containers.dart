import 'package:ahiaa_web/core/common/widgets/buttons/elevated_r_button.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/progress/animated_circular_progress.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestContainers extends StatelessWidget {
  const TestContainers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: const EdgeInsets.all(9),
      backgroundColor: PColors.light,
      height: 86,
      radius: 12,
      child: Column(
        spacing: 5,
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const ResponsiveText(
                            'Mathematics')
                        .withSize(11).bold,
                    const ResponsiveText(
                            'Full Mock Exam')
                        .withSize(5),
                  ],
                ),
                // Different colors
                RoundedGradeProgress(
                  currentGrade: 12,
                  animationDuration: 1500.milliseconds,
                  // animate: false,
                  totalGrade: 30,
                  size: 30,
                  progressColor:
                      PColors.primary,
                  backgroundColor:
                      PColors.primary.withValues(alpha: 0.2),
                  textColor: PColors.primary,
                )
              ],
            ),
    
            Row(
              children: [
                const TElevatedButton(text: 'Resume', bgColor: PColors.deepBlack, color: PColors.white, verticalPadding: 0,),
                TextButton(onPressed: (){}, child: const ResponsiveText('Save & Exit').bold.withSize(8).withColor(PColors.primary)),
              ],
            )
          ]),
    );
  }
}