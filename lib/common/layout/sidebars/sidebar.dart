import 'package:ahiaa_web/common/widgets/images/circular_images.dart';
import 'package:ahiaa_web/utils/constants/colors.dart';
import 'package:ahiaa_web/utils/constants/image_strings.dart';
import 'package:ahiaa_web/utils/device/device_utility.dart';
import 'package:ahiaa_web/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../routes/routes.dart';
import '../../../utils/constants/sizes.dart';
import 'menu/menu_item.dart';

class TSidebar extends StatelessWidget {
  const TSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunctions.isDarkMode(context);
    return Drawer(
      shape: const BeveledRectangleBorder(),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? PColors.black : PColors.white,
          border: const Border(
            right: BorderSide(color: PColors.grey),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const PCircularImage(
                width: 100,
                height: 100,
                image: PImages.appLogo,
                backgroundColor: PColors.transparent,
              ),
              const SizedBox(height: PSizes.spaceBtwSections),
              Padding(
                padding: const EdgeInsets.all(PSizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'MENU',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .apply(letterSpacingDelta: 1.2),
                    ),

                    // MAIN ITEMS
                    const PMenuItem(
                      title: 'Dashboard',
                      route: KRoutes.home,
                      icon: Iconsax.status,
                    ),
                    const PMenuItem(
                      title: 'Media',
                      route: KRoutes.media,
                      icon: Iconsax.image,
                    ),
                    const PMenuItem(
                      title: 'Banners',
                      route: KRoutes.banners,
                      icon: Iconsax.picture_frame,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
