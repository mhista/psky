import 'package:ahiaa_web/core/common/widgets/buttons/elevated_r_button.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/images/edge_rounded_images.dart';
import 'package:ahiaa_web/core/common/widgets/shimmer/three_to_one_shimmer.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/utils/constants/image_strings.dart';
import 'package:ahiaa_web/core/utils/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class PracticeExamFirstSection extends StatelessWidget {
  const PracticeExamFirstSection({
    super.key,
    required this.isLoading,
    required this.hasData,
    required this.hasError,
  });

  final bool isLoading;
  final bool hasData;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);

    return ThreeToOneShimmer(
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
          height:responsive.isMobile? 133: 161,
          width: double.infinity,
          backgroundColor: PColors.primary2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: Padding(
                  padding:  EdgeInsets.symmetric(
                      vertical: 12, horizontal: responsive.isMobile? 12: 16),
                  child: Column(
                    spacing: 4,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // WELCOME MESSAGE
                      Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                            width:responsive.isMobile? 187: 284,
                            child: const ResponsiveText(
                              'Practice Exams',
                            )
                                .white
                                .left
                                .headlineMedium
                                .responsive
                                .withSize(responsive.isMobile? 16: 30)),
                      ),
                      // if (isNotEmptyState) const Gap(10),
                      Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                            width:responsive.isMobile? 170: 203,
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
                            size: responsive.isMobile? 8: 9,
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
              ),
               Expanded(
                 child: PRoundedImage(
                  imageType: ImagesType.asset,
                  image: PImages.exam,
                  height:responsive.isMobile? 90: 166,
                  width: responsive.isMobile ?300 :450,
                  fit:responsive.isMobile? BoxFit.fill: BoxFit.fill,
                  padding: 0,
                  borderRadius: 12,
                               ),
               )
            ],
          ),
        ));
  }
}
