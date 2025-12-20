// features/landing/screen/desktop/desktop_landing_page.dart
import 'package:ahiaa_web/features/landing/cubit/scroll_cubit.dart';
import 'package:ahiaa_web/features/landing/screen/section_widgets/cta_section.dart';
import 'package:ahiaa_web/features/landing/screen/section_widgets/feature_section.dart';
import 'package:ahiaa_web/features/landing/screen/section_widgets/hero_section.dart';
import 'package:ahiaa_web/features/landing/screen/section_widgets/testimonial_section.dart';
import 'package:ahiaa_web/features/landing/screen/section_widgets/why_choose_us.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  // Create GlobalKeys for each section
  final GlobalKey heroKey = GlobalKey();
  final GlobalKey featuresKey = GlobalKey();
  final GlobalKey whyChooseUsKey = GlobalKey();
  final GlobalKey testimonialsKey = GlobalKey();
  final GlobalKey ctaKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // Register sections after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final scrollCubit = context.read<ScrollCubit>();
      scrollCubit.registerSection('home', heroKey);
      scrollCubit.registerSection('features', featuresKey);
      scrollCubit.registerSection('why-us', whyChooseUsKey);
      scrollCubit.registerSection('testimonials', testimonialsKey);
      scrollCubit.registerSection('contact', ctaKey);
    });
  }

  @override
  void dispose() {
    // Unregister sections on disposal
    final scrollCubit = context.read<ScrollCubit>();
    scrollCubit.unregisterSection('home');
    scrollCubit.unregisterSection('features');
    scrollCubit.unregisterSection('why-us');
    scrollCubit.unregisterSection('testimonials');
    scrollCubit.unregisterSection('contact');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            // Wrap each section with a Container/SizedBox that has the key
            Container(key: heroKey, child: const BuildHeroSection()),
            const Gap(100),
            
            Container(key: featuresKey, child: buildFeaturesSection()),
            const Gap(100),
            
            Container(key: whyChooseUsKey, child: buildWhyChooseUsSection()),
            const Gap(100),
            
            Container(key: testimonialsKey, child: buildTestimonialsSection()),
            const Gap(150),
            
            Container(key: ctaKey, child: const CTASection()),
          ],
        ),
      ),
    );
  }
}