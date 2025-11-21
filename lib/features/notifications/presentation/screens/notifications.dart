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
import 'package:ahiaa_web/features/notifications/presentation/screens/desktop/notification_desktop.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({
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
    final responsive = ResponsiveBreakpoints.of(context);

    final dropDownKey = GlobalKey<CustomDropdownMenuState>();
    final dropDownKey2 = GlobalKey<CustomDropdownMenuState>();

    final actionItems = [
      DropdownFeedsItem(
        alignRight: false,
        label: 'Mark all as read',
        onTap: () {
          dropDownKey.currentState?.hide();
        },
        icon: Icons.check,
        iconColor: PColors.deepBlack,
        textSize: responsive.isMobile? 10: 8,
        iconSize: 10,
      ),
      DropdownFeedsItem(
        alignRight: false,
        label: 'Clear all',
        onTap: () {
          dropDownKey.currentState?.hide();
        },
        icon: Icons.delete,
        textSize: responsive.isMobile? 10: 8,
        iconSize: 10,
        iconColor: PColors.bg2,
      )
    ];
    final filterItems = [
      DropdownFeedsItem(
        label: 'All',
        onTap: () {
          dropDownKey2.currentState?.hide();
        },
        textSize: responsive.isMobile? 10: 8,
      ),
      DropdownFeedsItem(
        label: 'Tests',
        onTap: () {
          dropDownKey2.currentState?.hide();
        },
        textSize: responsive.isMobile? 10: 8,
      ),
      DropdownFeedsItem(
        label: 'AI Insights',
        onTap: () {
          dropDownKey2.currentState?.hide();
        },
        textSize: responsive.isMobile? 10: 8,
      ),
      DropdownFeedsItem(
        label: 'Progress & Analytics',
        onTap: () {
          dropDownKey2.currentState?.hide();
        },
        textSize: responsive.isMobile? 10: 8,
      ),
      DropdownFeedsItem(
        label: 'System updates / Announcemenets',
        onTap: () {
          dropDownKey2.currentState?.hide();
        },
        textSize: responsive.isMobile? 10: 8,
      ),
    ];
    return SiteTemplate2(
        useLayout: true,
        desktop: NotificationDesktop(
          dropDownKey: dropDownKey,
          dropDownKey2: dropDownKey2,
          actionItems: actionItems,
          filterItems: filterItems,
          isLoading: isLoading,
          hasError: hasError,
          hasData: hasData,
          isFirstTime: isFirstTime,
        ));
  }
}
