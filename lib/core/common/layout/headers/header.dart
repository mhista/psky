import 'package:ahiaa_web/core/common/widgets/images/edge_rounded_images.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/routes/app_router2.dart';
import 'package:ahiaa_web/core/routes/routes.dart';
import 'package:ahiaa_web/core/utils/enums/enums.dart';
import 'package:ahiaa_web/core/utils/constants/image_strings.dart';
import 'package:ahiaa_web/features/landing/cubit/scroll_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../utils/device/device_utility.dart';

class KHeader extends StatelessWidget implements PreferredSizeWidget {
  const KHeader({super.key, this.scaffoldKey});
  
  // Globalkey to access the scaffold state
  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final route = getIt<AppRouter>().router;
    final responsive = ResponsiveBreakpoints.of(context);
    final scrollCubit = context.read<ScrollCubit>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: responsive.isMobile ? 12 : 23),
      child: AppBar(
        // backgroundColor: Colors.black,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leadingWidth: responsive.isMobile ? null : 100,
        leading: !responsive.isMobile
            ? Image.asset(PImages.logoB, fit: BoxFit.contain, width: 104, height: 28)
            : IconButton(
                onPressed: () {},
                icon: const PRoundedImage(
                  width: 40,
                  height: 32,
                  imageType: ImagesType.asset,
                  image: PImages.logoS2,
                ),
              ),
        title: !responsive.isMobile
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NavLink(
                    title: 'Features',
                    onPressed: () {
                      scrollCubit.scrollToSection('features');
                    },
                  ),
                  const SizedBox(width: 24),
                  NavLink(
                    title: 'Why Choose Us',
                    onPressed: () {
                      scrollCubit.scrollToSection('why-us');
                    },
                  ),
                  const SizedBox(width: 24),
                  NavLink(
                    title: 'Review',
                    onPressed: () {
                      scrollCubit.scrollToSection('testimonials');
                    },
                  ),
                  const SizedBox(width: 24),
                  NavLink(
                    title: 'FAQ',
                    onPressed: () {
                      scrollCubit.scrollToSection('contact');
                    },
                  ),
                ],
              )
            : const SizedBox.shrink(),
        actions: [
          if (!responsive.isMobile)
            ElevatedButton(
              onPressed: () {
                AppRouter.markLandingPageCompleted();
                route.goNamed(KRoutes.auth);
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100))),
              child: const Text('Get Started'),
            )
          //   IconButton(onPressed: (){}, icon: const Icon(
          //   Icons.menu
          // ))
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(PDeviceUtils.getAppBarHeight());
}

class NavLink extends StatelessWidget {
  const NavLink({
    super.key,
    required this.title,
    required this.onPressed,
  });

  final String title;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}