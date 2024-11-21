import 'package:ahiaa_web/common/layout/templates/app_layout.dart';
import 'package:ahiaa_web/features/authentication/screens/reset_password/responsive/reset_password_desktop_tablet.dart';
import 'package:ahiaa_web/features/authentication/screens/reset_password/responsive/reset_password_mobile.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplate(
      useLayout: false,
      desktop: ResetPasswordDesktopTablet(),
      mobile: ResetPasswordMobile(),
    );
  }
}
