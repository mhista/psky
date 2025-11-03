import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

import 'package:ahiaa_web/features/landing/screen/section_widgets/cta_section.dart';
import 'package:ahiaa_web/features/landing/screen/section_widgets/feature_section.dart';
import 'package:ahiaa_web/features/landing/screen/section_widgets/hero_section.dart';
import 'package:ahiaa_web/features/landing/screen/section_widgets/testimonial_section.dart';
import 'package:ahiaa_web/features/landing/screen/section_widgets/why_choose_us.dart';

import 'package:gap/gap.dart';

class MobileLandingPage extends StatefulWidget {
  const MobileLandingPage({super.key});

  @override
  State<MobileLandingPage> createState() => _MobileLandingPageState();
}

class _MobileLandingPageState extends State<MobileLandingPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin

    return SingleChildScrollView(
      // Add physics for better scroll performance
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          // spacing: 48,
          children: [
          const  BuildHeroSection(),
            const Gap(48),

            buildFeaturesSection(),
            const Gap(48),

            buildWhyChooseUsSection(),
            const Gap(48),

            buildTestimonialsSection(),
            const Gap(48),
           const CTASection(),
            const Gap(20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal:33.0),
              child: Column(
                spacing: 10,
                    children: [
                      
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        spacing: 11,
                        children: [
                          Text('Instagram',
                              style: TextStyle(color: PColors.deepBlack, fontSize: 12)),
                          Text('Facebook',
                              style: TextStyle(color: PColors.deepBlack, fontSize: 12)),
                          Text('Twitter',
                              style: TextStyle(color: PColors.deepBlack, fontSize: 12)),
                        ],
                        
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:8.0),
                        child: Text(
                            '© ${DateTime.now().year} PSKY Business School. All Rights Reserved.',
                            style: const TextStyle(color: PColors.deepBlack, fontSize: 12)),
                      ),
                    ]),
            ),
            const Gap(20),


          ],
        ),
      ),
    );
  }
    }