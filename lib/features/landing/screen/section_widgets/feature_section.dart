import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/features/landing/screen/widgets/actionable_widget.dart';
import 'package:ahiaa_web/features/landing/screen/widgets/performance_widget.dart';
import 'package:ahiaa_web/features/landing/screen/widgets/section_header.dart';
import 'package:ahiaa_web/features/landing/screen/widgets/section_shimmer_container.dart';
import 'package:ahiaa_web/features/landing/screen/widgets/sub_header.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

Widget buildFeaturesSection() {
 
    return const FeaturesSection();
  }

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
     final responsive = ResponsiveBreakpoints.of(context);
    final isMobile = responsive.isMobile;
    return RepaintBoundary(
      child: Column(
        spacing: 32,
        children: [
          const SectionHeader(
              subtitle:
                  'Practice timed, exam-styled questions and get instant scoring so you know exactly what to improve',
              title: 'Built For WAEC Success'),
          TRoundedContainer(
            padding: const EdgeInsets.all(0),
            width:isMobile? 313: 1152,
            height:isMobile? 313: 400,
            backgroundColor: PColors.primary.withValues(alpha: 0.38),
            child:!isMobile? const Row(
              children: [
                SubHeader(
                    title: 'Real WAEC-style tests',
                    subTitle:
                        'Take full-length, timed mock exams that match WAEC formatting and time limits',
                    color: PColors.primary),
                Expanded(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                          top: 113,
                          right: 24,
                          child: SectionShimmerContainer(
                              title: 'Mathematics',
                              subtitle: '58:09',
                              height: 265,
                              width: 336,
                              color: PColors.bg3)),
                      Positioned(
                          top: 82,
                          right: 240,
                          child: SectionShimmerContainer(
                              title: 'Mathematics',
                              subtitle: '58:09',
                              height: 265,
                              width: 336,
                              color: PColors.bg2)),
                      Positioned(
                          top: 50,
                          left: 58,
                          child: SectionShimmerContainer(
                              title: 'Mathematics',
                              subtitle: '58:09',
                              height: 265,
                              width: 336,
                              color: PColors.primary)),
                    ],
                  ),
                )
              ],
            ): Column(
              children: [
                const SubHeader(
                    title: 'Real WAEC-style tests',
                    subTitle:
                        'Take full-length, timed mock exams that match WAEC formatting and time limits',
                    color: PColors.primary),
                Expanded(
                  child: Stack(
                    // clipBehavior: Clip.none,
                    children: [
                      Positioned(
                          top: 20,
                          left: 14,
                          child: SectionShimmerContainer(
                              title: 'Mathematics',
                              subtitle: '58:09',
                              height: 265,
                              width:isMobile? 285: 336,
                              color: PColors.bg3)),
                      Positioned(
                          top: 40,
                          left: 14,
                          child: SectionShimmerContainer(
                              title: 'Mathematics',
                              subtitle: '58:09',
                              height: 265,
                              width:isMobile? 285: 336,
                              color: PColors.bg2)),
                      Positioned(
                          top: 60,
                          left: 14,
                          child: SectionShimmerContainer(
                              title: 'Mathematics',
                              subtitle: '58:09',
                              height: 265,
                              width:isMobile? 285: 336,
                              color: PColors.primary)),
                    ],
                  ),
                )
              ],
            ) ,
          ),
           Wrap(
            spacing: 27,
            direction: isMobile? Axis.vertical: Axis.horizontal,
            children: const [
              ActionableWidget(),
              ProgressWidget(),
            ],
          )
        ],
      ),
    );
  }
}