import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class LoadingAnimator extends StatelessWidget {
  const LoadingAnimator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: LoadingAnimationWidget.inkDrop(color: PColors.white, size: 50),
    );
  }
}
