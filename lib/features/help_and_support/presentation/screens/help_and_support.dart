import 'package:ahiaa_web/core/common/custom_dropdown/custom_dropdown2.dart';
import 'package:ahiaa_web/core/common/custom_dropdown/dropdown_feeds_item.dart';
import 'package:ahiaa_web/core/common/layout/templates/site_template.dart';
import 'package:ahiaa_web/core/common/widgets/buttons/elevated_r_button.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/icons/circular_icon.dart';
import 'package:ahiaa_web/core/common/widgets/images/edge_rounded_images.dart';
import 'package:ahiaa_web/core/common/widgets/shimmer/three_to_one_shimmer.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/utils/constants/image_strings.dart';
import 'package:ahiaa_web/core/utils/enums/enums.dart';
import 'package:ahiaa_web/features/help_and_support/presentation/screens/desktop/help_and_support_desktop.dart';
import 'package:ahiaa_web/features/notifications/presentation/screens/desktop/notification_desktop.dart';
import 'package:flutter/material.dart';

class HelpAndSupport extends StatelessWidget {
  const HelpAndSupport({
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
    // Move the key inside the widget where it's used
   
    return const SiteTemplate2(
        useLayout: true,
        desktop: HelpAndSupportDesktop());
  }
}
