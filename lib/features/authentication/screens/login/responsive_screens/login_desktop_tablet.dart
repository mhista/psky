import 'package:ahiaa_web/common/layout/templates/form_template.dart';
import 'package:ahiaa_web/utils/constants/colors.dart';
import 'package:ahiaa_web/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../../common/styles/spacing_styles.dart';
import '../../../../../common/widgets/signup_login/form_divider.dart';
import '../../../../../utils/constants/text_strings.dart';
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
          PLoginForm(),

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
