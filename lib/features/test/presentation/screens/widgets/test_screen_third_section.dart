
import 'package:ahiaa_web/core/common/widgets/buttons/dropdown_buttons.dart';
import 'package:ahiaa_web/core/common/widgets/buttons/elevated_r_button.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/progress/animated_linear_progress.dart';
import 'package:ahiaa_web/core/common/widgets/shimmer/three_to_one_shimmer.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class TestScreenThirdSection extends StatelessWidget {
  const TestScreenThirdSection({
    super.key,
    required this.isLoading,
    required this.hasData,
    required this.hasError,
    required this.isFirstTime,
  });

  final bool isLoading;
  final bool hasData;
  final bool hasError;
  final bool isFirstTime;

  @override
  Widget build(BuildContext context) {
    return ThreeToOneShimmer(
        isLoading: isLoading,
        hasData: hasData,
        hasError: hasError,
        width: double.infinity,
        radius: 16,
        height: 220,
        useFunction: true,
        errorText:
            "The Report can't be displayed due to incomplete data",
        errorButtonText: 'Contact Support',
        errorColor: PColors.tertiary.withValues(alpha: 0.5),
        loadedWidget: TRoundedContainer(
          height: 487,
          showBorder: hasData,
          width: double.infinity,
          backgroundColor: isFirstTime
              ? PColors.primary.withValues(alpha: 0.4)
              : null,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ResponsiveText('Completed Tests')
                          .withSize(26)
                          .bold,
                      const ResponsiveText(
                              'Review and track your past test attempts')
                          .withSize(12),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 12,
                    children: [
                      KDropDownButton(
                        text: 'Date',
                        showBorder: true,
                        isActive: hasData,
                        size: 7,
                      ),
                      KDropDownButton(
                        text: 'Subjects',
                        showBorder: true,
                        isActive: hasData,
                        size: 7,
                      ),
                    ],
                  )
                ],
              ),
              const Gap(20),
              TRoundedContainer(
                height: 52,
                radius: 16,
                backgroundColor: PColors.light.withValues(alpha: 0.6),
                child: Row(
                  spacing: 120,
                  children: [
                    const ResponsiveText('Subject')
                        .withSize(10)
                        .withWeight(FontWeight.w500)
                        .withOpacity(0.6),
                    const ResponsiveText('Date Taken')
                        .withSize(10)
                        .withWeight(FontWeight.w500)
                        .withOpacity(0.6),
                    const ResponsiveText('Score')
                        .withSize(10)
                        .withWeight(FontWeight.w500)
                        .withOpacity(0.6),
                    Padding(
                      padding: const EdgeInsets.only(left: 60.0),
                      child: const ResponsiveText('Status')
                          .withSize(10)
                          .withWeight(FontWeight.w500)
                          .withOpacity(0.6),
                    ),
                  ],
                ),
              ),
              if (hasData)
                Expanded(
                  child: ListView.separated(
                      padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.start,
                              spacing: 100,
                              children: [
                                const ResponsiveText('Mathmatics')
                                    .withSize(9)
                                    .bold,
                                const ResponsiveText('25/09/2025')
                                    .withSize(9),
                                // Multi-segment (like your image)
                                LinearGradeProgress(
                                  currentGrade: 22,
                                  totalGrade: 30,
                                  height: 4,
                                  width: 139,
                                  segments: [
                                    GradeSegment(
                                        value: 8,
                                        color: PColors.primary),
                                  ],
                                ),
                                TRoundedContainer(
                                  height: 28,
                                  radius: 1000,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 7),
                                  backgroundColor: PColors.secondary1
                                      .withValues(alpha: 0.28),
                                  child: const ResponsiveText(
                                          'Excellent')
                                      .withSize(9)
                                      .withColor(PColors.secondary1),
                                ),
                              ],
                            ),
                            TElevatedButton(
                              text: 'View Report',
                              color: PColors.white,
                              bgColor: PColors.primary,
                              onTap: () {},
                            ),
                           const Gap(15)
                          ],
                        );
                      },
                      separatorBuilder: (context, _) =>
                          const TRoundedContainer(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            width: double.infinity,
                            height: 0.5,
                            backgroundColor: PColors.darkGrey,
                          ),
                      itemCount: 15),
                ),
              if (isFirstTime)
                Column(
                  children: [
                    const Gap(10),
                    TRoundedContainer(
                      height: 307,
                      radius: 16,
                      backgroundColor:
                          PColors.light.withValues(alpha: 0.6),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const ResponsiveText(
                                    'Your subject performance will appear here ')
                                .withSize(14)
                                .withWeight(FontWeight.w600)
                                .withOpacity(0.6),
                            const ResponsiveText(
                                    'after you complete a few tests.')
                                .withSize(14)
                                .withWeight(FontWeight.w600)
                                .withOpacity(0.6),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
            ],
          ),
        ));
  }
}