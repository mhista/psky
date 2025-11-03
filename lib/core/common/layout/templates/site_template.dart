import 'package:ahiaa_web/core/common/layout/screen_layouts/desktop/desktop_layout2.dart';
import 'package:ahiaa_web/core/common/layout/screen_layouts/mobile/mobile_layout2.dart';
import 'package:ahiaa_web/core/common/layout/screen_layouts/tablet/tablet_layout2.dart';
import 'package:ahiaa_web/core/common/layout/templates/responsive_widget.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter/material.dart';



class SiteTemplate2 extends StatelessWidget {
  const SiteTemplate2(
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
          ? DesktopLayout2(
              body: desktop,
            )
          : desktop ?? const TRoundedContainer(),
      tablet: useLayout
          ? TabletLayout2(
              body: tablet ?? desktop,
            )
          : tablet ?? desktop ?? const TRoundedContainer(),
      mobile: useLayout
          ? MobileLayout2(
              body: mobile ?? desktop,
            )
          : mobile ?? desktop ?? const TRoundedContainer(),
    ));
  }
}
