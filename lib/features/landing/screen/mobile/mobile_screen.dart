import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/features/landing/cubit/scroll_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    return SingleChildScrollView(
      // Add physics for better scroll performance
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            // Wrap each section with a Container that has the key
            Container(key: heroKey, child: const BuildHeroSection()),
            const Gap(48),

            Container(key: featuresKey, child: buildFeaturesSection()),
            const Gap(48),

            Container(key: whyChooseUsKey, child: buildWhyChooseUsSection()),
            const Gap(48),

            Container(key: testimonialsKey, child: buildTestimonialsSection()),
            const Gap(48),

            Container(key: ctaKey, child: const CTASection()),
            const Gap(20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 33.0),
              child: Column(
                children: [
                  const Gap(10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Instagram',
                          style: TextStyle(
                              color: PColors.deepBlack, fontSize: 12)),
                      Text('Facebook',
                          style: TextStyle(
                              color: PColors.deepBlack, fontSize: 12)),
                      Text('Twitter',
                          style: TextStyle(
                              color: PColors.deepBlack, fontSize: 12)),
                    ],
                  ),
                  const Gap(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                        '© ${DateTime.now().year} PSKY Business School. All Rights Reserved.',
                        style: const TextStyle(
                            color: PColors.deepBlack, fontSize: 12)),
                  ),
                ],
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
