import 'package:ahiaa_web/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../core/common/styles/spacing_styles.dart';
import '../../../../../core/utils/constants/sizes.dart';
import '../../../../../core/utils/constants/text_strings.dart';
import '../../../../../core/utils/validators/validation.dart';

class ForgetPasswordMobile extends StatelessWidget {
  const ForgetPasswordMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: PSpacingStyle.paddingWithAppBarHeight,
        child: Column(
          children: [
            // HEADING
            IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Iconsax.direct_right)),
            Text(
              PTexts.forgetPassword,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: PSizes.spaceBtwItems,
            ),

            Text(
              PTexts.forgetPasswordSubtitle,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(
              height: PSizes.spaceBtwSections,
            ),
            const SizedBox(
              height: PSizes.spaceBtwSections * 2,
            ),
            // TEXTFIELD
            Form(
              // key: controller.resetPasswordFormKey,
              child: TextFormField(
                // controller: controller.email,
                validator: PValidator.validateEmail,
                decoration: const InputDecoration(
                  labelText: PTexts.email,
                  prefixIcon: Icon(Iconsax.direct),
                ),
              ),
            ),
            const SizedBox(
              height: PSizes.spaceBtwSections,
            ),
            // SUBMIT BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: (){},// => Get.toNamed(KRoutes.resetPassword,
                      // parameters: {'email': 'diweesomchi@gmail.com'}),
                  // onPressed: () => controller.sendPasswordResetEmail(),
                  child: const Text(PTexts.submit)),
            )
          ],
        ),
      ),
    );
  }
}
