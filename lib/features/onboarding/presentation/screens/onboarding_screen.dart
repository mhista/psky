import 'package:ahiaa_web/core/common/layout/templates/app_layout.dart';
import 'package:ahiaa_web/features/onboarding/presentation/screens/desktop/desktop_screen.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplate(
        useLayout: false, desktop: OnboardingDesktopScreen());
  }
}
