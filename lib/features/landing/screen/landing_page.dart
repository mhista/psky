import 'package:ahiaa_web/core/common/layout/screen_layouts/desktop/desktop_layout.dart';
import 'package:ahiaa_web/core/common/layout/screen_layouts/desktop/desktop_layout2.dart';
import 'package:ahiaa_web/core/common/layout/templates/app_layout.dart';
import 'package:ahiaa_web/features/landing/screen/desktop/desktop_landing_page.dart';
import 'package:ahiaa_web/features/landing/screen/mobile/mobile_screen.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  const SiteTemplate(
      useLayout: true,
      desktop: DesktopLandingPage(),
      mobile:  MobileLandingPage(),
      tablet: DesktopLandingPage(),
    );
  }
}
