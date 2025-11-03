
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/features/media/controller/media_controller.dart';
import 'package:ahiaa_web/features/media/screens/widgets/folder_dropdown.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/utils/enums/enums.dart';
import 'package:ahiaa_web/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../../core/common/widgets/images/edge_rounded_images.dart';
import '../../../../core/utils/constants/image_strings.dart';

class MediaUploader extends StatelessWidget {
  const MediaUploader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MediaController.instance;
    final responsive = ResponsiveBreakpoints.of(context);
    return Obx(() {
      return !controller.showImagesUploaderSection.value
          ? const SizedBox.shrink()
          : Column(
              children: [
                // DRAG AND DROP AREA
                TRoundedContainer(
                  showBorder: true,
                  height: 250,
                  borderColor: PColors.borderPrimary,
                  backgroundColor: PColors.primaryBackground,
                  padding: const EdgeInsets.all(PSizes.defaultSpace),
                  child: Column(
                    children: [
                      Expanded(
                          child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // DropzoneView(
                          //   mime: const ['image/jpeg', 'image/png'],
                          //   cursor: CursorType.Default,
                          //   operation: DragOperation.copy,
                          //   onLoaded: () {
                          //     debugPrint('Zone Loaded');
                          //   },
                          //   onError: (er) {
                          //     debugPrint('Zone error: $er');
                          //   },
                          //   onHover: () {
                          //     debugPrint('Zone hovered');
                          //   },
                          //   onLeave: () {
                          //     debugPrint('Zone left');
                          //   },
                          //   onCreated: (ctrl) =>
                          //       controller.dropzoneController = ctrl,
                          //   onDropFile: (filee) async {
                          //     debugPrint('onDropFile one : ${filee.name}');
                          //     final mimeType = await controller
                          //         .dropzoneController
                          //         .getFileMIME(filee);
                          //     final bytes = await controller.dropzoneController
                          //         .getFileData(filee);
                          //     debugPrint(' ${filee.name}, $mimeType');

                          //     final file = controller.uint8ListToFile(
                          //         bytes, filee.name, mimeType);
                          //     final image = ImageModel(
                          //         url: '',
                          //         folder: '',
                          //         filename: filee.name,
                          //         localImageToDisplay:
                          //             Uint8List.fromList(bytes),
                          //         file: file);

                          //     controller.selectedImagesToUpload.add(image);
                          //   },
                          //   onDropInvalid: (er) {},
                          //   onDropFiles: (files) {
                          //     debugPrint(
                          //         'onDropFiles multiplication : ${files?.first.name}');
                          //   },
                          // ),
                          Column(
                            children: [
                              Image.asset(PImages.defaultMultiImageIcon),
                              const SizedBox(
                                height: PSizes.spaceBtwItems,
                              ),
                              const Text('Drag and Drop Images here'),
                              const SizedBox(
                                height: PSizes.spaceBtwItems,
                              ),
                              OutlinedButton(
                                  onPressed: () =>
                                      controller.selectLocalImages(),
                                  child: const Text('Select Images'))
                            ],
                          )
                        ],
                      ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: PSizes.spaceBtwItems,
                ),
                // LOCALLY SELECTED IMAGE
                if (controller.selectedImagesToUpload.isNotEmpty)
                  TRoundedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // FOLDERS DROPDOWN
                            Row(
                              children: [
                                if (!responsive.isMobile)
                                  Text(
                                    'Select Folder',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .apply(
                                            fontSizeDelta:
                                                responsive.isMobile ? -2 : 0),
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
                            // UPLOAD AND REMOVE IMAGES
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () =>
                                      controller.selectedImagesToUpload.clear(),
                                  child: const Text(
                                    'Remove All',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(
                                  width: PSizes.spaceBtwItems,
                                ),
                                responsive.isMobile
                                    ? const SizedBox.shrink()
                                    : SizedBox(
                                        width: PSizes.buttonWidth,
                                        child: ElevatedButton(
                                            onPressed: () => controller
                                                .uploadImageConfirmation(),
                                            child: const Text('Upload')),
                                      )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: PSizes.spaceBtwItems,
                        ),
                        Wrap(
                            alignment: WrapAlignment.start,
                            spacing: PSizes.spaceBtwItems / 2,
                            runSpacing: PSizes.spaceBtwItems / 2,
                            children: controller.selectedImagesToUpload
                                .where((image) =>
                                    image.localImageToDisplay != null)
                                .map(
                                  (image) => PRoundedImage(
                                    imageType: ImagesType.memory,
                                    memoryImage: image.localImageToDisplay,
                                    width: 90,
                                    height: 90,
                                    padding: PSizes.sm,
                                    // memoryImage: element.localImageToDisplay,
                                    backgroundColor: PColors.primaryBackground,
                                  ),
                                )
                                .toList()),
                        const SizedBox(
                          height: PSizes.spaceBtwItems,
                        ),
                        responsive.isMobile
                            ? SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () =>
                                      controller.uploadImageConfirmation(),
                                  child: const Text('Upload'),
                                ))
                            : const SizedBox.shrink()
                      ],
                    ),
                  )
              ],
            );
    });
  }
}
