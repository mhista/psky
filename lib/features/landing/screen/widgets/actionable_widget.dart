
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/features/landing/screen/widgets/sub_header.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ActionableWidget extends StatelessWidget {
  const ActionableWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
        final responsive = ResponsiveBreakpoints.of(context);
    final isMobile = responsive.isMobile;
    return TRoundedContainer(
      padding: const EdgeInsets.all(0),
      width:isMobile?313: 564,
      height:isMobile?312: 400,
      backgroundColor: const Color(0xffFFBCFE),
      child: Column(
        crossAxisAlignment:isMobile? CrossAxisAlignment.center: CrossAxisAlignment.start,
        children: [
          const SubHeader(
              title: 'Instant, actionable feedback',
              subTitle:
                  'Answers are auto-scored and every question inclludes a clear explanation',
              color: PColors.bg2),
          Expanded(
            child: Stack(
              children: [
                Positioned(
                    top:isMobile? 40: 113,
                    right: isMobile? 14:26,
                    left: isMobile? 14:26,
                    child: TRoundedContainer(
                      showShadow: true,
                      height: 265,
                      width: 511,
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                            children: [
                              TRoundedContainer(
                                radius: 75,
                                padding:
                                    const EdgeInsets.all(0),
                                backgroundColor: PColors
                                    .primary
                                    .withValues(alpha: 0.2),
                                child: const Padding(
                                  padding:
                                      EdgeInsets.symmetric(
                                          horizontal: 12.0,
                                          vertical: 4),
                                  child: Center(
                                    child: Text(
                                      'English language',
                                      style: TextStyle(
                                          fontSize: 9,
                                          color: Color(
                                              0xff410E0B)),
                                    ),
                                  ),
                                ),
                              ),
                              TRoundedContainer(
                                height: 20,
                                width: 56,
                                radius: 75,
                                padding:
                                    const EdgeInsets.all(0),
                                backgroundColor: PColors
                                    .primary
                                    .withValues(alpha: 0.2),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.timer,
                                      size: 14,
                                      color:
                                          Color(0xff410E0B),
                                    ),
                                    Text(
                                      '57:09',
                                      style: TextStyle(
                                          fontSize: 9,
                                          color: Color(
                                              0xff410E0B)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Gap(20),
                          Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            spacing: 4,
                            children: [
                              TRoundedContainer(
                                height: 6,
                                width: 269,
                                backgroundColor: PColors
                                    .primary
                                    .withValues(alpha: 0.2),
                              ),
                              TRoundedContainer(
                                height: 6,
                                width: 269,
                                backgroundColor: PColors
                                    .primary
                                    .withValues(alpha: 0.2),
                              ),
                              TRoundedContainer(
                                height: 6,
                                width: 186,
                                backgroundColor: PColors
                                    .primary
                                    .withValues(alpha: 0.2),
                              ),
                            ],
                          ),
                          const Gap(20),
                          Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            spacing: 4,
                            children: [
                              TRoundedContainer(
                                padding:
                                    const EdgeInsets.all(7),
                                height: 53,
                                width: 474,
                                radius: 8,
                                borderColor:
                                    const Color(0xff410E0B),
                                showBorder: true,
                                child: TRoundedContainer(
                                  height: 40,
                                  width: 474,
                                  radius: 8,
                                  padding:
                                      const EdgeInsets.all(7),
                                  backgroundColor: PColors
                                      .primary
                                      .withValues(alpha: 0.2),
                                  child: const Align(
                                      alignment: Alignment
                                          .centerRight,
                                      child: Icon(
                                        Icons
                                            .verified_rounded,
                                        color: PColors
                                            .secondary2,
                                        size: 10,
                                      )),
                                ),
                              ),
                              // const Gap(4),
                              TRoundedContainer(
                                height: 40,
                                width: 474,
                                radius: 8,
                                backgroundColor: PColors
                                    .primary
                                    .withValues(alpha: 0.2),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
