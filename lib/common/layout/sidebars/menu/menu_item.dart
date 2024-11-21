import 'package:ahiaa_web/common/layout/sidebars/sidebar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/sizes.dart';

class PMenuItem extends StatelessWidget {
  const PMenuItem({
    super.key,
    required this.title,
    required this.route,
    required this.icon,
  });

  final String title, route;
  final IconData icon;
  // final Function() onTap;
  @override
  Widget build(BuildContext context) {
    final menuController = Get.put(SideBarController());
    return InkWell(
      onTap: () => menuController.menuOnTap(route),
      onHover: (hovering) => hovering
          ? menuController.changeHoverItem(route)
          : menuController.changeHoverItem(''),
      child: Obx(() {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: PSizes.sm),
          child: Container(
              decoration: BoxDecoration(
                  color: menuController.isHovering(route) ||
                          menuController.isActive(route)
                      ? PColors.primary
                      : PColors.transparent,
                  borderRadius: BorderRadius.circular(PSizes.cardRadiusMd)),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: PSizes.lg,
                      right: PSizes.md,
                      top: PSizes.md,
                      bottom: PSizes.md),
                  child: menuController.isActive(route)
                      ? Icon(
                          icon,
                          size: 22,
                          color: PColors.white,
                        )
                      : Icon(
                          icon,
                          size: 22,
                          color: menuController.isHovering(route)
                              ? PColors.white
                              : PColors.darkGrey,
                        ),
                ),

                // text
                if (menuController.isHovering(route) ||
                    menuController.isActive(route))
                  Flexible(
                    child: Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: PColors.white),
                    ),
                  )
                else
                  Flexible(
                    child: Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: PColors.darkGrey),
                    ),
                  )
              ])),
        );
      }),
    );
  }
}
