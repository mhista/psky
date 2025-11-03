import 'package:ahiaa_web/core/common/layout/templates/site_template.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/screens/desktop/practice_screen.dart';
import 'package:flutter/material.dart';

class PracticeScreen extends StatelessWidget {
  const PracticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplate2(
        useLayout: true, desktop: DesktopPracticeScreen(), );
  }
}
