
  import 'package:ahiaa_web/features/landing/screen/widgets/choose_us.dart';
import 'package:ahiaa_web/features/landing/screen/widgets/section_header.dart';
import 'package:ahiaa_web/core/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

Widget buildWhyChooseUsSection() {
  
    return  const WhyChooseUsSection();
  }

class WhyChooseUsSection extends StatelessWidget {
  const WhyChooseUsSection({
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
                  'Exam-first approach, fast delivery - practice that maps directly to what WAEC expects',
              title: 'Why Choose Us?'),
          Wrap(
            direction:isMobile?Axis.vertical:Axis.horizontal
             ,
            spacing: 24,
            children: const [
              ChooseUsWidget(
                  image: PImages.vector,
                  title: 'WAEC-aligned content',
                  subtitle:
                      'Practice questions mirror real WAEC format, timing, and scoring for exam-ready confidence'),
              ChooseUsWidget(
                  image: PImages.icon,
                  title: 'Optimised for mobile',
                  subtitle:
                      'Lightweight, fast, and reliable on everyday Android devices, even with low data'),
              ChooseUsWidget(
                  image: PImages.ai,
                  title: 'Smarter with AI',
                  subtitle:
                      'Get personalized explanations and tailored insights for question.'),
              ChooseUsWidget(
                  image: PImages.ring,
                  title: 'Built for consistency',
                  subtitle:
                      'A clean, distraction-free interface keeps focus on learning, not clutter'),
            ],
          )
        ],
      ),
    );
  }
}