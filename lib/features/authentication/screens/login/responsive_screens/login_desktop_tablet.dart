import 'package:ahiaa_web/core/common/layout/templates/form_template.dart';
import 'package:flutter/material.dart';

import '../../../../../core/common/widgets/signup_login/form_divider.dart';
import '../../../../../core/utils/constants/text_strings.dart';
import '../widgets/login_form.dart';
import '../widgets/login_header.dart';

class LoginDesktopTabletScreen extends StatelessWidget {
  const LoginDesktopTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const FormTemplate(
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
    );
  }
}
