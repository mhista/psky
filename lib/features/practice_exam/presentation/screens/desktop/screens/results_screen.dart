import 'package:ahiaa_web/core/common/layout/templates/site_template.dart';
import 'package:ahiaa_web/core/common/widgets/buttons/elevated_r_button.dart';
import 'package:ahiaa_web/core/common/widgets/buttons/outlined_r_button.dart';
import 'package:ahiaa_web/core/common/widgets/buttons/text_r_button.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/images/edge_rounded_images.dart';
import 'package:ahiaa_web/core/common/widgets/progress/dynamic_circular_progress.dart'
    show DynamicCircularProgress;
import 'package:ahiaa_web/core/common/widgets/shimmer/three_to_one_shimmer.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/utils/constants/image_strings.dart';
import 'package:ahiaa_web/core/utils/enums/enums.dart';
import 'package:ahiaa_web/features/dashboard/presentation/screens/widgets/ai_insights.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' hide Divider;

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    this.isLoading = false,
    this.hasError = false,
    this.expand = false,
    this.isFirstTime = false,
    this.hasData = true,
  });

  final bool isLoading, hasError, hasData, expand, isFirstTime;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);
    return SiteTemplate2(
      useLayout: true,
      desktop: ThreeToOneShimmer(
        isLoading: isLoading,
        hasError: hasError,
        hasData:hasData,
        width: responsive.screenWidth,
        height: responsive.screenHeight,
        errorColor: PColors.tertiary.withValues(alpha: 0.5),
        radius: 16,
        errorText: "We couldn't load your results right now",
        errorButtonText: 'Retry',
        canReload: true,
        useFunction: true,
        callBack: () {},
        loadedWidget: TRoundedContainer(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 31,
              children: [
                // SUBJECT INTRO SECTION
                Column(
                  spacing: 12,
                  children: [
                    const PRoundedImage(
                      imageType: ImagesType.asset,
                      image: PImages.passed,
                    ),
                    SizedBox(
                        width: 340,
                        child: const ResponsiveText(
                                'Well done! Your mathematics exam is complete')
                            .withSize(21)
                            .bold
                            .withAlign(TextAlign.center)),
                  ],
                ),
                TRoundedContainer(
                  // height: 292,
                  width: 468,
                  child: Column(
                    children: [
                      TRoundedContainer(
                        width: 409,
                        height: 52,
                        backgroundColor: PColors.light,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const ResponsiveText('Subject').bold.withSize(10),
                            const ResponsiveText('Score').bold.withSize(10),
                            const ResponsiveText('Grade').bold.withSize(10)
                          ],
                        ),
                      ),
                      TRoundedContainer(
                        width: 439,
                        child: Column(
                          spacing: 10,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const ResponsiveText('Subject').withSize(10),
                                const ResponsiveText('15/30').withSize(10),
                                TRoundedContainer(
                                  padding: const EdgeInsets.all(0),
                                  backgroundColor:
                                      PColors.tertiary.withValues(alpha: 0.5),
                                  width: 32,
                                  height: 28,
                                  radius: 1000,
                                  child: Center(
                                    child: const ResponsiveText('A')
                                        .withSize(12)
                                        .withColor(PColors.bg2),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              height: 0.2,
                              color: PColors.grey,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 40,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ResponsiveText('Total Score')
                            .withSize(10)
                            .bold
                            .withAlign(TextAlign.center)
                            .withOpacity(0.7),
                        const ResponsiveText('42/50')
                            .withSize(34)
                            .bold
                            .withAlign(TextAlign.center),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ResponsiveText('Grade')
                            .withSize(10)
                            .bold
                            .withAlign(TextAlign.center)
                            .withOpacity(0.7),
                        const ResponsiveText('B - Very Good')
                            .withSize(34)
                            .bold
                            .withAlign(TextAlign.center),
                      ],
                    )
                  ],
                ),
                Center(
                  child: Wrap(
                    spacing: 30,
                    runSpacing: 30,
                    alignment: WrapAlignment.center,
                    children: [
                      // Time format 1
                      DynamicCircularProgress.time(
                        current: const Duration(hours: 1, minutes: 12),
                        total: const Duration(hours: 2),
                        label: 'Time Spent',
                        size: 71,
                        animate: true,
                      ),

                      // Time format 2
                      DynamicCircularProgress.time(
                        current: const Duration(hours: 1, minutes: 30),
                        total: const Duration(hours: 2),
                        label: 'Allocated Time',
                        size: 71,
                        animate: true,
                        progressColor: const Color(0xFF6366F1),
                        backgroundColor: const Color(0xFFE0E7FF),
                        textColor: const Color(0xFF6366F1),
                      ),

                      // Grade/Score
                      DynamicCircularProgress.grade(
                        currentGrade: 8,
                        totalGrade: 50,
                        label: 'Questions wrong',
                        size: 71,
                        animate: true,
                        progressColor: const Color(0xFFEC4899),
                        backgroundColor: const Color(0xFFFCE7F3),
                        textColor: const Color(0xFFEC4899),
                      ),

                      // Count (meetings)
                      DynamicCircularProgress.count(
                        current: 42,
                        total: 50,
                        label: 'Questions correct',
                        size: 71,
                        animate: true,
                        progressColor: const Color(0xFF10B981),
                        backgroundColor: const Color(0xFFD1FAE5),
                        textColor: const Color(0xFF10B981),
                      ),

                      // Count (skipped)
                      DynamicCircularProgress.count(
                        current: 0,
                        total: 5,
                        label: 'Questions Skipped',
                        size: 71,
                        animate: true,
                        progressColor: const Color(0xFFF59E0B),
                        backgroundColor: const Color(0xFFFEF3C7),
                        textColor: const Color(0xFFF59E0B),
                      ),

                      // Custom formatter (percentage)
                      DynamicCircularProgress(
                        currentValue: 75,
                        totalValue: 100,
                        label: 'Complete',
                        valueFormatter: (curr, total) => '${curr.toInt()}%',
                        size: 71,
                        animate: true,
                        progressColor: const Color(0xFF8B5CF6),
                        backgroundColor: const Color(0xFFEDE9FE),
                        textColor: const Color(0xFF8B5CF6),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    width: 646,
                    child: AiInsightWidget(
                      bgColor: PColors.grey,
                      extra: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: TElevatedButton(
                          text: 'View full Report',
                          bgColor: PColors.primary,
                          color: PColors.white,
                          onTap: () {},
                        ),
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 12,
                  children: [
                    TElevatedButton(
                      text: 'View Report',
                      bgColor: PColors.primary,
                      color: PColors.white,
                      onTap: () {},
                    ),
                    TOutlinedButton(
                      text: 'Retake Exam',
                      bgColor: PColors.primary,
                      color: PColors.primary,
                      onTap: () {},
                    ),
                    TTextButton(
                      text: 'Create Custom Practice',
                      bgColor: PColors.primary,
                      color: PColors.primary,
                      onTap: () {},
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
