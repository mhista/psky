import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/features/landing/screen/widgets/sub_header.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ProgressWidget extends StatelessWidget {
  const ProgressWidget({
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
      backgroundColor: const Color(0xffD8F0FF),
      child: Column(
        crossAxisAlignment:isMobile? CrossAxisAlignment.center: CrossAxisAlignment.start,
        children: [
          const SubHeader(
              title: 'Progress tracking & insights',
              subTitle:
                  'Track daily performance, topic mastery, and streaks to see real improvement overtime',
              color: PColors.deepBlack),
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
                              Row(
                                spacing: 8,
                                children: [
                                  const TRoundedContainer(
                                    radius: 8,
                                    height: 24,
                                    width: 24,
                                    padding:
                                         EdgeInsets.all(0),
                                         showBorder: true,
                                   
                                    child: Center(
                                      child: Icon(Icons.person, color: PColors.bg3, size: 12,)
                                    ),
                                  ),
    
                                  Text('Your performance', style: Theme.of(context).textTheme.labelSmall!.apply(fontWeightDelta: 2),)
                                ],
                              ),
                              const Icon(Icons.more_horiz, size: 18,)
                            ],
                          ),
                          const Gap(20),
                          Column(
                            spacing: 8,
                            children: [
                               BarDummyWidget(title: 'English', width:isMobile? 186: 389, isPrimary: true),
                               BarDummyWidget(title: 'Math', width:isMobile? 144:302, isPrimary: false),
                               BarDummyWidget(title: 'Agric', width:isMobile? 115: 240, isPrimary: false),
                               BarDummyWidget(title: 'French', width:isMobile? 59: 124, isPrimary: false),

                              Padding(
                                padding: const EdgeInsets.only(left:40.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('0', style:isMobile?Theme.of(context).textTheme.labelSmall!.apply(fontSizeDelta: -2,): Theme.of(context).textTheme.labelMedium,),
                                    Text('20', style:isMobile?Theme.of(context).textTheme.labelSmall!.apply(fontSizeDelta: -2,):  Theme.of(context).textTheme.labelMedium,),
                                    Text('60', style:isMobile?Theme.of(context).textTheme.labelSmall!.apply(fontSizeDelta: -2,):  Theme.of(context).textTheme.labelMedium,),
                                    Text('100', style:isMobile?Theme.of(context).textTheme.labelSmall!.apply(fontSizeDelta: -2,):  Theme.of(context).textTheme.labelMedium,),

                                    
                                  ],
                                ),
                              )
                            ],
                          )
    
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

class BarDummyWidget extends StatelessWidget {
  const BarDummyWidget({
    super.key, required this.title, required this.width,  this.isPrimary =  false,
  });
  final String title;
  final double width;
  final bool isPrimary;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: calcSpacing(title.length),
      children: [
      
      Text(title, style: Theme.of(context).textTheme.labelSmall!.apply(fontWeightDelta: 2, fontSizeDelta: -2),),
                          //  Gap(),
        
        TRoundedContainer(
          height: 16,
          width: width,
          backgroundColor:isPrimary? PColors.bg3: PColors.grey,
          radius: 4,
        )
      ],
    );
  }
}

double calcSpacing(int len){
  // debugPrint(len.toString());
  int ab = 8 - len;
  int toAdd = ab + 8;
    debugPrint(toAdd.toString());
    return (toAdd).toDouble();
}