import 'dart:convert';

import 'package:ahiaa_web/core/common/layout/headers/header2.dart';
import 'package:ahiaa_web/core/common/widgets/fields/custom_textfield.dart';
import 'package:ahiaa_web/core/common/widgets/signup_login/form_divider.dart';
import 'package:ahiaa_web/core/common/widgets/signup_login/social_button.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/utils/constants/text_strings.dart';
import 'package:ahiaa_web/core/utils/logging/logger.dart';
import 'package:ahiaa_web/core/utils/validators/validation.dart';
import 'package:flutter/material.dart' hide Colors, Form, FormField, TextField;
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' hide Theme;

class SignupForm extends StatefulWidget {
  const SignupForm({
    super.key,
    this.shouldUseKai = false,
  });
  final bool shouldUseKai;

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _agree = const CheckboxKey('agree');

  CheckboxState state = CheckboxState.unchecked;

  Validator validatePassword =
      const LengthValidator() & const SafePasswordValidator();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        spacing: 28,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: widget.shouldUseKai
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.end,
            children: [
              if (widget.shouldUseKai)
                const Padding(
                  padding: EdgeInsets.all(0.0),
                  child: AppDesktopLogo(
                    useInverse2: true,
                  ),
                ),
              OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 24),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100))),
                  child: Text('Sign in',
                      style: Theme.of(context).textTheme.labelSmall!.apply(
                          fontWeightDelta: 5,
                          fontSizeDelta: 1,
                          color: PColors.primary4))),
            ],
          ),
          const Text('Create an account').x3Large.bold.black,
          Form(
              onSubmit: (context, values) {
                // CheckboxState? agree = _agree[values];
                PLoggerHelper.debug(jsonEncode(values.map((key, value) {
                  return MapEntry(key.key, value);
                })));
              },
              child: Column(
                spacing: 20,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 22,
                    children: [
                      TextFieldForm(
                        controller: nameController,
                        fieldName: 'Your Name',
                        labelText: PTexts.lastname,
                        validator: (value) =>
                            PValidator.validateEmptyText('Name', value),
                        icon: Iconsax.user,
                      ),
                      TextFieldForm(
                        controller: emailController,
                        fieldName: 'Email',
                        labelText: 'Your email',
                        icon: Iconsax.direct,
                        validator: PValidator.validateEmail,
                      ),
                      TextFieldForm(
                        controller: passwordController,
                        fieldName: 'Password',
                        labelText: 'Create a password',
                        icon: Iconsax.password_check,
                        useSuffixIcon: true,
                        suffixIcon: Iconsax.eye_slash,
                        obscureText: true,
                        maxLines: 1,
                        // obscureText: true,
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      maximumSize: const Size(490, 56),
                      minimumSize: const Size(490, 56),
                    ),
                    child: const Text('Create Account'),
                  ),
                  const PFormeDivider(dividerText: 'Or'),
                  const PSocialButton()
                ],
              ))
        ],
      ).withPadding(vertical: 40, horizontal: 50),
    );
  }
}
