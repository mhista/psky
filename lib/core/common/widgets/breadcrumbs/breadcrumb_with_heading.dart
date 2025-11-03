import 'package:ahiaa_web/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/sizes.dart';
import '../texts/section_heading.dart';

class PBreadcrumbsWithHeading extends StatelessWidget {
  const PBreadcrumbsWithHeading(
      {super.key,
      required this.heading,
      required this.breadcrumbItems,
      this.returnToPreviousScreen = false});

  // the heading of the current page
  final String heading;
  // list of breadcrumb items representing the navigation path
  final List<String> breadcrumbItems;
  // Flag indicating whether to include a button to return to the previous screen
  final bool returnToPreviousScreen;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // breadcrumbs trail
        Row(
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(PSizes.borderRadiusMd),
              onTap: () => Get.offAllNamed(KRoutes.home),
              child: Padding(
                padding: const EdgeInsets.all(PSizes.xs),
                child: Text(
                  'DashBoard',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .apply(fontWeightDelta: -1),
                ),
              ),
            ),
            for (int i = 0; i < breadcrumbItems.length; i++)
              Row(
                children: [
                  const Text('/'), //separator,
                  InkWell(
                    borderRadius: BorderRadius.circular(PSizes.borderRadiusMd),
                    onTap: i == breadcrumbItems.length - 1
                        ? null
                        : () => Get.toNamed(breadcrumbItems[i]),
                    child: Padding(
                      padding: const EdgeInsets.all(PSizes.xs),
                      child: Text(
                        // format breadcrumb item: capitalize and remove '/'
                        i == breadcrumbItems.length - 1
                            ? breadcrumbItems[i].capitalize.toString()
                            : capitalize(breadcrumbItems[i].substring(1)),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .apply(fontWeightDelta: -1),
                      ),
                    ),
                  ),
                ],
              )
          ],
        ),
        const SizedBox(
          height: PSizes.sm,
        ),
        if (returnToPreviousScreen)
          IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Iconsax.arrow_left)),
        if (returnToPreviousScreen) const SizedBox(width: PSizes.spaceBtwItems),
        PSectionHeading(
          title: heading,
        )
      ],
    );
  }

  String capitalize(String s) {
    return s.isEmpty ? '' : s[0].toUpperCase() + s.substring(1);
  }
}
