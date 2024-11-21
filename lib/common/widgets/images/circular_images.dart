import 'dart:io';

import 'package:ahiaa_web/utils/constants/enums.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../shimmer/shimmer.dart';

class PCircularImage extends StatelessWidget {
  const PCircularImage({
    super.key,
    this.image,
    this.width = 56,
    this.height = 56,
    this.padding = PSizes.xs,
    this.isNetworkImage = false,
    this.backgroundColor,
    this.fit = BoxFit.cover,
    this.overLayColor,
    this.overlayColor,
    this.file,
    this.imageType = ImageType.asset,
    this.memoryImage,
  });

  final String? image;
  final double width, height, padding;
  final bool isNetworkImage;
  final Color? backgroundColor, overlayColor;
  final File? file;
  final ImageType imageType;
  final Uint8List? memoryImage;
  final BoxFit? fit;
  final Color? overLayColor;

  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunctions.isDarkMode(context);
    return Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
            color: backgroundColor ??
                (isDark ? PColors.dark : PColors.transparent),
            borderRadius: BorderRadius.circular(100)),
        child: _buildImageWidget());
  }

  Widget _buildImageWidget() {
    Widget imageWidget;

    switch (imageType) {
      case ImageType.network:
        imageWidget = _buildNetworkImage();
        break;
      case ImageType.file:
        imageWidget = _buildFileImage();
        break;
      case ImageType.memory:
        imageWidget = _buildMemoryImage();
        break;
      case ImageType.asset:
        imageWidget = _buildAssetImage();
        break;
    }
    // apply ClipRect to the image widget directly
    return ClipRRect(
      borderRadius: BorderRadius.circular(width >= height ? width : height),
      child: imageWidget,
    );
  }

  // build network image
  Widget _buildNetworkImage() {
    if (image != null) {
      return CachedNetworkImage(
        imageUrl: image!,
        color: overLayColor,
        fit: fit,
        height: height,
        width: width,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            const PShimmerEffect(
          height: 100,
          width: 100,
          radius: 100,
        ),
      );
    } else {
      return Container();
    }
  }

  // build file image
  Widget _buildFileImage() {
    if (file != null) {
      return Image(
        fit: fit,
        image: FileImage(
          file!,
        ),
        color: overlayColor,
      );
    } else {
      return Container();
    }
  }

  // build memory image
  Widget _buildMemoryImage() {
    if (memoryImage != null) {
      return Image(
        fit: fit,
        image: MemoryImage(memoryImage!),
        color: overlayColor,
      );
    } else {
      return Container();
    }
  }

  // build asset image
  Widget _buildAssetImage() {
    if (image != null) {
      return Image.asset(
        image!,
        fit: fit,
        color: overlayColor,
      );
    } else {
      return Container();
    }
  }
}
