import 'package:ahiaa_web/core/common/layout/sidebars/sidebar.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:ahiaa_web/features/settings/presentation/screens/delete_account.dart';
import 'package:ahiaa_web/features/settings/presentation/screens/edit_profile.dart';
import 'package:ahiaa_web/features/settings/presentation/screens/notification_settings.dart';
import 'package:ahiaa_web/features/settings/presentation/screens/password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class SettingMobileScreen extends StatelessWidget {
  const SettingMobileScreen({
    super.key,
    required this.settingsCubit,
  });

  final SettingsCubit settingsCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      bloc: settingsCubit,
      builder: (context, state) {
        return ListView(
          // physics:const NeverScrollableScrollPhysics(),
          // scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          // controller: settingsCubit.pageController,
          // onPageChanged: (value) => settingsCubit.changePage(value),
          children: [
            // Your pages here
            EditProfile(),

            const PasswordSettings(),
            // const NotificationSettings(),
            const DeleteAccount()
          ],
        );
      },
    );
  }
}
