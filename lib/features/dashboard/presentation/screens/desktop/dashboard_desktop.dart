import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/images/edge_rounded_images.dart';
import 'package:ahiaa_web/core/common/widgets/shimmer/three_to_one_shimmer.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/features/dashboard/presentation/screens/widgets/ai_insights.dart';
import 'package:ahiaa_web/features/dashboard/presentation/screens/widgets/dashboard_big_info.dart';
import 'package:ahiaa_web/features/dashboard/presentation/screens/widgets/days_active_widget.dart';
import 'package:ahiaa_web/features/dashboard/presentation/screens/widgets/fire_streake_container.dart';
import 'package:ahiaa_web/features/dashboard/presentation/screens/widgets/leaderboard_widget.dart';
import 'package:ahiaa_web/features/dashboard/presentation/screens/widgets/quick_start_widget.dart';
import 'package:ahiaa_web/features/dashboard/presentation/screens/widgets/score_gauge.dart';
import 'package:ahiaa_web/features/dashboard/presentation/screens/widgets/test_completion_info.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/utils/enums/enums.dart';
import 'package:ahiaa_web/core/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' hide Theme;

class DashboardDesktop extends StatelessWidget {
  const DashboardDesktop(
      {super.key,
      this.isLoading = false,
      this.hasError = false,
      this.expand = false,
      this.hasData = true});
  final bool isLoading, hasError, hasData, expand;
  @override
  Widget build(BuildContext context) {
    final subjects = [
      SubjectScore(
          name: 'Chemistry', score: 100, color: PColors.primary5),
      SubjectScore(name: 'Biology', score: 100, color:  PColors.primary2),
      SubjectScore(
          name: 'Mathematics', score: 20, color: PColors.darkerGrey),
      SubjectScore(
          name: 'Chemistry', score: 20, color: PColors.white),
    ];
    final totalAverage =
        (subjects!.fold(0.0, (sum, subject) => sum + subject.score)) /
            subjects.length;
    return TRoundedContainer(
      padding: const EdgeInsets.all(0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 12,
          children: [
            // SECTION 1
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              spacing: 24,
              children: [
                // NAME SECTION
                Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isLoading)
                      const Column(
                        spacing: 10,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gap(10),
                          ThreeToOneShimmer(
                            loadedWidget: SizedBox.shrink(),
                            height: 12,
                            width: 139,
                            radius: 4,
                          ),
                          ThreeToOneShimmer(
                              loadedWidget: SizedBox.shrink(),
                              height: 12,
                              width: 212,
                              radius: 4),
                          ThreeToOneShimmer(
                              loadedWidget: SizedBox.shrink(),
                              height: 12,
                              width: 239,
                              radius: 4),
                        ],
                      ),
                    if (hasError || hasData)
                      TRoundedContainer(
                        width: 250,
                        padding: const EdgeInsets.all(0),
                        child: Column(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Hi, Nana!').x4Large.black.animate().fadeIn(duration: 1000.ms),
                            const Text('What are you learning today?')
                                .x4Large
                                .black
                                .withOpacity(0.5).animate(delay: 500.ms).fadeIn(duration: 800.ms)
                          ],
                        ),
                      )
                  ],
                ),
                DashboardBigInfo(
                    isLoading: isLoading, hasData: hasData, hasError: hasError)
              ],
            ),

            // SECTION 2
            Row(
              spacing: 12,
              children: [
                Expanded(
                  child: ThreeToOneShimmer(
                      isLoading: isLoading,
                      hasData: hasData,
                      hasError: hasError,
                      width: double.infinity,
                      shouldUseLoadedData: true,
                      radius: 16,
                      height: 72,
                      errorColor: PColors.primary.withValues(alpha: 0.4),
                      loadedWidget: const QuickStartWidget(
                          bgColor: PColors.primary5,
                          text: 'Start full mock exam',
                          subtitle: 'Take a timed, WAEC-style mock to test your stamina and track your score across subjects.',
                          buttonText: 'Start mock',
                          icon: Iconsax.note_2)),
                ),
                Expanded(
                  child: ThreeToOneShimmer(
                      isLoading: isLoading,
                      hasData: hasData,
                      hasError: hasError,
                      width: double.infinity,
                      shouldUseLoadedData: true,
                      radius: 16,
                      height: 72,
                      errorColor: PColors.tertiary.withValues(alpha: 0.5),
                      loadedWidget: const QuickStartWidget(
                          bgColor: PColors.bg2,
                          text: 'Quick 10-Q/A drill',
                          subtitle: 'Short, focused drills to target weak topics — perfect for study breaks and fast progress.',
                          buttonText: 'Start drill',
                          icon: Iconsax.flash)),
                ),
                Expanded(
                  child: ThreeToOneShimmer(
                      isLoading: isLoading,
                      hasData: hasData,
                      hasError: hasError,
                      width: double.infinity,
                      shouldUseLoadedData: true,
                      radius: 16,
                      height: 72,
                      errorColor: PColors.primary.withValues(alpha: 0.3),
                      loadedWidget: const QuickStartWidget(
                          bgColor: PColors.primary3,
                          useAi: true,
                          text: 'Personalized AI plan',
                          subtitle: 'Choose subjects, topics, and number of questions to create a set that matches your study needs.',
                          buttonText: 'Create test',
                          icon: Icons.arrow_drop_down_rounded)),
                )
              ],
            ),

            // SECTION THREE
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                Expanded(
                  child: Column(
                    spacing: 12,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TRoundedContainer(
                        padding: const EdgeInsets.all(12),
                        height: 404,
                        backgroundColor: PColors.light,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          spacing: 12,
                          children: [
                            Row(
                              spacing: 12,
                              children: [
                                Expanded(
                                  child: ThreeToOneShimmer(
                                      isLoading: isLoading,
                                      hasError: hasError,
                                      hasData: hasData,
                                      shimmerColor: PColors.white,
                                      radius: 12,
                                      height: 128,
                                      width: 178,
                                      errorColor:
                                          PColors.bg4.withValues(alpha: 0.3),
                                      errorText:
                                          'Data unavailable, Please check your connection',
                                      loadedWidget:const FireStreakWidget(streakDays: 20)),
                                ),
                                Expanded(
                                  child: ThreeToOneShimmer(
                                      isLoading: isLoading,
                                      hasError: hasError,
                                      hasData: hasData,
                                      shimmerColor: PColors.white,
                                      radius: 12,
                                      height: 128,
                                      width: 178,
                                      errorColor:
                                          PColors.bg4.withValues(alpha: 0.3),
                                      errorText:
                                          'Data unavailable, Please check your connection',
                                      loadedWidget: ScoreGaugeWidget(
                                        totalAverage: totalAverage,
                                        subjects: subjects,
                                        isExpanded: expand,
                                      )),
                                ),
                                Expanded(
                                  child: ThreeToOneShimmer(
                                      isLoading: isLoading,
                                      hasError: hasError,
                                      hasData: hasData,
                                      shimmerColor: PColors.white,
                                      radius: 12,
                                      height: 128,
                                      errorColor:
                                          PColors.bg4.withValues(alpha: 0.3),
                                      errorText:
                                          'Data unavailable, Please check your connection',
                                      width: 178,
                                      loadedWidget: TestTracker(isExpanded: expand,)),
                                ),
                              ],
                            ),
                            ThreeToOneShimmer(
                                isLoading: isLoading,
                                hasError: hasError,
                                hasData: hasData,
                                radius: 16,
                                height: 240,
                                width: double.infinity,
                                errorColor: PColors.bg4.withValues(alpha: 0.3),
                                errorText:
                                    "Couldn't load activity, Try again later",
                                loadedWidget:const DaysActiveWidget())
                          ],
                        ),
                      ),
                      ThreeToOneShimmer(
                          isLoading: isLoading,
                          hasError: hasError,
                          hasData: hasData,
                          radius: 12,
                          height: 57,
                          width: double.infinity,
                          errorColor: PColors.tertiary.withValues(alpha: 0.5),
                          shouldCenter: false,
                          errorText: "Couldn't fetch insights, Retry later",
                          loadedWidget: const AiInsightWidget())
                    ],
                  ),
                ),
                ThreeToOneShimmer(
                    isLoading: isLoading,
                    hasError: hasError,
                    hasData: hasData,
                    radius: 16,
                    height: 478,
                    errorColor: PColors.tertiary.withValues(alpha: 0.4),
                    errorText:
                        'Leaderboard unavailable, Please check back soon',
                    width: expand ? 366 : 280,
                    loadedWidget: LeaderBoardWidget(expand: expand))
              ],
            )
          ],
        ),
      ),
    );
  }
}








