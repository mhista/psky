import 'package:ahiaa_web/common/layout/templates/form_template.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../routes/routes.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';

class ForgetPasswordDesktopTablet extends StatelessWidget {
  const ForgetPasswordDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return FormTemplate(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                onPressed: () => Get.toNamed(
                      KRoutes.resetPassword,
                    ),
                // onPressed: () {},
                // onPressed: () => controller.sendPasswordResetEmail(),
                child: const Text(PTexts.submit)),
          ),
          const SizedBox(
            height: PSizes.spaceBtwSections,
          ),
        ],
      ),
    );
  }
}
