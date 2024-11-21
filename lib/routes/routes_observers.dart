import 'package:ahiaa_web/routes/routes.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'package:get/get.dart';

import '../common/layout/sidebars/sidebar_controller.dart';

class RoutesObservers extends GetObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    final sidebarController = Get.put(SideBarController());
    if (previousRoute != null) {
      // check the route name and update the active item in the sidebar accordingly
      for (var routeName in KRoutes.sidebarMenuItems) {
        if (previousRoute.settings.name == routeName) {
          sidebarController.activeItem.value = routeName;
        }
      }
    }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    final sidebarController = Get.put(SideBarController());
    if (route != null) {
      // check the route name and update the active item in the sidebar accordingly
      for (var routeName in KRoutes.sidebarMenuItems) {
        if (route.settings.name == routeName) {
          sidebarController.activeItem.value = routeName;
        }
      }
    }
  }
}
