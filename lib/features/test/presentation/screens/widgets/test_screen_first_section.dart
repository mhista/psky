
import 'package:ahiaa_web/core/common/carousel/vertical_carousel.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/shimmer/three_to_one_shimmer.dart';
import 'package:ahiaa_web/features/dashboard/presentation/screens/widgets/quick_start_widget.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class TestScreenFirstSection extends StatelessWidget {
  const TestScreenFirstSection({
    super.key,
    required this.isLoading,
    required this.hasData,
    required this.hasError,
  });

  final bool isLoading;
  final bool hasData;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: 24,
      children: [
        Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // if (hasError || hasData)
            TRoundedContainer(
              width: 250,
              padding: const EdgeInsets.all(0),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('My Tests!').x4Large.black,
                  const Text(
                          'Track, resume, and review all your practice tests')
                      .black
                      .withOpacity(0.5)
                ],
              ),
            )
          ],
        ),
        Expanded(
          child: CustomCarouselSlider(
            viewportFractionDesktop: 0.5,
            height: 185,
            autoPlay: false,
            sliderWidthDesktop: 50,
            items: [
              ThreeToOneShimmer(
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
                      subtitle:
                          'Take a timed, WAEC-style mock to test your stamina and track your score across subjects.',
                      isAlreadyExpanded: true,
                      addEndSpacing: true,
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
                  loadedWidget: const QuickStartWidget(
                      bgColor: PColors.bg2,
                      text: 'Quick 10-Q/A drill',
                      subtitle:
                          'Short, focused drills to target weak topics — perfect for study breaks and fast progress.',
                      buttonText: 'Start drill',
                      isAlreadyExpanded: true,
                      addEndSpacing: true,
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
                      isAlreadyExpanded: true,
                      addEndSpacing: true,
                      icon: Icons.arrow_drop_down_rounded))
            ],
          ),
        ),
      ],
    );
  }
}