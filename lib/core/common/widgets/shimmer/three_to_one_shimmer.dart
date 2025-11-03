import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/shimmer/shimmer.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class ThreeToOneShimmer extends StatelessWidget {
  const ThreeToOneShimmer(
      {super.key,
      this.isLoading = true,
      this.hasError = false,
      this.hasData = false,
      this.shouldUseLoadedData = false,
      this.shouldCenter = true,
      this.useFunction = false,
      required this.loadedWidget,
      this.canReload = false,
      this.height = 0,
      this.width = 0,
      this.maxWidth,
      this.maxHeight,
      this.radius = 0,
      this.callBack,
      this.errorColor,
      this.errorButtonText = 'Retry',
      this.shimmerColor,
      this.errorText = ''});
  final bool isLoading,
      hasError,
      hasData,
      canReload,
      shouldUseLoadedData,
      shouldCenter,
      useFunction;
  final Widget loadedWidget;
  final double height, width, radius;
  final double? maxWidth, maxHeight;
  final Function()? callBack;
  final Color? errorColor, shimmerColor;
  final String errorText, errorButtonText;
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return PShimmerEffect(
        height: maxHeight ?? height,
        width: maxWidth ?? width,
        radius: radius,
        color: shimmerColor,
      );
    } else if (hasError) {
      return shouldUseLoadedData
          ? loadedWidget
          : TRoundedContainer(
              width: width,
              height: height,
              radius: radius,
              backgroundColor: errorColor,
              child: !shouldCenter?Row(
                spacing: 10,
                children: [
                  const Icon(
                    Icons.info_rounded,
                    color: PColors.bg2,
                  ),
                  Text(
                    errorText,
                    textAlign:
                        shouldCenter ? TextAlign.center : TextAlign.start,
                    style: const TextStyle(
                      fontSize: 11,
                      color: PColors.bg4,
                    ),
                  ),
                 
                ],
              ) :Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: [
                  const Icon(
                    Icons.info_rounded,
                    color: PColors.bg2,
                  ),
                  Text(
                    errorText,
                    textAlign:
                        shouldCenter ? TextAlign.center : TextAlign.start,
                    style: const TextStyle(
                      fontSize: 11,
                      color: PColors.bg4,
                    ),
                  ),
                  if (useFunction)
                    ElevatedButton(
                      onPressed: ()=> callBack,
                      style: ElevatedButton.styleFrom(
                            overlayColor:PColors.bg2 ,
                            foregroundColor: PColors.bg2,
                          backgroundColor: PColors.bg2),
                      child:  Text(errorButtonText,
                          style:const TextStyle(color: PColors.white, fontSize: 13)),
                    )
                ],
              ),
            );
    } else {
      return loadedWidget;
    }
  }
}
