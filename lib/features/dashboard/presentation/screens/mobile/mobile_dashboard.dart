import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/images/edge_rounded_images.dart';
import 'package:ahiaa_web/core/common/widgets/shimmer/three_to_one_shimmer.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/routes/app_router2.dart';
import 'package:ahiaa_web/core/routes/routes.dart' show KRoutes;
import 'package:ahiaa_web/features/authentication/domain/entities/user.dart';
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
import 'package:ahiaa_web/features/personalization/presentation/cubit/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' hide Theme;

class DashboardMobile extends StatelessWidget {
  const DashboardMobile(
      {super.key,
      this.isLoading = false,
      this.hasError = false,
      this.expand = false,
      this.hasData = true});
  final bool isLoading, hasError, hasData, expand;
  @override
  Widget build(BuildContext context) {
    final user = getIt<UserCubit>().currentUser ?? UserEntity.empty();
    final subjects = [
      SubjectScore(name: 'Chemistry', score: 100, color: PColors.primary5),
      SubjectScore(name: 'Biology', score: 100, color: PColors.primary2),
      SubjectScore(name: 'Mathematics', score: 20, color: PColors.darkerGrey),
      SubjectScore(name: 'Chemistry', score: 20, color: PColors.white),
    ];
    final totalAverage =
        (subjects!.fold(0.0, (sum, subject) => sum + subject.score)) /
            subjects.length;
    return TRoundedContainer(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 12,
          children: [
            // SECTION 1
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              spacing: 16,
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
                        width: 220,
                        height: 108,
                        padding: const EdgeInsets.all(0),
                        child: Column(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ResponsiveText('Hi, ${user.firstName}!')
                                .xLarge
                                .black
                                .animate()
                                .fadeIn(duration: 1000.ms),
                            const ResponsiveText('What are you learning today?')
                                .xLarge
                                .black
                                .withOpacity(0.5)
                                .animate(delay: 500.ms)
                                .fadeIn(duration: 800.ms)
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
            Column(
              spacing: 12,
              children: [
                ThreeToOneShimmer(
                    isLoading: isLoading,
                    hasData: hasData,
                    hasError: hasError,
                    width: double.infinity,
                    shouldUseLoadedData: true,
                    radius: 16,
                    height: 72,
                    errorColor: PColors.primary.withValues(alpha: 0.4),
                    callBack: () =>
                        getIt<AppRouter>().router.goNamed(KRoutes.practiceExam),
                    loadedWidget: const QuickStartWidget(
                        bgColor: PColors.primary5,
                        text: 'Start full mock exam',
                        subtitle:
                            'Take a timed, WAEC-style mock to test your stamina and track your score across subjects.',
                        buttonText: 'Start mock',
                        icon: Iconsax.note_2)),
                ThreeToOneShimmer(
                    isLoading: isLoading,
                    hasData: hasData,
                    hasError: hasError,
                    width: double.infinity,
                    shouldUseLoadedData: true,
                    radius: 16,
                    height: 72,
                    errorColor: PColors.tertiary.withValues(alpha: 0.5),
                    callBack: () =>
                        getIt<AppRouter>().router.goNamed(KRoutes.practiceExam),
                    loadedWidget: const QuickStartWidget(
                        bgColor: PColors.bg2,
                        text: 'Quick 10-Q/A drill',
                        subtitle:
                            'Short, focused drills to target weak topics — perfect for study breaks and fast progress.',
                        buttonText: 'Start drill',
                        icon: Iconsax.flash)),
                ThreeToOneShimmer(
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
                        subtitle:
                            'Choose subjects, topics, and number of questions to create a set that matches your study needs.',
                        buttonText: 'Create test',
                        icon: Icons.arrow_drop_down_rounded))
              ],
            ),
            Column(
              spacing: 12,
              children: [
                ThreeToOneShimmer(
                    isLoading: isLoading,
                    hasError: hasError,
                    hasData: hasData,
                    shimmerColor: PColors.white,
                    radius: 12,
                    height: 128,
                    width: 178,
                    errorColor: PColors.bg4.withValues(alpha: 0.3),
                    errorText: 'Data unavailable, Please check your connection',
                    loadedWidget: const FireStreakWidgetOptimized()),
                ThreeToOneShimmer(
                    isLoading: isLoading,
                    hasError: hasError,
                    hasData: hasData,
                    shimmerColor: PColors.white,
                    radius: 12,
                    height: 128,
                    width: 178,
                    errorColor: PColors.bg4.withValues(alpha: 0.3),
                    errorText: 'Data unavailable, Please check your connection',
                    loadedWidget: ScoreGaugeWidget(
                      isExpanded: expand,
                    )),
                ThreeToOneShimmer(
                    isLoading: isLoading,
                    hasError: hasError,
                    hasData: hasData,
                    shimmerColor: PColors.white,
                    radius: 12,
                    height: 128,
                    errorColor: PColors.bg4.withValues(alpha: 0.3),
                    errorText: 'Data unavailable, Please check your connection',
                    width: 178,
                    loadedWidget: TestTracker(
                      isExpanded: expand,
                    )),
              ],
            ),
            // SECTION THREE
            const TRoundedContainer(
              padding: EdgeInsets.all(12),
              height: 336,
              backgroundColor: PColors.light,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 12,
                children: [DaysActiveWidget()],
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
                    loadedWidget: const AiInsightWidget()),
            LeaderBoardWidget(expand: expand)
          ],
        ),
      ),
    );
  }
}
