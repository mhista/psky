import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/images/edge_rounded_images.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/utils/enums/enums.dart';
import 'package:ahiaa_web/core/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';

class AiInsightWidget extends StatelessWidget {
  const AiInsightWidget({
    super.key,
    this.extra,
    this.bgColor=PColors.tertiary,
    this.aiText
  });
  final Widget? extra;
  final Color bgColor;
  final String? aiText;
  @override
  Widget build(BuildContext context) {
    return  TRoundedContainer(
      backgroundColor: bgColor.withValues(alpha: 0.5),
      padding:const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      height: extra != null? 96: 57,
      width: double.infinity,
      radius: 12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 4,
        children: [
          Row(
            spacing: 6,
            children: [
              const PRoundedImage(imageType: ImagesType.asset, image: PImages.ai, width: 12, height: 12,),
              const ResponsiveText('AI Insights for You').withSize(8).bold.withColor(PColors.primary5).withLetterSpacing(1)
            ],
          ),
               ResponsiveText(aiText?? 'No new insights right now. Complete a test to unlock personalised tips.').withSize(10).withColor(PColors.black),
         if(extra != null) extra!
        ],
      ),
    );
  }
}