import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget(
      {super.key,
      required this.desktop,
      required this.tablet,
      required this.mobile});
  final Widget desktop, tablet, mobile;
  @override
  Widget build(BuildContext context) {
    @override
    final responsive = ResponsiveBreakpoints.of(context);
    if (responsive.isTablet) {
      return tablet;
    } else if (responsive.isDesktop) {
      return desktop;
    } else {
      return mobile;
    }
  }
}
