import 'package:ahiaa_web/core/routes/routes.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'package:get/get_navigation/get_navigation.dart';

class KRoutesMiddleWare extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // return AuthenticationRepository.instance.isAuthenticated
    //     ? null
    //     : 
        const RouteSettings(name: KRoutes.login);
        return null;
  }
}
