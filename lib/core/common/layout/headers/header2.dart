import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ahiaa_web/core/common/widgets/icons/circular_icon.dart';
import 'package:ahiaa_web/core/common/widgets/images/edge_rounded_images.dart';
import 'package:ahiaa_web/features/personalization/presentation/screens/widgets/user_avater.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/utils/enums/enums.dart';
import 'package:ahiaa_web/core/utils/constants/image_strings.dart';
import 'package:ahiaa_web/core/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart'
    hide ScaffoldState, IconButton;

class KHeader2 extends StatelessWidget implements PreferredSizeWidget {
  const KHeader2({super.key, this.scaffoldKey});
  // leading: !responsive.isDesktop
  //           ? IconButton(
  //               onPressed: () => scaffoldKey?.currentState?.openDrawer(),
  //               icon: const Icon(Iconsax.menu))
  //           : null,

  // Globalkey to access the scaffold state
  final GlobalKey<ScaffoldState>? scaffoldKey;
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);
    return Container(
      margin:const EdgeInsets.only(bottom: 12),
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
              : const SizedBox.shrink(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
              MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child:  PRoundedImage(
                    onPressed: () {},
                    imageType: ImagesType.asset,
                    image: PImages.ai,
                    height: 48,
                    width: 48,
                    borderRadius: 100,
                  )),
              PCircularIcon(
                icon: Iconsax.notification,
                onPressed: () {},
                height: 45,
                width: 45,
                usesBadge: true,
              ),
              PCircularIcon(
                icon: Icons.settings,
                onPressed: () {},
                height: 45,
                width: 45,
              ),
              const Gap(10),
              const UserAvater(
                size: 45,
                useAddButton: false,
                isExtended: true,
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(PDeviceUtils.getAppBarHeight());
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