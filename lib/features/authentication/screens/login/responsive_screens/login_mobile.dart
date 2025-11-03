import 'package:flutter/material.dart';

import '../../../../../core/common/styles/spacing_styles.dart';
import '../../../../../core/common/widgets/signup_login/form_divider.dart';
import '../../../../../core/utils/constants/text_strings.dart';
import '../widgets/login_form.dart';
import '../widgets/login_header.dart';

class LoginMobileScreen extends StatelessWidget {
  const LoginMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
        child: Padding(
      padding: PSpacingStyle.paddingWithAppBarHeight,
      child: Column(
        children: [
          // Logo, Title, Subtitle,

          PLoginHeader(),

          // Form
          // PLoginForm(),

          // Divider
          PFormeDivider(
            dividerText: PTexts.orSignInWith,
          ),
          // SizedBox(
          //   height: PSizes.spaceBtwSections,
          // ),
          // Footer
          // PSocialButton()
        ],
      ),
    ));
  }
}
