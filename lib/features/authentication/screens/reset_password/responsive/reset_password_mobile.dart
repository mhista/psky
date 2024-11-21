import 'package:ahiaa_web/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/styles/spacing_styles.dart';
import '../../../../../common/widgets/emailing/reusable_email.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/text_strings.dart';

class ResetPasswordMobile extends StatelessWidget {
  const ResetPasswordMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final email = Get.parameters['email'] ?? '';
    return SingleChildScrollView(
      child: Padding(
        padding: PSpacingStyle.paddingWithAppBarHeight,
        child: Column(
          children: [
            // IMAGE WITH 60% OF SCREEN WIDTH
            // TITLE AND AND SUBTITLE
            // BUTTONS
            ReusableEmailWidget(
                email: email,
                image: PImages.emailDeliveredImage,
                title: PTexts.changePasswordTitle,
                subtitle: PTexts.changePasswordSubtitle,
                elevatedaBtnText: PTexts.done,
                textBtnText: PTexts.resendEmail,
                doneOnpressed: () => Get.offAllNamed(KRoutes.login),
                resendeOnpressed: () {}
                // => ForgetPasswordController.instance
                //     .resendPasswordResetEmail(email)\
                )
          ],
        ),
      ),
    );
  }
}
