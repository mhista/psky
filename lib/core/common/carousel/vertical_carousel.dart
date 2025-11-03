import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CustomCarouselSlider extends StatefulWidget {
  const CustomCarouselSlider({
    super.key,
    required this.items,
    this.height = 230,
    this.autoPlay = true,
    this.autoPlayInterval = const Duration(seconds: 4),
    this.autoPlayAnimationDuration = const Duration(milliseconds: 800),
    this.viewportFractionMobile = 0.8,
    this.viewportFractionDesktop = 0.22,
    this.showIndicator = true,
    this.enableInfiniteScroll = true,
    this.enlargeCenterPage = false,
    this.padEnds = false,
    this.sliderWidthDesktop = 200,
    this.sliderWidthMobile = 100
  });

  final List<Widget> items;
  final double height;
  final bool autoPlay;
  final Duration autoPlayInterval;
  final Duration autoPlayAnimationDuration;
  final double viewportFractionMobile;
  final double viewportFractionDesktop;
  final double sliderWidthDesktop, sliderWidthMobile;
  final bool showIndicator;
  final bool enableInfiniteScroll;
  final bool enlargeCenterPage;
  final bool padEnds;

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  int currentIndex = 0;
  final CarouselSliderController _carouselController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);
    final isMobile = responsive.isMobile;

    return Column(
      children: [
        CarouselSlider(
          carouselController: _carouselController,
          items: widget.items,
          options: CarouselOptions(
            height: widget.height,
            viewportFraction: isMobile
                ? widget.viewportFractionMobile
                : widget.viewportFractionDesktop,
            initialPage: 0,
            enableInfiniteScroll: widget.enableInfiniteScroll,
            reverse: false,
            autoPlay: widget.autoPlay,
            autoPlayInterval: widget.autoPlayInterval,
            autoPlayAnimationDuration: widget.autoPlayAnimationDuration,
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: widget.enlargeCenterPage,
            scrollDirection: Axis.horizontal,
            padEnds: widget.padEnds,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
        if (widget.showIndicator) ...[
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SlidingArrowIndicator(
                sliderWidthDesktop: widget.sliderWidthDesktop,
                sliderWidthMobile: widget.sliderWidthMobile,
                currentIndex: currentIndex,
                totalItems: widget.items.length,
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
      ],
    );
  }
}

class SlidingArrowIndicator extends StatelessWidget {
  final int currentIndex;
  final int totalItems;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final double sliderWidthDesktop, sliderWidthMobile;


  const SlidingArrowIndicator({
    super.key,
    required this.currentIndex,
    required this.totalItems,
    required this.onPrevious,
    required this.onNext,
    this.sliderWidthDesktop = 200,
    this.sliderWidthMobile = 100
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);
    final isMobile = responsive.isMobile;
    double indicatorWidth = isMobile ? sliderWidthMobile : sliderWidthDesktop;
    double thumbWidth = isMobile ? 15 : 20.0;

    return Row(
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

              // Sliding thumb
              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                left: (currentIndex / (totalItems - 1)) *
                    (indicatorWidth - thumbWidth),
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
    );
  }
}