import 'dart:convert';

import 'package:ahiaa_web/core/common/layout/headers/header2.dart';
import 'package:ahiaa_web/core/common/widgets/fields/custom_textfield.dart';
import 'package:ahiaa_web/core/common/widgets/signup_login/form_divider.dart';
import 'package:ahiaa_web/core/common/widgets/signup_login/social_button.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/utils/constants/text_strings.dart';
import 'package:ahiaa_web/core/utils/logging/logger.dart';
import 'package:ahiaa_web/core/utils/validators/validation.dart';
import 'package:ahiaa_web/features/authentication/presentation/business/auth_page_cubit/auth_page_controller_cubit.dart';
import 'package:flutter/material.dart' hide Colors, Form, FormField, TextField;
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart'
    hide Theme, TextButton, Checkbox;

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({
    super.key,
    this.shouldUseKai = false, required AuthPageControllerCubit controller,
  });
  final bool shouldUseKai;

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final confirmPasswordController = TextEditingController();
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
                  child: Text('Sign up',
                      style: Theme.of(context).textTheme.labelSmall!.apply(
                          fontWeightDelta: 5,
                          fontSizeDelta: 1,
                          color: PColors.primary4))),
            ],
          ),
          const Text('Welcome back').x3Large.bold.black,
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
                        controller: confirmPasswordController,
                        fieldName: 'Password',
                        labelText: 'Your password',
                        icon: Iconsax.password_check,
                        useSuffixIcon: true,
                        suffixIcon: Iconsax.eye_slash,
                        obscureText: true,
                        maxLines: 1,
                      ),
                      TextFieldForm(
                        controller: passwordController,
                        fieldName: 'Password',
                        labelText: 'Retype New password',
                        icon: Iconsax.password_check,
                        useSuffixIcon: true,
                        suffixIcon: Iconsax.eye_slash,
                       obscureText: true,
                        maxLines: 1,
                      ),
                      
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      maximumSize: const Size(490, 56),
                      minimumSize: const Size(490, 56),
                    ),
                    child: const Text('Change Password'),
                  ),
                  
                ],
              ))
        ],
      ).withPadding(vertical: 40, horizontal: 50),
    );
  }
}
