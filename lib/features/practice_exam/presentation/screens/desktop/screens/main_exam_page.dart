import 'package:ahiaa_web/core/common/layout/templates/site_template.dart';
import 'package:ahiaa_web/core/common/widgets/buttons/elevated_r_button.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/icons/circular_icon.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/screens/widgets/question_index_containers.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/screens/widgets/question_page_view.dart';
import 'package:flutter/material.dart';

class MainExamScreenDesktop extends StatelessWidget {
  const MainExamScreenDesktop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          // SUBJECT INTRO SECTION
          TRoundedContainer(
            padding: const EdgeInsets.all(12),
            backgroundColor: PColors.light,
            height: 72,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ResponsiveText('Subject').withSize(8),
                    const ResponsiveText('Mathematics').withSize(16).bold,
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const ResponsiveText('Time left:')
                            .withSize(10)
                            .bold
                            .withColor(PColors.primary),
                        const ResponsiveText('01:30:24')
                            .withSize(15)
                            .bold
                            .withColor(PColors.primary),
                      ],
                    ),
                    const PCircularIcon(
                      icon: Icons.filter_list,
                      height: 40,
                      width: 40,
                    )
                  ],
                )
              ],
            ),
          ),
          // MAIN QUESTION SECTION
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TRoundedContainer(
                    backgroundColor: PColors.light,
                    // padding: const EdgeInsets.all(0),
                    child: SingleChildScrollView(
                      child: Column(
                        spacing: 15,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const ResponsiveText('Question 3 of 50')
                                  .withSize(9)
                                  .bold,
                              const Icon(Icons.flag_outlined)
                            ],
                          ),
                          const ResponsiveText(
                                  'Solve for x in the equation 3x + 5 = 14')
                              .withSize(10),
                          const TRoundedContainer(
                              padding: EdgeInsets.all(0),
                              height: 300,
                              child: QuestionPageView())
                          // const OptionedQuestionWidget()
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TElevatedButton(
                          text: 'Previous',
                          onTap: () {},
                          bgColor: PColors.primary,
                          color: PColors.white,
                        ),
                        TElevatedButton(
                          text: 'Next',
                          onTap: () {},
                          bgColor: PColors.primary,
                          color: PColors.white,
                        )
                      ],
                    ),
                  ),
                  const QuestionIndexContainers()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class OptionedQuestionWidget extends StatelessWidget {
  const OptionedQuestionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      backgroundColor: PColors.white,
      width: double.infinity,
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TRoundedContainer(
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                const SizedBox(
                  height: 20,
                  width: 20,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 4,
                        left: 4,
                        child: TRoundedContainer(
                          height: 16,
                          width: 16,
                          radius: 100,
                          showShadow: false,
                          showBorder: true,
                          borderColor: PColors.primary,
                        ),
                      ),
                      Positioned(
                        top: 7.2,
                        left: 7.6,
                        child: TRoundedContainer(
                          height: 9.33,
                          width: 9.33,
                          radius: 100,
                          showShadow: false,
                          showBorder: false,
                          backgroundColor: PColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: const ResponsiveText('(A)').withSize(10),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.5),
                  child: const ResponsiveText('3').withSize(11),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
