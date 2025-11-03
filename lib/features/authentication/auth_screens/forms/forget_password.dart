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
import 'package:iconsax/iconsax.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart'
    hide Theme, TextButton, Checkbox;

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({
    super.key,
    this.shouldUseKai = false,
  });
  final bool shouldUseKai;

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();

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
             
            ],
          ),
          const Text('Forgot Password').x3Large.bold.black,
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
                        controller: emailController,
                        fieldName: 'Email',
                        labelText: 'Your email',
                        icon: Iconsax.direct,
                        validator: PValidator.validateEmail,
                      ),
                     
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      maximumSize: const Size(490, 56),
                      minimumSize: const Size(490, 56),
                    ),
                    child: const Text('Submit'),
                  ),
                ],
              ))
        ],
      ).withPadding(vertical: 40, horizontal: 50),
    );
  }
}
