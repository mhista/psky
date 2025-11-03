import 'package:ahiaa_web/features/landing/screen/section_widgets/cta_section.dart';
import 'package:ahiaa_web/features/landing/screen/section_widgets/feature_section.dart';
import 'package:ahiaa_web/features/landing/screen/section_widgets/hero_section.dart';
import 'package:ahiaa_web/features/landing/screen/section_widgets/testimonial_section.dart';
import 'package:ahiaa_web/features/landing/screen/section_widgets/why_choose_us.dart';
import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
  

class DesktopLandingPage extends StatefulWidget {
  const DesktopLandingPage({super.key});

  @override
  State<DesktopLandingPage> createState() => _DesktopLandingPageState();
}

class _DesktopLandingPageState extends State<DesktopLandingPage>
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
          spacing: 100,
          children: [
            
          const  BuildHeroSection(),
            buildFeaturesSection(),
            buildWhyChooseUsSection(),
            buildTestimonialsSection(),
            const Gap(50),
           const CTASection(),
          ],
        ),
      ),
    );
  }

 

 


  

  


  

 
}
