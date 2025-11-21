
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/features/progress_and_analytics/presentation/screens/widgets/average_mean_widget.dart';
import 'package:ahiaa_web/features/progress_and_analytics/presentation/screens/widgets/progress_and_anlytics_second_section.dart';
import 'package:ahiaa_web/features/progress_and_analytics/presentation/screens/widgets/progress_and_anlytics_third_section.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProgressAnalyticsDesktop extends StatelessWidget {
  const ProgressAnalyticsDesktop({
    super.key,
    required this.isLoading,
    required this.hasError,
    required this.hasData,
    required this.isFirstTime,
  });

  final bool isLoading;
  final bool hasError;
  final bool hasData;
  final bool isFirstTime;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Row(
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
                            ],
                          ),
                          const Icon(Icons.arrow_drop_down_outlined)
                        ],
                      ),
                    )
                  ],
                ),
                AverageMeanWidget(isLoading: isLoading, hasError: hasError, hasData: hasData)
              ],
            ),
          ),
          // SECOND SECTION
          // TRoundedContainer(
          //   backgroundColor: PColors.light,
          //   child: Column(
          //     children: [
          //       ProgressAndAnlyticsSecondSection(
          //           isLoading: isLoading,
          //           hasData: hasData,
          //           hasError: hasError,
          //           isFirstTime: isFirstTime)
          //     ],
          //   ),
          // ),
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
    );
  }
}
