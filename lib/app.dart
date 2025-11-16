import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/routes/app_router2.dart';
import 'package:ahiaa_web/core/routes/app_routes.dart';
import 'package:ahiaa_web/core/routes/routes.dart';
import 'package:ahiaa_web/core/utils/constants/text_strings.dart';
import 'package:ahiaa_web/core/utils/theme/theme.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';



class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadcnApp.router(
      
      materialTheme: TAppTheme.lightTheme,
      title: PTexts.appName,
      darkTheme: ThemeData(
          radius: 1, colorScheme: ColorSchemes.defaultcolor(ThemeMode.light)),

      theme: ThemeData(
          radius: 1, colorScheme: ColorSchemes.defaultcolor(ThemeMode.light)),
      themeMode: ThemeMode.light,

      routerConfig: getIt<AppRouter>().router,
      builder: (context, child) =>
          ResponsiveBreakpoints.builder(child: child!, breakpoints: [
        const Breakpoint(start: 0, end: 767, name: MOBILE),
        const Breakpoint(start: 768, end: 1024, name: TABLET),
        const Breakpoint(start: 1025, end: double.infinity, name: DESKTOP),
      ]),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FlutterQuillLocalizations.delegate,
      ],
    
    );
  }
}
