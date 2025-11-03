import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../styles/spacing_styles.dart';

class FormTemplate extends StatelessWidget {
  const FormTemplate({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 500,
        child: SingleChildScrollView(
          child: Container(
              padding: PSpacingStyle.paddingWithAppBarHeight,
              decoration: BoxDecoration(
                  color: PColors.white,
                  borderRadius: BorderRadius.circular(
                    PSizes.cardRadiusLg,
                  )),
              child: child),
        ),
      ),
    );
  }
}
