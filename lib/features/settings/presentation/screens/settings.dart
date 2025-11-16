import 'package:ahiaa_web/core/common/layout/sidebars/sidebar.dart';
import 'package:ahiaa_web/core/common/layout/templates/site_template.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:ahiaa_web/features/settings/presentation/screens/delete_account.dart';
import 'package:ahiaa_web/features/settings/presentation/screens/edit_profile.dart';
import 'package:ahiaa_web/features/settings/presentation/screens/notification_settings.dart';
import 'package:ahiaa_web/features/settings/presentation/screens/password.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
    this.isLoading = false,
    this.hasError = false,
    this.expand = false,
    this.isFirstTime = false,
    this.hasData = true,
  });

  final bool isLoading, hasError, hasData, expand, isFirstTime;

  @override
  Widget build(BuildContext context) {
    final settingsCubit = getIt<SettingsCubit>();
    // Move the key inside the widget where it's used

    return SiteTemplate2(
        useLayout: true,
        desktop: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<SettingsCubit, SettingsState>(
              bloc: settingsCubit,
              builder: (context, state) {
                return TRoundedContainer(
                  useElevation: true,
                  backgroundColor: PColors.primary.withValues(alpha: 0.05),
                  height: 268,
                  width: 264,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SideBarNav(
                          iconColor: PColors.primary5,
                          textColor: PColors.primary5,
                          // isSelected: state.pageIndex == 0,

                          onPressed: () {
                            settingsCubit.nextPage(0);
                          },
                          showText: true,
                          icon: Iconsax.user,
                          text: 'Edit profile'),
                      SideBarNav(
                          iconColor: PColors.primary5,
                          textColor: PColors.primary5,
                          // isSelected: state.pageIndex == 1,
                          onPressed: () {
                            settingsCubit.nextPage(1);

                          },
                          showText: true,
                          icon: Iconsax.lock,
                          text: 'Password'),
                      SideBarNav(
                          iconColor: PColors.primary5,
                          textColor: PColors.primary5,
                          // isSelected: state.pageIndex == 2,

                          onPressed: () {
                            settingsCubit.nextPage(2);

                          },
                          showText: true,
                          icon: Iconsax.notification,
                          text: 'Notifications'),
                      SideBarNav(
                          iconColor: PColors.bg2,
                          textColor: PColors.bg2,
                          // isSelected: state.pageIndex == 3,
                          selectedColor: PColors.bg2,
                          onPressed: () {
                            settingsCubit.nextPage(3);

                          },
                          showText: true,
                          icon: Icons.delete_outline_rounded,
                          text: 'Delete Account'),
                    ],
                  ),
                );
              },
            ),
            BlocBuilder<SettingsCubit, SettingsState>(
              bloc: settingsCubit,
              builder: (context, state) {
                return Expanded(
                  child: PageView(
                    physics:const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    controller: settingsCubit.pageController,
                    onPageChanged: (value) => settingsCubit.changePage(value),
                    children:  [
                      // Your pages here
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(0),
                        child: EditProfile()),
                      const SingleChildScrollView(
                        padding: EdgeInsets.all(0),
                        
                        child: PasswordSettings()),
                      const SingleChildScrollView(child: NotificationSettings()),
                     const SingleChildScrollView(child:  DeleteAccount())
                    ],
                  ),
                );
              },
            )
          ],
        ));
  }
}


