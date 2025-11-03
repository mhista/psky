import 'package:ahiaa_web/features/landing/screen/widgets/section_header.dart';
import 'package:ahiaa_web/features/landing/screen/widgets/testimonial_carousel.dart';
import 'package:flutter/material.dart';

Widget buildTestimonialsSection() {
    return const RepaintBoundary(
      child: Column(
        spacing: 32,
        children: [
          SectionHeader(
              subtitle:
                  'Real stories from learners preparing with our platform',
              title: 'What Students say'),
          TestimonialCarousel(),
        ],
      ),
    );
  }