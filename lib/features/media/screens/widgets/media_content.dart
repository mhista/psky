import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../core/common/widgets/images/edge_rounded_images.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../../core/utils/constants/image_strings.dart';
import '../../controller/media_controller.dart';
import 'folder_dropdown.dart';

class MediaContent extends StatelessWidget {
  const MediaContent({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);
    final controller = MediaController.instance;

    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // MEDIA IMAGES HEADER
          Row(
            children: [
              if (!responsive.isMobile)
                Text(
                  'Select Folder',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .apply(fontSizeDelta: responsive.isMobile ? -2 : 0),
                ),
              if (!responsive.isMobile)
                const SizedBox(
                  width: PSizes.spaceBtwItems,
                ),
              // MEDIA FOLDER DROPDOWN
              MediaFolderDropdown(
                onChanged: (MediaCategory? newValue) {
                  if (newValue != null) {
                    controller.selectedPath.value = newValue;
                  }
                },
              )
            ],
          ),
          const SizedBox(
            height: PSizes.spaceBtwSections,
          ),
          // SHOW MEDIA
          const Wrap(
            alignment: WrapAlignment.start,
            spacing: PSizes.spaceBtwItems / 2,
            runSpacing: PSizes.spaceBtwItems / 2,
            children: [
              PRoundedImage(
                imageType: ImagesType.asset,
                image: PImages.google,
                width: 90,
                height: 90,
                padding: PSizes.sm,
                // memoryImage: element.localImageToDisplay,
                backgroundColor: PColors.primaryBackground,
              ),
              PRoundedImage(
                imageType: ImagesType.asset,
                image: PImages.google,
                width: 90,
                height: 90,
                padding: PSizes.sm,
                // memoryImage: element.localImageToDisplay,
                backgroundColor: PColors.primaryBackground,
              ),
            ],
          ),
          const SizedBox(
            height: PSizes.spaceBtwItems,
          ),

          // LOAD MORE MEDIA
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: PSizes.spaceBtwSections),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: PSizes.buttonWidth,
                  child: ElevatedButton.icon(
                      onPressed: () {},
                      label: const Text('Load More'),
                      icon: const Icon(Iconsax.arrow_down)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
