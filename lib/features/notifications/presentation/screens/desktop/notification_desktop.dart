import 'package:ahiaa_web/core/common/custom_dropdown/custom_dropdown2.dart';
import 'package:ahiaa_web/core/common/custom_dropdown/dropdown_feeds_item.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/icons/circular_icon.dart';
import 'package:ahiaa_web/core/common/widgets/images/edge_rounded_images.dart';
import 'package:ahiaa_web/core/common/widgets/shimmer/three_to_one_shimmer.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/utils/constants/image_strings.dart';
import 'package:ahiaa_web/core/utils/enums/enums.dart';
import 'package:ahiaa_web/core/utils/enums/notification_enums.dart';
import 'package:ahiaa_web/core/utils/helpers/date_helper.dart';
import 'package:ahiaa_web/core/utils/logging/logger.dart';
import 'package:ahiaa_web/features/notifications/presentation/cubit/notification_cubit.dart';
// import 'package:ahiaa_web/features/notifications/presentation/cubit/notification_cubit.dart'
import 'package:ahiaa_web/features/notifications/presentation/cubit/notification_page_cubit.dart';
import 'package:ahiaa_web/features/notifications/presentation/cubit/notification_page_state.dart';
import 'package:ahiaa_web/features/notifications/presentation/screens/notification_detail.dart';
import 'package:ahiaa_web/features/notifications/presentation/screens/widgets/notifications_item.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' hide TextButton;

class NotificationDesktop extends StatelessWidget {
  const NotificationDesktop(
      {super.key,
      required this.dropDownKey,
      required this.dropDownKey2,
      required this.actionItems,
      required this.filterItems,
      required this.isLoading,
      required this.hasError,
      required this.hasData,
      required this.isFirstTime});

