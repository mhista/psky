import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../routes/routes.dart';

class SideBarController extends GetxController {
  final activeItem = KRoutes.home.obs;
  final hoverItem = ''.obs;

  void changeActiveItem(String route) => activeItem.value = route;
  void changeHoverItem(String route) {
    if (!isActive(route)) {
      hoverItem.value = route;
    }
  }

  bool isActive(String route) => activeItem.value == route;
  bool isHovering(String route) => hoverItem.value == route;

  // change active menu item on tap
  void menuOnTap(String route) {
    if (isActive(route)) return;
    changeActiveItem(route);

    // close drawer on mobile screen
    if (ResponsiveBreakpoints.of(Get.context!).isMobile) Get.back();

    // move to the next screen
    Get.toNamed(route);
  }
}
