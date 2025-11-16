import 'package:ahiaa_web/core/common/layout/headers/header2.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ahiaa_web/core/routes/app_router2.dart';
import 'package:ahiaa_web/core/routes/routes.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';

class KSideBar extends StatefulWidget {
  const KSideBar({super.key});

  @override
  State<KSideBar> createState() => _KSideBarState();
}

class _KSideBarState extends State<KSideBar> {
  bool canChangeHeigth = false;

  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunctions.isDarkMode(context);
    final appRouter = getIt<AppRouter>();
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: AnimatedSize(
        duration:  Duration(milliseconds: canChangeHeigth?600: 800),
          curve:!canChangeHeigth? Curves.easeInOut:Curves.easeIn,
        child: Drawer(
          backgroundColor: isDark ? PColors.primary : PColors.primary,
          width: canChangeHeigth ? 80 : 300,
          shape: const BeveledRectangleBorder(),
          child: TRoundedContainer(
              // padding: canChangeHeigth
              //     ? EdgeInsets.only(left: 20, top: 16, right: 12, bottom: 16)
              //     : EdgeInsets.all(16),
              width: canChangeHeigth ? 80 : 300,
              backgroundColor: isDark ? PColors.primary : PColors.primary,
              child: Column(
                crossAxisAlignment: canChangeHeigth
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (!canChangeHeigth)
                        const AppDesktopLogo(
                          inverse: true,
                          useInverse2: true,
                        ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              canChangeHeigth = !canChangeHeigth;
                            });
                          },
                          icon: const Icon(
                            Iconsax.sidebar_left,
                            color: PColors.white,
                          )),
                    ],
                  ),
                  if (!canChangeHeigth)
                    const SizedBox(
                        width: 272,
                        height: 35,
                        child: PSearchContainer(
                          text: 'Search',
                          isSmall: true,
                          inverse: true,
                          hasColor: true,
                          usePrefixSuffix: true,
                          color: PColors.transparent,
                          useBorder: true,
                        )),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      spacing: 6,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SideBarNav(
                          showText: !canChangeHeigth,
                          icon: Iconsax.home,
                          text: 'Home',
                          onPressed: () =>
                              appRouter.router.goNamed(KRoutes.dashboard),
                        ),
                        SideBarNav(
                          showText: !canChangeHeigth,
                          icon: Icons.timer_outlined,
                          text: 'My Tests',
                          onPressed: () =>
                              appRouter.router.goNamed(KRoutes.myTests),
                        ),
                        SideBarNav(
                          showText: !canChangeHeigth,
                          icon: Iconsax.clock,
                          text: 'Practice Exam',
                          onPressed: () =>
                              appRouter.router.goNamed(KRoutes.practiceExam),
                        ),
                        SideBarNav(
                            showText: !canChangeHeigth,
                            icon: Iconsax.chart,
                            onPressed: () =>
                                appRouter.router.goNamed(KRoutes.analytics),
                            text: 'Progress & Analytics'),
                        SideBarNav(
                            onPressed: () =>
                                appRouter.router.goNamed(KRoutes.subscriptions),
                            showText: !canChangeHeigth,
                            icon: Iconsax.wallet,
                            text: 'Subscriptions'),
                        SideBarNav(
                            onPressed: () =>
                                appRouter.router.goNamed(KRoutes.notifications),
                            showText: !canChangeHeigth,
                            icon: Iconsax.notification,
                            text: 'Notifications'),
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Column(
                            children: [
                              SideBarNav(
                                  onPressed: () =>
                                      appRouter.router.goNamed(KRoutes.settings),
                                  showText: !canChangeHeigth,
                                  icon: Iconsax.setting,
                                  text: 'Settings'),
                              SideBarNav(
                                  onPressed: () =>
                                      appRouter.router.goNamed(KRoutes.help),
                                  showText: !canChangeHeigth,
                                  icon: Iconsax.message_question,
                                  text: 'Help'),
                              SideBarNav(
                                  showText: !canChangeHeigth,
                                  icon: Iconsax.logout,
                                  text: 'Logout'),
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
                ],
              )),
        ),
      ),
    );
  }
}

class SideBarNav extends StatelessWidget {
  const SideBarNav(
      {super.key,
      required this.icon,
      required this.text,
      this.onPressed,
      this.showText = true,
      this.isSelected = false,
      this.textColor = Colors.white,
      this.selectedColor = PColors.accent,

      this.iconColor = Colors.white});
  final IconData icon;
  final String text;
  final Function()? onPressed;
  final bool showText, isSelected;
  final Color textColor, iconColor, selectedColor;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      backgroundColor: isSelected
          ? selectedColor.withValues(alpha: 0.2)
          : PColors.transparent,
      padding: const EdgeInsets.all(0),
      radius: 20,
      child: IconButton(
        onPressed: onPressed,
        icon: Row(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment:
              !showText ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: iconColor,
            ),
            if (showText)
              Text(
                text,
                style: TextStyle(color: textColor),
              )
          ],
        ),
      ),
    );
  }
}
