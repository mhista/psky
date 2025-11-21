import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../core/common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../core/utils/constants/colors.dart';

class TestimonialCarousel extends StatefulWidget {
  const TestimonialCarousel({
    super.key,
  });

  @override
  State<TestimonialCarousel> createState() => _TestimonialCarouselState();
}

class _TestimonialCarouselState extends State<TestimonialCarousel> {
  int currentIndex = 0;
  final CarouselSliderController _carouselController = CarouselSliderController();
  
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);
    final isMobile = responsive.isMobile;
    
    // CRITICAL FIX: Ensure we have items before rendering
    if (testimonialsMap.isEmpty) {
      return const SizedBox.shrink();
    }
    
    return Column(
      children: [
        // CRITICAL FIX: Wrap in ConstrainedBox to prevent layout issues
        ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 230,
            maxHeight: 230,
          ),
          child: CarouselSlider(
            carouselController: _carouselController,
            items: testimonialsMap
                .map((e) => Builder( // CRITICAL: Use Builder for proper context
                      builder: (BuildContext context) {
                        return TRoundedContainer(
                          height: 229,
                          width: 240,
                          showBorder: true,
                          backgroundColor: PColors.primary.withValues(alpha: 0.1),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e["comment"]!,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .apply(fontWeightDelta: 2, fontSizeDelta: 1),
                              ),
                              const Gap(68),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e["name"]!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .apply(fontWeightDelta: 2, fontSizeDelta: -2),
                                  ),
                                  Text(
                                    e["location"]!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .apply(fontWeightDelta: 2, fontSizeDelta: -2),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ))
                .toList(),
            options: CarouselOptions(
              height: 230,
              viewportFraction: isMobile ? 0.8 : 0.22,
              initialPage: 0,
              // CRITICAL FIX: Only enable infinite scroll if we have enough items
              enableInfiniteScroll: testimonialsMap.length > 3,
              reverse: false,
              autoPlay: testimonialsMap.length > 1, // Only autoplay if multiple items
              autoPlayInterval: const Duration(seconds: 4),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: false,
              scrollDirection: Axis.horizontal,
              // CRITICAL FIX: Set to true to prevent scroll offset issues
              padEnds: true,
              // CRITICAL FIX: Add pageSnapping for stable scrolling
              pageSnapping: true,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SlidingArrowIndicator(
              currentIndex: currentIndex,
              totalItems: testimonialsMap.length,
              onPrevious: () {
                _carouselController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
              onNext: () {
                _carouselController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
            )
          ],
        )
      ],
    );
  }
}

class SlidingArrowIndicator extends StatelessWidget {
  final int currentIndex;
  final int totalItems;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const SlidingArrowIndicator({
    super.key,
    required this.currentIndex,
    required this.totalItems,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);
    final isMobile = responsive.isMobile;
    double indicatorWidth = isMobile ? 100 : 200.0;
    double thumbWidth = isMobile ? 15 : 20.0;

    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Left Arrow
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: onPrevious,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentIndex > 0 ? Colors.grey[300] : Colors.grey[200],
                  boxShadow: currentIndex > 0
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: isMobile ? 10 : 16,
                  color: currentIndex > 0 ? Colors.grey[700] : Colors.grey[400],
                ),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Sliding Indicator
          SizedBox(
            width: indicatorWidth,
            height: 6,
            child: Stack(
              children: [
                // Background track
                Container(
                  width: indicatorWidth,
                  height: isMobile ? 4 : 6,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),

                // Sliding thumb - CRITICAL FIX: Handle edge cases
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  left: totalItems > 1
                      ? (currentIndex / (totalItems - 1)) * (indicatorWidth - thumbWidth)
                      : 0,
                  child: Container(
                    width: thumbWidth,
                    height: isMobile ? 4 : 6,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).primaryColor.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // Right Arrow
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: onNext,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentIndex < totalItems - 1
                      ? Colors.grey[300]
                      : Colors.grey[200],
                  boxShadow: currentIndex < totalItems - 1
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: isMobile ? 10 : 16,
                  color: currentIndex < totalItems - 1
                      ? Colors.grey[700]
                      : Colors.grey[400],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<Map<String, String>> testimonialsMap = [
  {
    "name": "Chioma",
    "location": "Imo State",
    "comment":
        "This app feels exactly like sitting for WAEC. The timed tests and instant results keep me sharp.",
  },
  {
    "name": "David",
    "location": "Lagos State",
    "comment":
        "The AI feedback is like having a personal tutor. It shows me where I'm weak and what to revise next.",
  },
  {
    "name": "Amina",
    "location": "Kano State",
    "comment":
        "I love that I can practice on my phone even with little data. It saves my progress and I just continue anytime.",
  },
  {
    "name": "Emeka",
    "location": "Delta State",
    "comment":
        "Tracking my progress gave me confidence. I can see my scores go up each week.",
  },
  {
    "name": "Blessing",
    "location": "Edo State",
    "comment":
        "The questions are exactly like past WAEC papers. Practicing here made me less anxious about the real exam",
  },
];