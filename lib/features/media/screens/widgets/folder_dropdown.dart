import 'package:ahiaa_web/features/media/controller/media_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../utils/constants/enums.dart';

class MediaFolderDropdown extends StatelessWidget {
  const MediaFolderDropdown({super.key, this.onChanged});

  final void Function(MediaCategory?)? onChanged;

  @override
  Widget build(BuildContext context) {
    // final responsive = ResponsiveBreakpoints.of(context);

    final controller = MediaController.instance;
    return Obx(() {
      return SizedBox(
        width: 140,
        child: DropdownButtonFormField(
          isExpanded: false,
          value: controller.selectedPath.value,
          items: MediaCategory.values
              .map((category) => DropdownMenuItem(
                  value: category,
                  child: Text(category.name.capitalize.toString())))
              .toList(),
          onChanged: onChanged,
        ),
      );
    });
  }
}
