import 'package:ahiaa_web/core/common/layout/templates/app_layout.dart';
import 'package:ahiaa_web/features/authentication/presentation/auth_screens/desktop/auth_desktop.dart';
import 'package:ahiaa_web/features/authentication/presentation/auth_screens/mobile/auth_mobile.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplate(
      useLayout: false,
      desktop: AuthDesktop(),
      tablet: AuthMobile(),
      mobile: AuthMobile(),
    );
  }
}

//  flutter build web --release --no-tree-shake-icons firebase deploy --only hosting
