import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/shimmer/three_to_one_shimmer.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/routes/app_router2.dart';
import 'package:ahiaa_web/core/routes/routes.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/features/dashboard/presentation/screens/widgets/new.dart';
import 'package:ahiaa_web/features/dashboard/presentation/screens/widgets/quick_start_widget.dart';
import 'package:ahiaa_web/features/test/presentation/screens/widgets/test_screen_first_section.dart';
import 'package:ahiaa_web/features/test/presentation/screens/widgets/test_screen_second_section.dart';
import 'package:ahiaa_web/features/test/presentation/screens/widgets/test_screen_third_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' hide TextButton;

class MobileTestScreen extends StatelessWidget {
  const MobileTestScreen(
      {super.key,
      this.isLoading = false,
      this.hasError = false,
      this.expand = false,
      this.isFirstTime = false,
      this.hasData = true});
  final bool isLoading, hasError, hasData, expand, isFirstTime;
  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        const ResponsiveText('My Tests')
                            .xLarge
                            .black
                            .animate()
                            .fadeIn(duration: 1000.ms),
                        const ResponsiveText(
                                'Track, resume, and review all your practice tests')
                            .xLarge
                            .black
                            .withOpacity(0.5)
                            .animate(delay: 500.ms)
                            .fadeIn(duration: 800.ms)
                      ],
                    ),
                  ),
                 const Gap(15)
              ],
            ),
            // FIRST SECTION
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
            // SECOND SECTION
            TestScreenSecondSection(
                isLoading: isLoading,
                hasData: hasData,
                hasError: hasError,
                isFirstTime: isFirstTime),
            TestScreenThirdSection(
                isLoading: isLoading,
                hasData: hasData,
                hasError: hasError,
                isFirstTime: isFirstTime)
          ],
        ),
      ),
    );
  }
}
