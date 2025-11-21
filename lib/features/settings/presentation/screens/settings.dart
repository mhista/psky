import 'package:ahiaa_web/core/common/layout/sidebars/sidebar.dart';
import 'package:ahiaa_web/core/common/layout/templates/site_template.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:ahiaa_web/features/settings/presentation/screens/delete_account.dart';
import 'package:ahiaa_web/features/settings/presentation/screens/desktop/settings_desktop_screen.dart';
import 'package:ahiaa_web/features/settings/presentation/screens/edit_profile.dart';
import 'package:ahiaa_web/features/settings/presentation/screens/mobile/setting_mobile_screen.dart';
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
      desktop: SettingsDesktopScreen(settingsCubit: settingsCubit),
      mobile: SettingMobileScreen(settingsCubit: settingsCubit),
    );
  }
}
