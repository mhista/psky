import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ahiaa_web/core/common/widgets/images/edge_rounded_images.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/routes/app_router2.dart';
import 'package:ahiaa_web/core/routes/routes.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/utils/enums/enums.dart';
import 'package:ahiaa_web/core/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class BuildHeroSection extends StatelessWidget {
  const BuildHeroSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);
    final isMobile = responsive.isMobile;
    return RepaintBoundary(
      child: isMobile
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              // alignment: WrapAlignment.center,
              // crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                // Description
                TRoundedContainer(
                  width: 534,
                  backgroundColor: Colors.transparent,
                  showShadow: false,
                  child: Column(
                    crossAxisAlignment: isMobile
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                    spacing: isMobile ? 4 : 12,
                    children: [
                      if (isMobile) const SizedBox(height: 12),

                      Text(
                        'Practice like the real WAEC — pass with confidence.',
                        textAlign: isMobile ? TextAlign.center : null,

                        style: Theme.of(context).textTheme.headlineLarge!.apply(
                              fontWeightDelta: 1,
                              fontSizeDelta: isMobile ? -4 : 7,
                            ),
                        // softWrap: true,
                        // maxLines: 4,
                      ),
                      Text(
                        'Join thousands of students preparing with exam-accurate mocks, instant topic breakdowns and focused practice plans. Sign up to start.',
                        style: TextStyle(fontSize: isMobile ? 12 : null),
                        textAlign: isMobile ? TextAlign.center : null,
                      ),
                      // if(!isMobile)
                      const SizedBox(height: 12),
                      if (!isMobile)
                        SizedBox(
                          width: 434,
                          child: PSearchContainer(
                            text: '',
                            enabled: false,
                            textFieldWidget: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                  onPressed: () {
                                    AppRouter.markLandingPageCompleted();
                                    getIt<AppRouter>()
                                        .router
                                        .goNamed(KRoutes.auth);
                                  },
                                  child: const Text('Sign up')),
                            ),
                            usePrefixSuffix: true,
                          ),
                        ),
                      if (isMobile)
                        ElevatedButton(
                          onPressed: () {
                            AppRouter.markLandingPageCompleted();
                            getIt<AppRouter>().router.goNamed(KRoutes.auth);
                          },
                          style: ElevatedButton.styleFrom(
                              visualDensity: isMobile
                                  ? const VisualDensity(
                                      horizontal: -2, vertical: -2.5)
                                  : null,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100))),
                          child: Text(
                            'Get Started',
                            style: TextStyle(
                                fontSize: isMobile ? 11 : null,
                                fontWeight: isMobile ? FontWeight.w600 : null),
                          ),
                        )
                    ],
                  ),
                ),
                // Hero Image with improved performance
                RepaintBoundary(
                  child: TRoundedContainer(
                    showShadow: false,
                    height: isMobile ? 350 : 579,
                    child: _buildHeroImageStack(isMobile),
                  ),
                )
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              // alignment: WrapAlignment.center,
              // crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                // Description
                TRoundedContainer(
                  width: 534,
                  backgroundColor: Colors.transparent,
                  showShadow: false,
                  child: Column(
                    crossAxisAlignment: isMobile
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                    spacing: isMobile ? 4 : 12,
                    children: [
                      if (isMobile) const SizedBox(height: 12),

                      Text(
                        'Practice like the real WAEC — pass with confidence.',
                        textAlign: isMobile ? TextAlign.center : null,

                        style: Theme.of(context).textTheme.headlineLarge!.apply(
                              fontWeightDelta: 1,
                              fontSizeDelta: isMobile ? -4 : 7,
                            ),
                        // softWrap: true,
                        // maxLines: 4,
                      ),
                      Text(
                        'Join thousands of students preparing with exam-accurate mocks, instant topic breakdowns and focused practice plans. Sign up to start.',
                        style: TextStyle(fontSize: isMobile ? 12 : null),
                        textAlign: isMobile ? TextAlign.center : null,
                      ),
                      // if(!isMobile)
                      const SizedBox(height: 12),
                      if (!isMobile)
                        SizedBox(
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () {
                              AppRouter.markLandingPageCompleted();
                              getIt<AppRouter>().router.goNamed(KRoutes.auth);
                            },
                            child: const Text('Get started'),
                          ),
                        ),
                      if (isMobile)
                        ElevatedButton(
                          onPressed: () {
                            AppRouter.markLandingPageCompleted();
                            getIt<AppRouter>().router.goNamed(KRoutes.auth);
                          },
                          style: ElevatedButton.styleFrom(
                              visualDensity: isMobile
                                  ? const VisualDensity(
                                      horizontal: -2, vertical: -2.5)
                                  : null,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100))),
                          child: Text(
                            'Get Started',
                            style: TextStyle(
                                fontSize: isMobile ? 11 : null,
                                fontWeight: isMobile ? FontWeight.w600 : null),
                          ),
                        )
                    ],
                  ),
                ),
                // Hero Image with improved performance
                RepaintBoundary(
                  child: TRoundedContainer(
                    showShadow: false,
                    height: isMobile ? 350 : 579,
                    child: _buildHeroImageStack(isMobile),
                  ),
                )
              ],
            ),
    );
  }
}

