import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/sizes.dart';
import '../shimmer/shimmer.dart';

class PRoundedImage extends StatelessWidget {
  const PRoundedImage({
    super.key,
    this.image,
    this.width = 56,
    this.height = 56,
    this.applyImageRadius = true,
    this.isNetworkImage = false,
    this.backgroundColor = PColors.light,
    this.fit = BoxFit.fill,
    this.padding = 0,
    this.onPressed,
    this.border,
    this.borderRadius = PSizes.md,
    required this.imageType,
    this.file,
    this.memoryImage,
    this.overlayColor,
    this.margin = 0,
  });
  final String? image;
  final double width, height;
  final bool applyImageRadius, isNetworkImage;
  final Color? overlayColor, backgroundColor;
  final BoxFit? fit;
  final BoxBorder? border;
  final double padding, margin;
  final VoidCallback? onPressed;
  final double borderRadius;
  final ImageType imageType;
  final File? file;
  final Uint8List? memoryImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          margin: margin != 0 ? EdgeInsets.all(margin) : null,
          padding: EdgeInsets.all(padding),
          height: height,
          width: width,
          decoration: BoxDecoration(
            border: border,
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: _buildImageWidget()),
    );
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
      borderRadius: applyImageRadius
          ? BorderRadius.circular(borderRadius)
          : BorderRadius.zero,
      child: imageWidget,
    );
  }

  // build network image
  Widget _buildNetworkImage() {
    if (image != null) {
      return CachedNetworkImage(
        imageUrl: image!,
        fit: fit,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            PShimmerEffect(
          color: backgroundColor,
          height: height,
          width: width,
          radius: borderRadius,
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
