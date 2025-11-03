import 'package:flutter/material.dart';

import 'package:ahiaa_web/core/common/layout/templates/site_template.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/screens/desktop/screens/main_exam_page.dart';

class MainExamScreen extends StatelessWidget {
  const MainExamScreen({
    super.key,
    this.isLoading = false,
    this.hasError = false,
    this.expand = false,
    this.isFirstTime = true,
    this.hasData = false,
  });

  final bool isLoading, hasError, hasData, expand, isFirstTime;

  @override
  Widget build(BuildContext context) {
    return const SiteTemplate2(
      useLayout: true,
      desktop: MainExamScreenDesktop(),
    );
  }
}


