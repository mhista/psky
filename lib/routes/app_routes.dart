import 'package:ahiaa_web/common/layout/templates/app_layout.dart';
import 'package:ahiaa_web/features/media/screens/media.dart';
import 'package:ahiaa_web/features/shop/screens/dashboard/responsive_screens/desktop/desktop.dart';
import 'package:ahiaa_web/features/shop/screens/dashboard/responsive_screens/mobile/mobile.dart';
import 'package:ahiaa_web/features/shop/screens/dashboard/responsive_screens/tablet/tablet.dart';
import 'package:ahiaa_web/features/authentication/screens/forget_password/forget_password.dart';
import 'package:ahiaa_web/features/authentication/screens/reset_password/reset_password.dart';
import 'package:ahiaa_web/responsive.dart';
import 'package:ahiaa_web/routes/routes.dart';
import 'package:ahiaa_web/routes/routes_middleware.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../features/authentication/screens/login/login.dart';

class AppRoutes {
  static final pages = [
    GetPage(
        name: KRoutes.home,
        page: () => const SiteTemplate(
              desktop: DesktopScreen(),
              tablet: TabletScreen(),
              mobile: MobileScreen(),
            ),
        middlewares: [KRoutesMiddleWare()]),
    GetPage(
      name: KRoutes.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: KRoutes.resetPassword,
      page: () => const ResetPassword(),
    ),
    GetPage(
      name: KRoutes.forgetPassword,
      page: () => const ForgetPasword(),
    ),
    // MEDIA SCREEN
    GetPage(
        name: KRoutes.media,
        page: () => const MediaScreen(),
        middlewares: [KRoutesMiddleWare()]),
  ];
}
