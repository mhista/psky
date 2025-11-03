import 'package:ahiaa_web/core/common/widgets/buttons/dropdown_buttons.dart';
import 'package:ahiaa_web/core/common/widgets/buttons/elevated_r_button.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/progress/animated_linear_progress.dart';
import 'package:ahiaa_web/core/common/widgets/shimmer/three_to_one_shimmer.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/features/progress_and_analytics/presentation/screens/widgets/barchart.dart';
import 'package:ahiaa_web/main.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ProgressAndAnlyticsSecondSection extends StatelessWidget {
  const ProgressAndAnlyticsSecondSection({
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
    final responsive = ResponsiveBreakpoints.of(context);
    final isMobile = responsive.isMobile;

    double effectiveBarWidth = (isMobile ? 20 : 55);
    final sampleData = [
      PerformanceData(month: 'Jan', value: 75),
      PerformanceData(month: 'Feb', value: 95),
      PerformanceData(month: 'Mar', value: 68),
      PerformanceData(month: 'Apr', value: 42),
      PerformanceData(month: 'May', value: 88),
      PerformanceData(
        month: 'Jun',
        value: 55,
        details: hasData? {
          'Maths': 50,
          'English': 63,
          'Biology': 57,
        }:null,
      ),
      PerformanceData(month: 'Jul', value: 32),
      PerformanceData(month: 'Aug', value: 45),
      PerformanceData(month: 'Sep', value: 98),
      PerformanceData(month: 'Oct', value: 35),
      PerformanceData(month: 'Nov', value: 80),
      PerformanceData(month: 'Dec', value: 92),
    ];
    return ThreeToOneShimmer(
        isLoading: isLoading,
        hasData: hasData,
        hasError: hasError,
        width: double.infinity,
        radius: 16,
        height: 220,
        useFunction: true,
        errorText: "The Report can't be displayed due to incomplete data",
        errorButtonText: 'Contact Support',
        errorColor: PColors.tertiary.withValues(alpha: 0.5),
        loadedWidget: TRoundedContainer(
          height: 487,
          showBorder: hasData,
          width: double.infinity,
          backgroundColor:
              isFirstTime ? PColors.grey : null,
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
                      const ResponsiveText('Performance Over Time')
                          .withSize(20)
                          .bold,
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 269,
                        ),
                        child: const ResponsiveText(
                                'See how your performance has changed with each exam')
                            .withSize(10),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 12,
                    children: [
                      KDropDownButton(
                        text: 'This year',
                        showBorder: false,
                        isActive: hasData,
                        bgColor: PColors.primary.withValues(alpha: 0.3),
                        size: 7,
                      ),
                    ],
                  )
                ],
              ),
              const Gap(20),
              if (hasData)
                Expanded(
                  child: ChartBuilder()
                      .withData(sampleData)
                      .withBarColor(PColors.primary)
                      .withBackgroundColor(const Color(0xFFE8E4F3))
                      .withBarWidth(effectiveBarWidth)
                      .build(),
                ),
              if (isFirstTime)
                Expanded(
                  child: ChartBuilder()
                      .withData(sampleData)
                      .withBarColor(PColors.transparent)
                      .withBackgroundColor(const Color(0xFFE8E4F3))
                      .withBarWidth(effectiveBarWidth)
                      .withHoverAnimation(false)
                      .build(),
                ),
            ],
          ),
        ));
  }
}

BarChartData mainBarData() {
  return BarChartData(barTouchData: BarTouchData());
}
