import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/features/landing/screen/section_widgets/hero_section.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CTASection extends StatelessWidget {
  const CTASection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);
    final isMobile = responsive.isMobile;
    return RepaintBoundary(
      child: TRoundedContainer(
        height: isMobile ? 526 : 430,
        width: isMobile ? 320 : 1152,
        // backgroundColor: Colors.black,
        padding: const EdgeInsets.all(0),
        child: Stack(
          clipBehavior:isMobile?Clip.hardEdge: Clip.none,
          children: [
            TRoundedContainer(
              padding:  EdgeInsets.symmetric(vertical:isMobile?32: 56, horizontal: 26),
              height:isMobile? 526: 350,
              width: double.infinity,
              gradient: const LinearGradient(
                  begin: AlignmentGeometry.topCenter,
                  end: AlignmentGeometry.bottomCenter,
                  colors: [
                    Color(0xff6A39D8),
                    Color(0xff381E72),
                  ]),
              child: Column(
                crossAxisAlignment: isMobile
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                spacing:isMobile?10: 16,
                children: [
                  SizedBox(
                    width: isMobile ? 266 : 390,
                    child: Text(
                      'Ready to Ace WAEC?',
                      style: TextStyle(
                          color: PColors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: isMobile ? 36 : 45),
                      // softWrap: true,
                      textAlign: isMobile ? TextAlign.center : null,
                      // maxLines: 4,
                    ),
                  ),
                  SizedBox(
                      width: isMobile ? 200 : 335,
                      child: Text(
                        'Start practicing today with real exam-style questions and AI-powered feedback',
                        style: TextStyle(
                          color: PColors.white,
                          fontSize: isMobile ? 12 : null,
                        ),
                        textAlign: isMobile ? TextAlign.center : null,
                      )),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: PColors.white,
                         visualDensity:isMobile? const VisualDensity(horizontal: -2, vertical: -2.5): null,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100))),
                    child:  Text(
                      'Join the waitlist',
                      style: TextStyle(color: PColors.primary, fontSize: isMobile? 11:null,  fontWeight:isMobile? FontWeight.w600:  null ),
                    ),
                  )
                ],
              ),
            ),
           
            Positioned(
              bottom:isMobile? 0: 80,
              right:isMobile? 4: 48,
              left: isMobile? 4: null,
              child:
                  RepaintBoundary(child: _buildMockupImage(context, isMobile)),
            ),
            if(!isMobile)
            Positioned(
                left: 0,
                right: 0,
                top: 380,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        '© ${DateTime.now().year} Business School. All Rights Reserved.',
                        style: const TextStyle(color: PColors.deepBlack)),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 22,
                      children: [
                        Text('Instagram',
                            style: TextStyle(color: PColors.deepBlack)),
                        Text('Facebook',
                            style: TextStyle(color: PColors.deepBlack)),
                        Text('Twitter',
                            style: TextStyle(color: PColors.deepBlack)),
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

Widget _buildMockupImage(BuildContext context, bool isMobile) {
  return Stack(
    children: [
      Image.asset(
        PImages.mock,
        height: isMobile ? 258 : 446,
        width: isMobile ? 304 : 527,
        cacheWidth: 527,
        cacheHeight: 446,
      ),
      Positioned(
        top:isMobile?50: 90,
        left:isMobile? 30: 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing:isMobile?5: 20,
          children: [
            Row(
              spacing:isMobile?5: 10,
              children: [
                SizedBox(
                  width: isMobile?30:null,
                  child: const CircleAvatar(
                    backgroundImage: AssetImage(PImages.hero),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ' Welcome Back',
                      style: Theme.of(context).textTheme.labelSmall!.apply(
                          fontWeightDelta: 2,
                          fontSizeDelta:isMobile?-4: -1,
                          color: PColors.primary.withValues(alpha: 0.6)),
                    ),
                    Text(
                      'Chioma',
                      style: Theme.of(context).textTheme.bodySmall!.apply(
                          fontWeightDelta: 3,
                          fontSizeDelta:isMobile?-1:  2,
                          color: PColors.primary),
                    )
                  ],
                )
              ],
            ),
            TRoundedContainer(
              width:isMobile?250: 400,
              height:isMobile?165: 250,
              backgroundColor: PColors.primary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Progress this week',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .apply(fontSizeDelta:isMobile?-3: -1, color: PColors.white),
                  ),
                  const Gap(4),
                   Text(
                    'Overall Score',
                    style: TextStyle(
                        fontSize:isMobile?12: 24,
                        color: PColors.white,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.02),
                  ),
                  if(!isMobile)
                  const Gap(20),
                  if(isMobile)
                  const Gap(5),
                  Center(
                    child: TRoundedContainer(
                      showShadow: true,
              width: isMobile? 220: 360,
              height:isMobile?94: 135,
              radius:isMobile? 12: 16,
                      child: _buildLanguageCard(isMobile),
                    ),
                  ),
                ],
              ),
            ),
            // Gap(10)
          ],
        ),
      )
    ],
  );
}

Widget _buildLanguageCard(bool isMobile) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        spacing: 10,
        children: [
           Stack(
            children: [
              TRoundedContainer(

                  height:isMobile? 16: 24,
          width:isMobile? 16: 24,
          radius:isMobile? 4: 8,
                showBorder: true,
                showShadow: false,
              ),
              Positioned(
                  top: 2,
                  left: 2,
                  child: Icon(
                    Icons.search,
                    color: PColors.primary,
                    size: isMobile? 12: 20,
                  )),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(
                  'Language',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: isMobile? 10: null),
                ),
                buildDropdown(isMobile),
              ],
            ),
          ),
        ],
      ),
              SizedBox(height:isMobile? 8: 20),

       Text(
        'English',
        style: TextStyle(
            fontSize:isMobile? 12: 24, fontWeight: FontWeight.w800, letterSpacing: 1.02),
      ),
      const SizedBox(height:5),
      Row(
        spacing: 5,
        children: [
          TRoundedContainer(
            showBorder: false,
            showShadow: false,
         width:isMobile? 40: 59.5,
              radius: isMobile? 40: 56,
              height:isMobile? 13: 16,
            padding: const EdgeInsets.all(0),
            backgroundColor: PColors.secondary2.withValues(alpha: 0.12),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.show_chart_rounded,
                 size:isMobile? 12: 16,
                  color: PColors.secondary2,
                ),
                Text(
                  '29.9%',
                  style: TextStyle(fontSize:isMobile? 8: 10, color: PColors.secondary2),
                )
              ],
            ),
          ),
          const SizedBox(height: 5),
           Text(
            'from last week',
            style: TextStyle(fontSize:isMobile? 8: 10, color: PColors.dark),
          )
        ],
      )
    ],
  );
}
