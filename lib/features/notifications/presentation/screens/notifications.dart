import 'package:ahiaa_web/core/common/custom_dropdown/custom_dropdown2.dart';
import 'package:ahiaa_web/core/common/custom_dropdown/dropdown_feeds_item.dart';
import 'package:ahiaa_web/core/common/layout/templates/site_template.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/utils/enums/enums.dart';
import 'package:ahiaa_web/core/utils/enums/notification_enums.dart';
import 'package:ahiaa_web/features/notifications/presentation/cubit/notification_cubit.dart'
   ;
import 'package:ahiaa_web/features/notifications/presentation/screens/desktop/notification_desktop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final notifCubit = getIt<NotificationCubit>();

    final actionItems = [
      DropdownFeedsItem(
        alignRight: false,
        label: 'Mark all as read',
        onTap: () {
          dropDownKey.currentState?.hide();
          notifCubit.markAllAsRead();
        },
        icon: Icons.check,
        iconColor: PColors.deepBlack,
        textSize: responsive.isMobile ? 10 : 8,
        iconSize: 10,
      ),
      DropdownFeedsItem(
        alignRight: false,
        label: 'Clear all',
        onTap: () {
          dropDownKey.currentState?.hide();
          notifCubit.deleteAllNotifications();
        },
        icon: Icons.delete,
        textSize: responsive.isMobile ? 10 : 8,
        iconSize: 10,
        iconColor: PColors.bg2,
      )
    ];
    final filterItems = NotificationCategory.values
        .map(
          (n) => DropdownFeedsItem(
            label: n.displayName,
            onTap: () {
              dropDownKey2.currentState?.hide();
              notifCubit.filterByCategory(n);
            },
            textSize: responsive.isMobile ? 10 : 8,
          ),
        )
        .toList();

    return BlocBuilder<NotificationCubit, NotificationState>(
      bloc: notifCubit,
      builder: (context, state) {
        final stateData = state.maybeWhen(
          orElse: () {
            // examCubit.loadFromStorage().then((v) {
            //   // examCubit.syncFromDb(getIt<UserEntity>().id);
            // });
            return (loaderState: LoaderState.loading,);
          },
          error: (message) => (loaderState: LoaderState.error,),
          loaded: (_, __, ___, ____) => (loaderState: LoaderState.done,),
          initial: () => (loaderState: LoaderState.Initial,),
          loading: () => (loaderState: LoaderState.loading,),
        );

        // Derive shimmer states from BLoC state
        final isLoading = stateData.loaderState == LoaderState.loading;
        final hasError = stateData.loaderState == LoaderState.error;
        final hasData = stateData.loaderState == LoaderState.done;
        final isFirstTime = stateData.loaderState == LoaderState.Initial;
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
      },
    );
  }
}
