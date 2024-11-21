import 'package:ahiaa_web/features/shop/screens/responsive_widget.dart';
import 'package:ahiaa_web/features/shop/screens/dashboard/responsive_screens/desktop/desktop.dart';
import 'package:ahiaa_web/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../features/shop/screens/dashboard/responsive_screens/desktop/desktop_layout.dart';
import '../../../features/shop/screens/dashboard/responsive_screens/mobile/mobile_layout.dart';
import '../../../features/shop/screens/dashboard/responsive_screens/tablet/tablet_layout.dart';

class SiteTemplate extends StatelessWidget {
  const SiteTemplate(
      {super.key,
      this.useLayout = true,
      this.desktop,
      this.tablet,
      this.mobile});
  final Widget? desktop, tablet, mobile;

  final bool useLayout;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ResponsiveWidget(
      desktop: useLayout
          ? DesktopLayout(
              body: desktop,
            )
          : desktop ?? const TRoundedContainer(),
      tablet: useLayout
          ? TabletLayout(
              body: tablet ?? desktop,
            )
          : tablet ?? desktop ?? const TRoundedContainer(),
      mobile: useLayout
          ? MobileLayout(
              body: mobile ?? desktop,
            )
          : mobile ?? desktop ?? const TRoundedContainer(),
    ));
  }
}
