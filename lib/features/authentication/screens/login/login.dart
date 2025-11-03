import 'package:ahiaa_web/core/common/layout/templates/app_layout.dart';
import 'package:ahiaa_web/features/authentication/screens/login/responsive_screens/login_desktop_tablet.dart';
import 'package:ahiaa_web/features/authentication/screens/login/responsive_screens/login_mobile.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplate(
      useLayout: false,
      desktop: LoginDesktopTabletScreen(),
      mobile: LoginMobileScreen(),
    );
    // return const Scaffold(
    // body:
    // );
  }
}