Widget _buildHeroImageStack(bool isMobile) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      // Use Image.asset with cacheWidth/cacheHeight for better performance
      SizedBox(
        width: isMobile ? 400 : 600,
        height: isMobile ? 350 : 574,
        child: Image.asset(
          PImages.hero,
          width: isMobile ? 400 : 600,
          height: isMobile ? 275 : 574,
          cacheWidth: 600,
          cacheHeight: 574,
          fit: BoxFit.cover,
        ),
      ),
      Positioned(
        top: isMobile ? 120 : 199,
        right: isMobile ? -25 : 36,
        child: RepaintBoundary(
          child: TRoundedContainer(
            showShadow: true,
            width: isMobile ? 150 : 230,
            height: isMobile ? 100 : 157,
            radius: isMobile ? 12 : 16,
            child: Column(
              spacing: isMobile ? 7 : 13,
              children: [
                Row(
                  spacing: 10,
                  children: [
                    _buildRadioButton(isMobile),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Improvement',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: isMobile ? 10 : null),
                          ),
                          Icon(
                            Icons.more_horiz_rounded,
                            weight: isMobile ? 2 : 5,
                            size: isMobile ? 16 : 20,
                          ),
                        ],
                      ),
                    ),
                    if (!isMobile) const SizedBox(width: 5)
                  ],
                ),
                PRoundedImage(
                  imageType: ImagesType.asset,
                  image: PImages.wave,
                  width: isMobile ? 100 : 190,
                  height: isMobile ? 44 : 80,
                ),
              ],
            ),
          ),
        ),
      ),
      Positioned(
        top: isMobile ? 258 : 428,
        left: isMobile ? 10 : 30,
        child: RepaintBoundary(
          child: TRoundedContainer(
            showShadow: true,
            width: isMobile ? 180 : 266,
            height: isMobile ? 90 : 135,
            radius: isMobile ? 12 : 16,
            child: _buildSubjectCard(isMobile),
          ),
        ),
      )
    ],
  );
}

Widget _buildRadioButton(bool isMobile) {
  return Stack(
    children: [
      TRoundedContainer(
        height: isMobile ? 16 : 24,
        width: isMobile ? 16 : 24,
        radius: isMobile ? 4 : 8,
        showBorder: true,
        showShadow: false,
      ),
      Positioned(
        top: 4,
        left: 4,
        child: TRoundedContainer(
          height: isMobile ? 8 : 16,
          width: isMobile ? 8 : 16,
          radius: 100,
          showShadow: false,
          showBorder: true,
          borderColor: PColors.primary,
        ),
      ),
      Positioned(
        top: isMobile ? 5.3 : 6.5,
        left: isMobile ? 5.3 : 6.5,
        child: TRoundedContainer(
          height: isMobile ? 5.33 : 11.33,
          width: isMobile ? 5.33 : 11.33,
          radius: 100,
          showShadow: false,
          showBorder: false,
          backgroundColor: PColors.primary,
        ),
      ),
    ],
  );
}

Widget _buildSubjectCard(bool isMobile) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        spacing: 10,
        children: [
          Stack(
            children: [
              TRoundedContainer(
                height: isMobile ? 16 : 24,
                width: isMobile ? 16 : 24,
                radius: isMobile ? 4 : 8,
                showBorder: true,
                showShadow: false,
              ),
              Positioned(
                  top: 2,
                  left: 2,
                  child: Icon(
                    Icons.search,
                    color: PColors.primary,
                    size: isMobile ? 12 : 20,
                  )),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subject',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: isMobile ? 10 : null),
                ),
                buildDropdown(isMobile),
              ],
            ),
          ),
        ],
      ),
      SizedBox(height: isMobile ? 8 : 20),
      Text(
        'All Subjects',
        style: TextStyle(
            fontSize: isMobile ? 12 : 24,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.02),
      ),
      const SizedBox(height: 2),
      Row(
        spacing: 5,
        children: [
          TRoundedContainer(
            showBorder: false,
            showShadow: false,
            width: isMobile ? 40 : 59.5,
            radius: isMobile ? 40 : 56,
            height: isMobile ? 13 : 16,
            padding: const EdgeInsets.all(0),
            backgroundColor: PColors.secondary2.withValues(alpha: 0.12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.show_chart_rounded,
                  size: isMobile ? 12 : 16,
                  color: PColors.secondary2,
                ),
                Text(
                  '78.9%',
                  style: TextStyle(
                      fontSize: isMobile ? 8 : 10, color: PColors.secondary2),
                )
              ],
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'from last week',
            style: TextStyle(fontSize: isMobile ? 8 : 10, color: PColors.dark),
          )
        ],
      )
    ],
  );
}

Widget buildDropdown(bool isMobile) {
  return Stack(
    children: [
      TRoundedContainer(
        backgroundColor: Colors.transparent,
        width: isMobile ? 70 : 97,
        height: isMobile ? 18 : 24,
        radius: isMobile ? 6 : 8,
        showBorder: true,
        showShadow: false,
      ),
      Positioned(
        top: 3,
        left: isMobile ? 10 : 13,
        child: Row(
          spacing: 5,
          children: [
            Text(
              'This week',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: PColors.dark,
                  fontSize: isMobile ? 8 : 11),
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: isMobile ? 12 : 17,
            )
          ],
        ),
      ),
    ],
  );
}
