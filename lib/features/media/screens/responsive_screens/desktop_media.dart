import 'package:ahiaa_web/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:ahiaa_web/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../controller/media_controller.dart';
import '../widgets/media_content.dart';
import '../widgets/media_uploader.dart';

class MediaDesktopScreen extends StatelessWidget {
  const MediaDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MediaController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(PSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // BREADCRUMBS
                  const PBreadcrumbsWithHeading(
                    heading: 'Media',
                    breadcrumbItems: [],
                  ),

                  SizedBox(
                    width: PSizes.buttonWidth * 1.5,
                    child: ElevatedButton.icon(
                      onPressed: ()=>controller.showImagesUploaderSection.value=!controller.showImagesUploaderSection.value,
                      label: const Text('Upload Images'),
                      icon: const Icon(Iconsax.cloud_add), 
                    ),
                  )
                ],
              ),
              const SizedBox(height: PSizes.spaceBtwSections),
              // UPLOAD AREA
              const MediaUploader(),
              // MEDIA
              const MediaContent()
            ],
          ),
        ),
      ),
    );
  }
}
