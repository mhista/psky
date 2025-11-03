// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:pickafrika/features/authentication/controllers/forget_password/forget_password_controller.dart';
// import 'package:pickafrika/utils/constants/sizes.dart';
// import 'package:pickafrika/utils/constants/text_strings.dart';
// import 'package:pickafrika/utils/validators/validation.dart';

// class ForgetPasswordScreen extends StatelessWidget {
//   const ForgetPasswordScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(ForgetPasswordController());
//     return Scaffold(
//       appBar: AppBar(),
//       body: Padding(
//         padding: const EdgeInsets.all(PSizes.defaultSpace),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // HEADING
//             Text(
//               PTexts.forgetPassword,
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//             const SizedBox(
//               height: PSizes.spaceBtwItems,
//             ),

//             Text(
//               PTexts.forgetPasswordSubtitle,
//               style: Theme.of(context).textTheme.labelMedium,
//             ),
//             const SizedBox(
//               height: PSizes.spaceBtwSections,
//             ),
//             const SizedBox(
//               height: PSizes.spaceBtwSections * 2,
//             ),
//             // TEXTFIELD
//             Form(
//               key: controller.resetPasswordFormKey,
//               child: TextFormField(
//                 controller: controller.email,
//                 validator: PValidator.validateEmail,
//                 decoration: const InputDecoration(
//                   labelText: PTexts.email,
//                   prefixIcon: Icon(Iconsax.direct),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: PSizes.spaceBtwSections,
//             ),
//             // SUBMIT BUTTON
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                   onPressed: () => controller.sendPasswordResetEmail(),
//                   child: const Text(PTexts.submit)),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:ahiaa_web/core/common/layout/templates/app_layout.dart';
import 'package:ahiaa_web/features/authentication/screens/forget_password/responsive_screens/forget_password_desktop_tablet.dart';
import 'package:ahiaa_web/features/authentication/screens/forget_password/responsive_screens/forget_password_mobile.dart';
import 'package:flutter/material.dart';

class ForgetPasword extends StatelessWidget {
  const ForgetPasword({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplate(
      useLayout: false,
      desktop: ForgetPasswordDesktopTablet(),
      mobile: ForgetPasswordMobile(),
    );
  }
}
