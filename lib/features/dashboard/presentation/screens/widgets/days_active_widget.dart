import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:flutter/material.dart' hide DropdownMenu;
import 'package:gap/gap.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DaysActiveWidget extends StatelessWidget {
  const DaysActiveWidget({
    super.key,
    this.isExpanded=true
  });
final bool isExpanded;
  @override
  Widget build(BuildContext context) {
    final data = List.generate(30, (index) => index);
    return TRoundedContainer(
      backgroundColor: PColors.white,
      height: 240,
      width: double.infinity,
      padding: const EdgeInsets.all(0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 8,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: const ResponsiveText('9/')
                              .bold
                              .withColor(PColors.buttonSecondary),
                        ),
                        const ResponsiveText('30')
                            .bold
                            .withSize(58)
                            .withColor(PColors.primary5),
                      ],
                    ),
                    SizedBox(
                        width: 113,
                        child: const ResponsiveText(
                                'Number of days you’ve shown up — start today')
                            .withSize(6)),
                  ],
                ),
                MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: TRoundedContainer(
                      onTap: () {
                       
                      },
                      // width: 107,
                      height: 32,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      backgroundColor: PColors.primary2.withValues(alpha: 0.4),
                      radius: 100,
                      child: Row(
                        children: [
                          const ResponsiveText('September').withSize(9),
                          const Gap(5),
                          const Icon(
                            Icons.arrow_drop_down_rounded,
                            size: 20,
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
          // if(isExpanded)
          // const Gap(20),
           Padding(
             padding:const EdgeInsets.only(left: 9.0, right: 9, bottom: 10),
             child: Wrap(
               spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.start,
              children:  data
                .map((i) => const TRoundedContainer(
                      width: 40,
                      height: 40,
                      radius: 8,
                      backgroundColor: PColors.primary,
                    ))
                .toList(),
             ),
           )
        ],
      ),
    );
  }
}
