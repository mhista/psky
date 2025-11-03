import 'package:ahiaa_web/core/common/custom_dropdown/custom_dropdown_implementation.dart';
import 'package:ahiaa_web/core/common/custom_dropdown/custom_dropdown_with_search.dart';
import 'package:ahiaa_web/core/common/widgets/buttons/elevated_r_button.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/images/edge_rounded_images.dart';
import 'package:ahiaa_web/core/common/widgets/shimmer/three_to_one_shimmer.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/routes/app_router2.dart';
import 'package:ahiaa_web/core/routes/routes.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/utils/constants/image_strings.dart';
import 'package:ahiaa_web/core/utils/enums/enums.dart';
import 'package:ahiaa_web/injection_container.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart'
    hide TextButton, Theme, Colors, Checkbox, Switch, IconButton;

class DesktopPracticeScreen extends StatelessWidget {
  const DesktopPracticeScreen(
      {super.key,
      this.isLoading = false,
      this.hasError = false,
      this.expand = false,
      this.isFirstTime = true,
      this.hasData = false});
  final bool isLoading, hasError, hasData, expand, isFirstTime;
  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: const EdgeInsets.all(0),
      child: SingleChildScrollView(
        child: Column(
          spacing: 12,
          children: [
            // FIRST SECTION
            ThreeToOneShimmer(
                isLoading: isLoading,
                hasData: hasData,
                hasError: hasError,
                width: double.infinity,
                maxWidth: 699,
                radius: 16,
                height: 161,
                useFunction: true,
                errorText:
                    "Couldn't load your text progress, please refresh or try again",
                errorColor: PColors.tertiary.withValues(alpha: 0.5),
                loadedWidget: TRoundedContainer(
                  padding: EdgeInsets.zero,
                  height: 161,
                  width: double.infinity,
                  backgroundColor: PColors.primary2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        child: Column(
                          spacing: 4,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // WELCOME MESSAGE
                            Align(
                              alignment: Alignment.topLeft,
                              child: SizedBox(
                                  width: 284,
                                  child: const ResponsiveText(
                                    'Practice Exams',
                                  )
                                      .white
                                      .left
                                      .headlineMedium
                                      .responsive
                                      .withSize(30)),
                            ),
                            // if (isNotEmptyState) const Gap(10),
                            Align(
                              alignment: Alignment.topLeft,
                              child: SizedBox(
                                  width: 203,
                                  child: const ResponsiveText(
                                    'Timed, WAEC-style exams to prepare you under real conditions.',
                                  )
                                      .left
                                      .bodySmall
                                      .responsive
                                      .withSize(10)
                                      .withWeight(FontWeight.w200)
                                      .withColor(PColors.white
                                          .withValues(alpha: 0.7))),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                TElevatedButton(
                                  text: 'Start your first mock',
                                  size: 9,
                                  verticalPadding: 3,
                                  density: -3,
                                  onTap: () {},
                                ),

                                // if(isNotEmptyState)
                              ],
                            ),
                          ],
                        ),
                      ),
                      const PRoundedImage(
                        imageType: ImagesType.asset,
                        image: PImages.exam,
                        height: 166,
                        width: 450,
                        fit: BoxFit.fill,
                        padding: 0,
                        borderRadius: 12,
                      )
                    ],
                  ),
                )),

            // SECOND SECTION
            Column(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 8,
                            children: [
                              const ResponsiveText('Choose Exam Type')
                                  .withSize(8)
                                  .bold,
                              const TRoundedContainer(
                                width: 312,
                                backgroundColor: PColors.white,
                                // showBorder: true,
                                padding: EdgeInsets.all(0.0),

                                radius: 28,
                                child: KCustomDropdown(items: [
                                  'Full Mock Exam',
                                  'Single Subject Exam',
                                  'Quick Drill',
                                  'Full Mock Exam',
                                  'Full Mock Exam',
                                ]),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 8,
                              children: [
                                const ResponsiveText('Choose Subject')
                                    .withSize(8)
                                    .bold,
                                const TRoundedContainer(
                                  // width: 312,
                                  backgroundColor: PColors.white,
                                  // showBorder: true,
                                  padding: EdgeInsets.all(0.0),

                                  radius: 28,
                                  child: KCustomDropdownWithSearch(items: [
                                    'Further Mathematics',
                                    'Data Processing',
                                    'Further Mathematics',
                                    'Insurance',
                                  ]),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),

                // QUESTION CHIP AREA
                TRoundedContainer(
                  width: double.infinity,
                  child: DottedBorder(
                    options: RoundedRectDottedBorderOptions(
                        color:
                            isFirstTime ? PColors.darkGrey : PColors.deepBlack,
                        radius: const Radius.circular(8),
                        dashPattern: [10, 5]),
                    child: TRoundedContainer(
                        child: !isFirstTime
                            ? const TElevatedButton(
                                text: 'Start Test',
                                color: PColors.white,
                              )
                            : Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              // alignment: WrapAlignment.spaceBetween,
                                children: [
                                SizedBox(
                                  child: TRoundedContainer(
                                    // width: ('Acid-Base Balance').length * 8,
                                    padding: const EdgeInsets.all(6),
                                    showBorder: true,
                                    borderColor: PColors.deepBlack,
                                    radius: 8,
                                    child: Row(
                                    mainAxisSize: MainAxisSize.min,

                                      spacing:8 ,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const ResponsiveText(
                                          'Acid-Base Balance'
                                        ).withSize(8).bold,
                                        GestureDetector(child: const Icon(Icons.cancel_outlined, size: 14,) ,)
                                      ],
                                    ),
                                  ),
                                ), TRoundedContainer(
                                  // width: ('Mathematics').length * 8,
                                  padding: const EdgeInsets.all(6),
                                  showBorder: true,
                                  borderColor: PColors.deepBlack,
                                  radius: 8,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    spacing:8 ,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const ResponsiveText(
                                        'Mathematics'
                                      ).withSize(8).bold,
                                      GestureDetector(child: const Icon(Icons.cancel_outlined, size: 14,) ,)
                                    ],
                                  ),
                                )
                              ],
                            )),
                  ),
                ),
              ],
            ),
            // FOCUS AREA SECTION
            TRoundedContainer(
              padding: const EdgeInsets.all(0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ResponsiveText('Focus on weak areas')
                            .withSize(9)
                            .bold,
                        const Gap(4),
                        const ResponsiveText(
                                "We'll mix questions evenly across topics")
                            .withSize(9),
                      ],
                    ),
                    Switch(value: true, onChanged: (v) {})
                  ],
                ),
              ),
            ),
            // THIRD SECTION
            Column(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 8,
                            children: [
                              const ResponsiveText('Choose Exam Type')
                                  .withSize(8)
                                  .bold,
                              const TRoundedContainer(
                                width: 312,
                                backgroundColor: PColors.white,
                                // showBorder: true,
                                padding: EdgeInsets.all(0.0),

                                radius: 28,
                                child: KCustomDropdown(items: [
                                  'Full Mock Exam',
                                  'Single Subject Exam',
                                  'Quick Drill',
                                  'Full Mock Exam',
                                  'Full Mock Exam',
                                ]),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 8,
                              children: [
                                const ResponsiveText('Choose Subject')
                                    .withSize(8)
                                    .bold,
                                const TRoundedContainer(
                                  // width: 312,
                                  backgroundColor: PColors.white,
                                  // showBorder: true,
                                  padding: EdgeInsets.all(0.0),

                                  radius: 28,
                                  child: KCustomDropdownWithSearch(items: [
                                    'Further Mathematics',
                                    'Data Processing',
                                    'Further Mathematics',
                                    'Insurance',
                                  ]),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),

                // QUESTION CHIP AREA
                TRoundedContainer(
                  width: double.infinity,
                  child: DottedBorder(
                    options: RoundedRectDottedBorderOptions(
                        color: isFirstTime ? PColors.darkGrey : PColors.primary,
                        radius: const Radius.circular(8),
                        dashPattern: [10, 5]),
                    child: TRoundedContainer(
                        child: isFirstTime
                            ? const TElevatedButton(
                                text: 'Start Test',
                                color: PColors.white,
                              )
                            : const Column()),
                  ),
                ),
              ],
            ),
            // CUSTOM DURATION SETTING
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TRoundedContainer(
                borderColor: PColors.darkGrey,
                showBorder: true,
                width: double.infinity,
                child: Column(
                  spacing: 14,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          spacing: 46,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const ResponsiveText('Custom Exam')
                                .withSize(16)
                                .bold,
                            Row(
                              spacing: 9,
                              children: [
                                const ResponsiveText('Total :').withSize(8),
                                const ResponsiveText('15 Questions')
                                    .withSize(8)
                                    .bold,
                              ],
                            ),
                            Row(
                              spacing: 9,
                              children: [
                                const ResponsiveText('Exam Duration :')
                                    .withSize(8),
                                TRoundedContainer(
                                  padding: const EdgeInsets.all(0),
                                  backgroundColor: PColors.light,
                                  height: 40,
                                  width: 40,
                                  radius: 8,
                                  child: Center(
                                      child: const ResponsiveText('00')
                                          .withSize(14)
                                          .bold),
                                ),
                                TRoundedContainer(
                                  padding: const EdgeInsets.all(0),
                                  backgroundColor: PColors.light,
                                  height: 40,
                                  width: 40,
                                  radius: 8,
                                  child: Center(
                                      child: const ResponsiveText('30')
                                          .withSize(14)
                                          .bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        TElevatedButton(
                          text: 'Slider',
                          color: PColors.primary5,
                          bgColor: PColors.primary.withValues(alpha: 0.2),
                          onTap: () {},
                        )
                      ],
                    ),
                    Column(
                      children: [
                        TRoundedContainer(
                          backgroundColor: PColors.light,
                          height: 52,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const ResponsiveText('Test Title')
                                  .withSize(9)
                                  .bold,
                              const ResponsiveText('Questions')
                                  .withSize(9)
                                  .bold,
                            ],
                          ),
                        ),
                        ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return TRoundedContainer(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                height: 52,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const ResponsiveText('Test Title')
                                        .withSize(9)
                                        .bold,
                                    Row(
                                      spacing: 10,
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: const Padding(
                                            padding: EdgeInsets.only(top: 2.0),
                                            child: Icon(Icons.minimize),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: TRoundedContainer(
                                            padding: const EdgeInsets.all(0),
                                            backgroundColor: PColors.light,
                                            height: 32,
                                            width: 38,
                                            radius: 8,
                                            child: Center(
                                              child: const ResponsiveText('1')
                                                  .withSize(10)
                                                  .bold,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                            onTap: () {},
                                            child: const Padding(
                                              padding:
                                                  EdgeInsets.only(top: 12.0),
                                              child: Icon(Icons.add),
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (_, __) =>
                                const TRoundedContainer(
                                  width: double.infinity,
                                  height: 0.5,
                                  backgroundColor: PColors.darkGrey,
                                ),
                            itemCount: 2),
                       const Gap(20),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TElevatedButton(
                            text: 'Start Test',
                            color: PColors.white,
                            bgColor: PColors.primary,
                            size: 8,
                            onTap: () {
                              getIt<AppRouter>().router.pushNamed(KRoutes.examInstruct);
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
