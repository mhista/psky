import 'package:ahiaa_web/core/common/layout/templates/app_layout.dart';
import 'package:ahiaa_web/core/common/layout/templates/site_template.dart';
import 'package:ahiaa_web/features/dashboard/presentation/screens/desktop/dashboard_desktop.dart';
import 'package:ahiaa_web/features/onboarding/presentation/screens/desktop/desktop_screen.dart';
import 'package:ahiaa_web/features/test/presentation/screens/desktop/desktop_test_screen.dart';
import 'package:flutter/material.dart';

class TestScreenScreen extends StatelessWidget {
  const TestScreenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplate2(
        useLayout: true, desktop: DesktopTestScreen(), );
  }
}
