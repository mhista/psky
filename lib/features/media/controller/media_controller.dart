import 'dart:typed_data';

import 'package:ahiaa_web/common/loaders/loaders.dart';
import 'package:ahiaa_web/data/repositories/media_repository/media_repo.dart';
import 'package:ahiaa_web/utils/constants/enums.dart';
import 'package:ahiaa_web/utils/constants/image_strings.dart';
import 'package:ahiaa_web/utils/constants/sizes.dart';
import 'package:ahiaa_web/utils/constants/text_strings.dart';
import 'package:ahiaa_web/utils/popups/dialog.dart';
import 'package:ahiaa_web/utils/popups/fullscreen_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart' as html;
import 'package:path_provider/path_provider.dart';

import '../models/image_model.dart';

class MediaController extends GetxController {
  static MediaController get instance => Get.find();
  late DropzoneViewController dropzoneController;
  final Rx<MediaCategory> selectedPath = MediaCategory.folders.obs;
  final RxBool showImagesUploaderSection = false.obs;
  final RxList<ImageModel> selectedImagesToUpload = <ImageModel>[].obs;

  // images list
  RxList<ImageModel> allImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBannerImages = <ImageModel>[].obs;
  final RxList<ImageModel> allProductImages = <ImageModel>[].obs;
  final RxList<ImageModel> allCategoryImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBrandImages = <ImageModel>[].obs;
  final RxList<ImageModel> allUserImages = <ImageModel>[].obs;

  final MediaRepository mediaRepository = Get.put(MediaRepository());

  Future<void> selectLocalImages() async {
    final files = await dropzoneController
        .pickFiles(multiple: true, mime: ["image/jpeg", "image/png"]);

    if (files.isNotEmpty) {
      for (var file in files) {
        //  debugPrint('onDropFile one : ${file.name}');
        final mimeType = await dropzoneController.getFileMIME(file);
        final bytes = await dropzoneController.getFileData(file);
        debugPrint('${file.name}, $mimeType');

        final filee = uint8ListToFile(bytes, file.name, mimeType);
        final image = ImageModel(
            url: '',
            folder: '',
            filename: file.name,
            localImageToDisplay: Uint8List.fromList(bytes),
            file: filee);

        selectedImagesToUpload.add(image);
      }
    }
  }

  // convert to uInt8List to FILE
  html.File uint8ListToFile(
      Uint8List uint8list, String fileName, String mimeType) {
    try {
      final blob = html.Blob([uint8list], mimeType);
      final file = html.File([blob], fileName, {'type': mimeType});
      // debugPrint(file.name.toString());
      return file;
    } catch (e) {
      throw Exception('Error converting Uint8List to File: $e');
    }
  }

  // confirm image upload
  void uploadImageConfirmation() {
    if (selectedPath.value == MediaCategory.folders) {
      PLoaders.warningSnackBar(
          title: 'Select Folder',
          message: 'Please select the Folder in Order to upload the images');
      return;
    }

    PDialogs.defaultDialog(
        context: Get.context!,
        title: 'Upload Images',
        confirmText: 'Upload',
        onCancel: () => Get.back(),
        onConfirm: () async => await uploadImages(),
        content:
            'Are you sure you want to upload all the images in ${selectedPath.value.name.toUpperCase()} folder?');
  }

  // upload images to firebase
  Future<void> uploadImages() async {
    try {
      // Remove confirmation box
      Get.back();

      // Loader
      uploadImagesLoader();

      MediaCategory selectedCategory = selectedPath.value;

      // get the corresponding list to update
      RxList<ImageModel> targetList;

      // check the selected category and update the corresponding list
      switch (selectedCategory) {
        case MediaCategory.banners:
          targetList = allBannerImages;
          break;
        case MediaCategory.products:
          targetList = allProductImages;
          break;
        case MediaCategory.categories:
          targetList = allCategoryImages;
          break;
        case MediaCategory.brands:
          targetList = allBrandImages;
          break;
        case MediaCategory.users:
          targetList = allUserImages;
          break;
        default:
          return;
      }
      // upload and add images to the target list
      //  using a reverse loop to avoid 'Concurrent modification during iteration' error
      for (var i = selectedImagesToUpload.length - 1; i >= 0; i--) {
        var selectedImage = selectedImagesToUpload[i];
        final image = selectedImage.file;
        // upload image to the storage
        final ImageModel uploadedImage =
            await mediaRepository.uploadImageFileInStorage(
                file: image!,
                path: getSelectedPath(),
                imageName: selectedImage.filename);

        // upload image to firestore
        uploadedImage.mediaCategory = selectedCategory.name;
        final id = await mediaRepository.uploadImageInFirestore(uploadedImage);

        uploadedImage.id = id;
        selectedImagesToUpload.removeAt(i);
        targetList.add(uploadedImage);
      }

      // Stop loader after successful upload
      PFullScreenLoader.stopLoading();
    } catch (e) {
      // Stop Loader in case of an error
      PFullScreenLoader.stopLoading();

      // Show a warning snack bar for the error
      PLoaders.warningSnackBar(
          title: 'Error Uploading Images',
          message: 'Something went wrong while uploading images');
    }
  }

  // upload images loader
  void uploadImagesLoader() {
    showDialog(
      context: Get.context!,
      builder: (context) => PopScope(
        child: AlertDialog(
          title: const Text('Uploading Images'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                PImages.loading,
                height: 300,
                width: 300,
              ),
              const SizedBox(
                height: PSizes.spaceBtwItems,
              ),
              const Text('Sit Tight, Your images are being uploaded')
            ],
          ),
        ),
      ),
    );
  }

  //get the selected image path
  String getSelectedPath() {
    String path = '';
    switch (selectedPath.value) {
      case MediaCategory.banners:
        path = PTexts.bannersStoragePath;
        break;
      case MediaCategory.products:
        path = PTexts.productsStoragePath;
        break;
      case MediaCategory.categories:
        path = PTexts.categoriesStoragePath;
        break;
      case MediaCategory.brands:
        path = PTexts.brandsStoragePath;
        break;
      case MediaCategory.users:
        path = 'users';
        break;
      default:
        path = 'others';
    }
    return path;
  }
}
