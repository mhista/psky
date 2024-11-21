import 'package:ahiaa_web/common/widgets/images/edge_rounded_images.dart';
import 'package:ahiaa_web/data/repositories/auth_repo/authentication_repository.dart';
import 'package:ahiaa_web/features/personalization/controllers/user_controller.dart';
import 'package:ahiaa_web/utils/constants/colors.dart';
import 'package:ahiaa_web/utils/constants/image_strings.dart';
import 'package:ahiaa_web/utils/constants/sizes.dart';
import 'package:ahiaa_web/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../utils/constants/enums.dart';

// header widget for the project
class THeader extends StatelessWidget implements PreferredSizeWidget {
  const THeader({super.key, this.scaffoldKey});

  // GlobalKey to access the scaffold state
  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);
    final user = UserController.instance;
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: PSizes.sm, horizontal: PSizes.md),
      decoration: const BoxDecoration(
          color: PColors.white,
          border: Border(bottom: BorderSide(width: 1, color: PColors.grey))),
      child: AppBar(
        leading: !responsive.isDesktop
            ? IconButton(
                onPressed: () => scaffoldKey?.currentState?.openDrawer(),
                icon: const Icon(Iconsax.menu))
            : null,
        title: responsive.isDesktop
            ? SizedBox(
                width: 400,
                child: TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.search_normal),
                    hintText: 'Search anything',
                  ),
                ),
              )
            : null,
        actions: [
          if (!responsive.isDesktop)
            IconButton(
              onPressed: () {},
              icon: const Icon(Iconsax.search_normal),
            ),
          IconButton(
            onPressed: () => AuthenticationRepository.instance.logout(),
            icon: const Icon(Iconsax.notification),
          ),
          const SizedBox(
            width: PSizes.spaceBtwItems / 2,
          ),
          Row(
            children: [
              Obx(() {
                return PRoundedImage(
                  width: 40,
                  height: 40,
                  padding: 2,
                  imageType: ImageType.network,
                  image: user.user.value.profilePicture,
                );
              }),
              const SizedBox(
                width: PSizes.sm,
              ),

              // Name and Email
              if (!responsive.isMobile)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      return Text(
                        user.user.value.fullName,
                        style: Theme.of(context).textTheme.titleLarge,
                      );
                    }),
                    Obx(() {
                      return Text(
                        user.user.value.email,
                        style: Theme.of(context).textTheme.labelMedium,
                      );
                    })
                  ],
                )
            ],
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(PDeviceUtils.getAppBarHeight() + 15);
}
