import 'package:ahiaa_web/core/common/layout/templates/app_layout.dart';
import 'package:ahiaa_web/core/common/layout/templates/site_template.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/shimmer/three_to_one_shimmer.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/features/progress_and_analytics/presentation/screens/widgets/progress_and_anlytics_second_section.dart';
import 'package:ahiaa_web/features/progress_and_analytics/presentation/screens/widgets/progress_and_anlytics_third_section.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProgressAnalyticsPage extends StatelessWidget {
  const ProgressAnalyticsPage({
    super.key,
    this.isLoading = false,
    this.hasError = false,
    this.expand = false,
    this.isFirstTime = true,
    this.hasData = false,
  });

  final bool isLoading, hasError, hasData, expand, isFirstTime;

  @override
  Widget build(BuildContext context) {
    return SiteTemplate2(
      useLayout: true,
      desktop: SingleChildScrollView(
        child: Column(
          spacing: 12,
          children: [
            // FIRST SECTION
            TRoundedContainer(
              backgroundColor: PColors.light,
              child: Column(
                spacing: 12,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ResponsiveText('Your Overall Performance')
                              .withSize(20)
                              .bold,
                          const ResponsiveText(
                                  "A quick snapshot of how you're doing so far")
                              .withSize(9)
                        ],
                      ),
                      TRoundedContainer(
                        onTap: () {},
                        padding: const EdgeInsets.all(12),
                        radius: 1000,
                        height: 54,
                        backgroundColor: PColors.grey,
                        child: Row(
                          spacing: 8,
                          children: [
                            const Icon(Iconsax.calendar_2),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const ResponsiveText('Date').withSize(9),
                                const ResponsiveText("01 Sept - 30 Sept 2025")
                                    .withSize(9)
                              ],
                            ),
                            const Icon(Icons.arrow_drop_down_outlined)
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    spacing: 12,
                    // runAlignment: WrapAlignment.center,
                    children: [
                      Expanded(
                        child: ThreeToOneShimmer(
                          isLoading: isLoading,
                          hasError: hasError,
                          hasData: hasData,
                          loadedWidget: AnalyticsAverage(
                              hasData: hasData,
                              title: 'Average Score',
                              subtitle: 'Your mean score across all exams',
                              score: '75',
                              symbol: '%',
                              info: 'Your mean score across all exams'),
                        ),
                      ),
                      Expanded(
                        child: ThreeToOneShimmer(
                          isLoading: isLoading,
                          hasError: hasError,
                          hasData: hasData,
                          loadedWidget: AnalyticsAverage(
                              hasData: hasData,
                              isUp: false,
                              title: 'Total Exams',
                              subtitle: 'Number of practice tests completed',
                              score: '12',
                              symbol: '',
                              info: '24% decrease from last month'),
                        ),
                      ),
                      Expanded(
                        child: ThreeToOneShimmer(
                          isLoading: isLoading,
                          hasError: hasError,
                          hasData: hasData,
                          loadedWidget: AnalyticsAverage(
                              hasData: hasData,
                              isUp: false,
                              title: 'Time Spent',
                              subtitle: "Total time you've taken to practice",
                              score: '15',
                              symbol: 'hrs',
                              info: '20% decrease from last month'),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            // SECOND SECTION
            TRoundedContainer(
              backgroundColor: PColors.light,
              child: Column(
                children: [
                  ProgressAndAnlyticsSecondSection(
                      isLoading: isLoading,
                      hasData: hasData,
                      hasError: hasError,
                      isFirstTime: isFirstTime)
                ],
              ),
            ),
            TRoundedContainer(
              backgroundColor: PColors.light,
              child: Column(
                children: [
                  ProgressAndAnlyticsThirdSection(
                      isLoading: isLoading,
                      hasData: hasData,
                      hasError: hasError,
                      isFirstTime: isFirstTime)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AnalyticsAverage extends StatelessWidget {
  const AnalyticsAverage(
      {super.key,
      this.isUp = true,
      required this.title,
      required this.subtitle,
      required this.score,
      required this.symbol,
      required this.info,
      required this.hasData});
  final bool isUp, hasData;
  final String title, subtitle, score, info, symbol;
  @override
  Widget build(BuildContext context) {
    final color = isUp ? PColors.white : PColors.black;
    final avColor = isUp ? PColors.white : PColors.primary2;

    return TRoundedContainer(
      backgroundColor: !hasData
          ? PColors.grey
          : isUp
              ? PColors.primary
              : PColors.primary.withValues(alpha: 0.4),
      height: 150,
      child: hasData
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ResponsiveText(title).withSize(9).withColor(color).bold,
                    ResponsiveText(subtitle).withSize(6).withColor(color),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ResponsiveText('$score$symbol')
                        .withSize(32)
                        .withColor(avColor)
                        .bold,
                    Row(
                      spacing: 8,
                      children: [
                        if (isUp) const Icon(Iconsax.trend_up),
                        if (!isUp) const Icon(Iconsax.trend_down),
                        const ResponsiveText(
                                "Your mean score accross all exams")
                            .withSize(6)
                      ],
                    )
                  ],
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ResponsiveText('No data yet')
                        .withSize(9)
                        .withColor(PColors.darkGrey)
                        .bold,
                    const ResponsiveText(
                            'Take your first examination to see performance here')
                        .withSize(6)
                        .withColor(PColors.darkGrey),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ResponsiveText('00$symbol')
                        .withSize(32)
                        .withColor(PColors.darkGrey)
                        .bold,
                    Row(
                      spacing: 8,
                      children: [
                        if (isUp) const Icon(Iconsax.trend_up),
                        if (!isUp) const Icon(Iconsax.trend_down),
                        const ResponsiveText(
                                "Your mean score accross all exams")
                            .withSize(6)
                      ],
                    )
                  ],
                ),
              ],
            ),
    );
  }
}
