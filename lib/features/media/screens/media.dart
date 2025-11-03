import 'package:ahiaa_web/core/common/layout/templates/app_layout.dart';
import 'package:ahiaa_web/features/media/screens/responsive_screens/desktop_media.dart';
import 'package:flutter/material.dart';

class MediaScreen extends StatelessWidget {
  const MediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplate(
      desktop: MediaDesktopScreen(),
    );
  }
}