  final GlobalKey<CustomDropdownMenuState> dropDownKey, dropDownKey2;
  final List<DropdownFeedsItem> actionItems;
  final List<DropdownFeedsItem> filterItems;
  final bool isLoading;
  final bool hasError;
  final bool hasData;
  final bool isFirstTime;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);
    final notificationCubit = getIt<NotificationCubit>();

    final notifCubit = getIt<NotificationPageCubit>();
    return BlocBuilder<NotificationCubit, NotificationState>(
      bloc: notificationCubit,
      builder: (context, notifState) {
        final hasNotif = notifState.maybeWhen(
          orElse: () {
            return null;
          },
          loaded: (notifications, unreadCount, hasMore, lastDocument) =>
              (notifications, unreadCount, hasMore, lastDocument),
        );

        return BlocBuilder<NotificationPageCubit, NotificationPageState>(
          bloc: notifCubit,
          builder: (context, state) {
            return TRoundedContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 28,
                children: [
                  if (!responsive.isMobile)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (state.currentPageIndex < 1)
                          const ResponsiveText('Notifications')
                              .withSize(responsive.isMobile ? 24 : 28)
                              .bold,
                        if (state.currentPageIndex > 0)
                          TextButton(
                            onPressed: () => notifCubit.previous(),
                            child: Row(
                              spacing: 5,
                              children: [
                                const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  size: 13,
                                ),
                                const ResponsiveText('Back').withSize(10)
                              ],
                            ),
                          ),
                        Row(
                          spacing: 12,
                          children: [
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: CustomDropdownMenu(
                                  key: dropDownKey, // ← ADD THIS LINE!
                                  height: 56,
                                  width: 120,
                                  backgroundColor: PColors.light,
                                  // position: DropdownPosition.bottomCenter,
                                  trigger: TRoundedContainer(
                                    onTap: null,
                                    height: 40,
                                    radius: 100,
                                    backgroundColor: PColors.light,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 10),
                                    child: Row(
                                      spacing: 12,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const ResponsiveText('Actions')
                                            .withSize(10),
                                        const Icon(
                                            Icons.arrow_drop_down_rounded)
                                      ],
                                    ),
                                  ),
                                  items: actionItems),
                            ),
                            CustomDropdownMenu(
                                key: dropDownKey2, // ← ADD THIS LINE!
                                height: 177,
                                width: 120,
                                backgroundColor: PColors.light,
                                trigger: const MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: PCircularIcon(
                                      onPressed: null,
                                      width: 40,
                                      height: 40,
                                      widget: PRoundedImage(
                                        imageType: ImagesType.asset,
                                        image: PImages.filter,
                                        fit: BoxFit.scaleDown,
                                      ),
                                    )),
                                items: filterItems)
                          ],
                        ),
                      ],
                    ),
                  if (responsive.isMobile)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 12,
                      children: [
                        if (state.currentPageIndex < 1)
                          const ResponsiveText('Notifications')
                              .withSize(responsive.isMobile ? 24 : 28)
                              .bold,
                        if (state.currentPageIndex > 0)
                          TextButton(
                            onPressed: () => notifCubit.previous(),
                            child: Row(
                              spacing: 5,
                              children: [
                                const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  size: 13,
                                ),
                                const ResponsiveText('Back').withSize(10)
                              ],
                            ),
                          ),
                        Row(
                          spacing: 12,
                          children: [
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: CustomDropdownMenu(
                                  key: dropDownKey, // ← ADD THIS LINE!
                                  height: 56,
                                  width: 120,
                                  backgroundColor: PColors.light,
                                  // position: DropdownPosition.bottomCenter,
                                  trigger: TRoundedContainer(
                                    onTap: null,
                                    height: 40,
                                    radius: 100,
                                    backgroundColor: PColors.light,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 10),
                                    child: Row(
                                      spacing: 12,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const ResponsiveText('Actions')
                                            .withSize(10),
                                        const Icon(
                                            Icons.arrow_drop_down_rounded)
                                      ],
                                    ),
                                  ),
                                  items: actionItems),
                            ),
                            CustomDropdownMenu(
                                key: dropDownKey2, // ← ADD THIS LINE!
                                height: 177,
                                width: 120,
                                backgroundColor: PColors.light,
                                trigger: const MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: PCircularIcon(
                                      onPressed: null,
                                      width: 40,
                                      height: 40,
                                      widget: PRoundedImage(
                                        imageType: ImagesType.asset,
                                        image: PImages.filter,
                                        fit: BoxFit.scaleDown,
                                      ),
                                    )),
                                items: filterItems)
                          ],
                        ),
                      ],
                    ),
                  Expanded(
                    child: ThreeToOneShimmer(
                        isLoading: isLoading,
                        width: double.infinity,
                        hasError: hasError,
                        hasData: hasData,
                        errorColor: PColors.tertiary.withValues(alpha: 0.4),
                        callBack: () {},
                        useFunction: true,
                        errorText: """Couldn’t load notifications.
        Please check your connection or try again.""",
                        radius: 16,
                        canReload: true,
                        loadedWidget: TRoundedContainer(
                          backgroundColor: PColors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          width: double.infinity,
                          child: isFirstTime
                              ? Column(
                                  children: [
                                    const Spacer(),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const ResponsiveText(
                                                    'No new notifications at the moment. ')
                                                .withSize(12)
                                                .bold
                                                .withOpacity(0.7),
                                            const Gap(5),
                                            const ResponsiveText(
                                                    'Keep practicing — updates will appear here ')
                                                .withSize(12)
                                                .bold
                                                .withOpacity(0.7),
                                            const Gap(15),
                                            const PRoundedImage(
                                              imageType: ImagesType.asset,
                                              image: PImages.kaiNotify,
                                              height: 166,
                                              width: 500,
                                              fit: BoxFit.fill,
                                              padding: 0,
                                              borderRadius: 12,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : PageView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  controller: notifCubit.pageController,
                                  onPageChanged: (value) =>
                                      notifCubit.updatePageIndicator(value),
                                  children: [
                                    ListView.separated(
                                        padding: const EdgeInsets.only(top: 12),
                                        itemBuilder: (_, index) {
                                          final notif = hasNotif!.$1[index];
                                          final buttonText =
                                              (notif.data?['action'] ??
                                                      'view_report')
                                                  .toString()
                                                  .split('_');

                                          final notifTypeStr =
                                              (notif.data?['type'] ??
                                                      'view_report')
                                                  .toString();
                                          final notifTypeEnum =
                                              notifTypeStr.toNotificationType;
                                          final String btnTxt = [
                                            NotificationType.sessionReminder,
                                            NotificationType.sessionPause,
                                            NotificationType.sessionResume,
                                            NotificationType.sessionComplete,
                                            NotificationType.streakReminder,
                                            NotificationType.dailyGoal
                                          ].contains(notifTypeEnum)
                                              ? ('${buttonText.isNotEmpty ? buttonText[0] : ''}${buttonText.length > 1 ? ' ${buttonText[1]}' : ''}')
                                                      .capitalizeFirst ??
                                                  ''
                                              : '';
                                          pskyLog(
                                              '{${notif.data?['action']} $notifTypeEnum}');
                                          return NotificationItem(
                                              buttonText:
                                                  btnTxt.isEmpty ? '' : btnTxt,
                                              timeAgo:
                                                  notif.createdAt.toTimeAgo,
                                              title: notif.title,
                                              subtitle: notif.body,
                                              onViewReport: () {
                                                switch (notifTypeEnum) {
                                                  case NotificationType
                                                        .sessionReminder:
                                                  case NotificationType
                                                        .sessionPause:
                                                  case NotificationType
                                                        .sessionResume:
                                                    pskyLog('msg');
                                                    notifCubit.next();

                                                    break;
                                                  case NotificationType
                                                        .sessionComplete:
                                                    notifCubit.next();

                                                    break;
                                                  case NotificationType
                                                        .streakReminder:
                                                  case NotificationType
                                                        .dailyGoal:
                                                    notifCubit.next();

                                                    break;
                                                  default:
                                                    return;
                                                }
                                              });
                                        },
                                        separatorBuilder: (_, index) {
                                          return const SizedBox(
                                            height: 12,
                                          );
                                        },
                                        itemCount: hasNotif!.$1.length),
                                    const NotificationDetails()
                                  ],
                                ),
                        )),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
