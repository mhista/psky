import 'package:ahiaa_web/bindings/general_bindings.dart';
import 'package:ahiaa_web/common/layout/templates/app_layout.dart';
import 'package:ahiaa_web/routes/app_routes.dart';
import 'package:ahiaa_web/routes/routes.dart';
import 'package:ahiaa_web/utils/constants/text_strings.dart';
import 'package:ahiaa_web/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: PTexts.appName,
      themeMode: ThemeMode.light,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialBinding: GeneralBindiings(),
      getPages: AppRoutes.pages,
      initialRoute: KRoutes.home,
      builder: (context, child) =>
          ResponsiveBreakpoints.builder(child: child!, breakpoints: [
        const Breakpoint(start: 0, end: 767, name: MOBILE),
        const Breakpoint(start: 768, end: 1365, name: TABLET),
        const Breakpoint(start: 1366, end: double.infinity, name: DESKTOP),
      ]),
      unknownRoute: GetPage(
          name: '/page-not-found',
          page: () =>
              const Scaffold(body: Center(child: Text('PAGE NOT FOUND')))),
    );
  }
}
