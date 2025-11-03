import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/images/edge_rounded_images.dart';
import 'package:ahiaa_web/core/common/widgets/shimmer/three_to_one_shimmer.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/utils/enums/enums.dart';
import 'package:ahiaa_web/core/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart'
    hide Theme, Colors, TextButton;

class DashboardBigInfo extends StatelessWidget {
  const DashboardBigInfo({
    super.key,
    this.isLoading = false,
    this.hasData = false,
    this.hasError = false,
    this.isNotEmptyState = true,
  });

  final bool isLoading;
  final bool hasData;
  final bool hasError;
  final bool isNotEmptyState;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ThreeToOneShimmer(
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
                    padding:const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    child: Column(
                      spacing: 4,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // INFO BUTTONS
                        if (isNotEmptyState)
                          Row(
                            spacing: 8,
                            children: [
                              Text(
                                'Resume Test',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .apply(color: Colors.white),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 8),
                                    visualDensity:
                                        const VisualDensity(vertical: -4),
                                    backgroundColor: const Color(0xffDCF9E0)),
                                child: const ResponsiveText(
                                  'Mathematics',
                                )
                                    .responsive
                                    .labelMedium
                                    .withColor(PColors.secondary1)
                                    .withSize(9),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 8),
                                    visualDensity:
                                        const VisualDensity(vertical: -4),
                                    backgroundColor: const Color(0xffF9DEDC)),
                                child: const ResponsiveText(
                                  'Est. time left ~ 18mins',
                                )
                                    .responsive
                                    .labelMedium
                                    .withColor(PColors.bg2)
                                    .withSize(9),
                              ),
                            ],
                          ),
                        // WELCOME MESSAGE
                        Align(
                          alignment: Alignment.topLeft,
                          child: SizedBox(
                              width: 284,
                              child: ResponsiveText(
                                isNotEmptyState
                                    ? 'You’re on question 7 of 30 — keep the momentum!'
                                    : 'Welcome to your dashboard',
                              )
                                  .white
                                  .left
                                  .headlineMedium
                                  .responsive
                                  .withSize(isNotEmptyState ? 18 : 20)),
                        ),
                        if (isNotEmptyState) const Gap(10),
                        if (!isNotEmptyState)
                          Align(
                            alignment: Alignment.topLeft,
                            child: SizedBox(
                                width: 203,
                                child: const ResponsiveText(
                                  'No test in progress yet. Start practising to see your progress here.',
                                )
                                    .left
                                    .bodySmall
                                    .responsive
                                    .withSize(8)
                                    .withWeight(FontWeight.w200)
                                    .withColor(
                                        PColors.white.withValues(alpha: 0.7))),
                          ),
                    
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 15),
                                  visualDensity:
                                      const VisualDensity(vertical: -4),
                                  backgroundColor: PColors.white),
                              child:  ResponsiveText(
                               isNotEmptyState?'Continue Test' :'Start your first mock',
                                letterSpacing: 1.0,
                              )
                                  .responsive
                                  .labelMedium
                                  .withColor(PColors.primary)
                                  .withSize(6)
                                  .exBold,
                            ),
                            if(isNotEmptyState)
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 15),
                                  visualDensity:
                                      const VisualDensity(vertical: -4),
                                ),
                              child: const ResponsiveText(
                                'Save & Exit',
                                letterSpacing: 1.0,
                              )
                                  .responsive
                                  .labelMedium
                                  .withColor(PColors.white)
                                  .withSize(7)
                                  .exBold,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                   PRoundedImage(imageType: ImagesType.asset, image:isNotEmptyState? PImages.kaiWave :PImages.kaiMascot, height: 166, width:290 , fit: BoxFit.fill, padding:0, borderRadius: 12,)
                ],
              ),
            )));
  }
}

