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
import 'package:ahiaa_web/features/notifications/presentation/cubit/notification_cubit.dart';
import 'package:ahiaa_web/features/notifications/presentation/cubit/notification_state.dart';
import 'package:ahiaa_web/features/notifications/presentation/screens/notification_detail.dart';
import 'package:ahiaa_web/features/notifications/presentation/screens/notifications.dart';
import 'package:ahiaa_web/features/notifications/presentation/screens/widgets/notifications_item.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    final notifCubit = getIt<NotificationCubit>();
    return BlocBuilder<NotificationCubit, NotificationState>(
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
                                    const Icon(Icons.arrow_drop_down_rounded)
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
                                    const Icon(Icons.arrow_drop_down_rounded)
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
                                      mainAxisAlignment: MainAxisAlignment.end,
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
                              controller: notifCubit.pageController,
                              onPageChanged: (value) =>
                                  notifCubit.updatePageIndicator(value),
                              children: [
                                ListView.separated(
                                    padding: const EdgeInsets.only(top: 12),
                                    itemBuilder: (_, index) {
                                      return NotificationItem(
                                          timeAgo: '5m ago',
                                          title: 'Your test results are ready',
                                          subtitle:
                                              'You scored 75% on Mathematics Mock Test 2',
                                          onViewReport: () {
                                            notifCubit.next();
                                          });
                                    },
                                    separatorBuilder: (_, index) {
                                      return const SizedBox(
                                        height: 12,
                                      );
                                    },
                                    itemCount: 4),
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
  }
}
