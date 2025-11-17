import 'package:ahiaa_web/core/common/custom_dropdown/custom_dropdown2.dart';
import 'package:ahiaa_web/core/common/custom_dropdown/dropdown_feeds_item.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ahiaa_web/core/common/widgets/icons/circular_icon.dart';
import 'package:ahiaa_web/core/common/widgets/images/edge_rounded_images.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/routes/app_router2.dart';
import 'package:ahiaa_web/core/routes/routes.dart';
import 'package:ahiaa_web/features/authentication/domain/entities/user.dart';
import 'package:ahiaa_web/features/authentication/presentation/business/cubit/auth_cubit.dart';
import 'package:ahiaa_web/features/personalization/presentation/cubit/cubit/user_cubit.dart';
import 'package:ahiaa_web/features/personalization/presentation/screens/widgets/user_avater.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/utils/enums/enums.dart';
import 'package:ahiaa_web/core/utils/constants/image_strings.dart';
import 'package:ahiaa_web/core/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart'
    hide ScaffoldState, IconButton;

class KHeader2 extends StatelessWidget implements PreferredSizeWidget {
  KHeader2({super.key, this.scaffoldKey});
  // leading: !responsive.isDesktop
  //           ? IconButton(
  //               onPressed: () => scaffoldKey?.currentState?.openDrawer(),
  //               icon: const Icon(Iconsax.menu))
  //           : null,

  // Globalkey to access the scaffold state
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final dropDownKey3 = GlobalKey<CustomDropdownMenuState>();

  @override
  Widget build(BuildContext context) {
    final appRouter = getIt<AppRouter>();
    final user = getIt<UserCubit>().user?? UserEntity.empty();
    final filterItems = [
      DropdownFeedsItem(
        alignRight: true,
        label: user.email,
        onTap: () {},
        userCustomWidget: true,
        customWidget: Row(
          spacing: 16,
          children: [
            Column(

              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ResponsiveText(
                  user.fullName.capitalizeFirst ?? '',
                  maxLines: 2,
                  softWrap: true,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: PColors.dark,
                    fontSize: 12,
                  ),
                ),
                ResponsiveText(
                  user.email,
                  maxLines: 2,
                  softWrap: true,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: PColors.dark,
                    fontSize: 8,
                  ),
                )
              ],
            ),
            const UserAvater(
              size: 30,
              useAddButton: false,
              isExtended: false,
            ),
          ],
        ),
        textSize: 8,
      ),
       DropdownFeedsItem(
        alignRight: true,
        label: 'Help',
        onTap: () {
          dropDownKey3.currentState?.hide();
        },
        textSize: 10,
        useIcon: true,
        iconWidget: const Icon(Icons.help_outline, color: PColors.black,),
      ),
      DropdownFeedsItem(
        alignRight: true,
        label: 'Logout',
        onTap: () {
          dropDownKey3.currentState?.hide();
          getIt<AuthCubit>().logout();
        },
        textSize: 10,
        useIcon: true,
        iconWidget: const Icon(Icons.logout, color: PColors.bg2,),
      ),
     
    ];

    final responsive = ResponsiveBreakpoints.of(context);
    return Container(
      color: responsive.isMobile ? PColors.light : PColors.white,
      margin: responsive.isDesktop
          ? const EdgeInsets.only(bottom: 12)
          : const EdgeInsets.all(0),
      child: Padding(
        padding: responsive.isDesktop
            ? const EdgeInsets.only(bottom: 12)
            : const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            !responsive.isMobile
                ? const SizedBox(
                    width: 272,
                    height: 45,
                    child: PSearchContainer(
                      text: 'Search',
                      hasColor: true,
                      usePrefixSuffix: true,
                      color: PColors.light,
                      useBorder: false,
                    ))
                : IconButton(
                    onPressed: () {
                      scaffoldKey?.currentState?.openDrawer();
                    },
                    icon: const Icon(Icons.menu_rounded)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                if (!responsive.isMobile)
                  MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: PRoundedImage(
                        onPressed: () {},
                        imageType: ImagesType.asset,
                        image: PImages.ai,
                        height: responsive.isMobile ? 40 : 48,
                        width: responsive.isMobile ? 40 : 48,
                        borderRadius: 100,
                      )),
                if (!responsive.isMobile)
                  PCircularIcon(
                    icon: Iconsax.notification,
                    onPressed: () {
                      appRouter.router.goNamed(KRoutes.notifications);
                    },
                    height: responsive.isMobile ? 40 : 45,
                    width: responsive.isMobile ? 40 : 45,
                    usesBadge: true,
                  ),
                PCircularIcon(
                  icon: responsive.isMobile
                      ? Iconsax.search_normal
                      : Icons.settings,
                  onPressed: () {
                    if (!responsive.isMobile) {
                      appRouter.router.goNamed(KRoutes.settings);
                      return;
                    }
                  },
                  height: responsive.isMobile ? 40 : 45,
                  width: responsive.isMobile ? 40 : 45,
                ),
                if (responsive.isMobile)
                  MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: PRoundedImage(
                        onPressed: () {},
                        imageType: ImagesType.asset,
                        image: PImages.ai,
                        height: responsive.isMobile ? 45 : 48,
                        width: responsive.isMobile ? 45 : 48,
                        borderRadius: 100,
                      )),
                if (!responsive.isMobile) const Gap(10),
                CustomDropdownMenu(
                  items: filterItems,
                  trigger: UserAvater(
                    size: responsive.isMobile ? 40 : 45,
                    useAddButton: false,
                    isExtended: responsive.isMobile ? false : true,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(68);
  }
}

class AppDesktopLogo extends StatelessWidget {
  const AppDesktopLogo(
      {super.key, this.inverse = false, this.useInverse2 = false});
  final bool inverse, useInverse2;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: PRoundedImage(
        width: inverse || useInverse2 ? 116 : 40,
        height: inverse || useInverse2 ? 40 : 32,
        imageType: ImagesType.asset,
        image: inverse
            ? PImages.psk1
            : useInverse2
                ? PImages.psk2
                : PImages.p2,
      ),
    );
  }
}


// AppBar(
//       // backgroundColor: Colors.black,
//       centerTitle: true,
//       automaticallyImplyLeading: false,
//       leadingWidth: 200,
//       leading: 
//       title: 
//       actions: [],
//     );