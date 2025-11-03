import 'package:ahiaa_web/core/common/layout/screen_layouts/desktop/desktop_layout.dart';
import 'package:ahiaa_web/core/common/layout/screen_layouts/mobile/mobile_layout.dart';
import 'package:ahiaa_web/core/common/layout/screen_layouts/tablet/tablet_layout.dart';
import 'package:ahiaa_web/core/common/layout/templates/responsive_widget.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter/material.dart';



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
