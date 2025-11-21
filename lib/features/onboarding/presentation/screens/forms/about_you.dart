import 'dart:convert';

import 'package:ahiaa_web/core/common/layout/headers/header2.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/date_selector.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/fields/custom_textfield.dart';
import 'package:ahiaa_web/core/common/widgets/signup_login/form_divider.dart';
import 'package:ahiaa_web/core/common/widgets/signup_login/social_button.dart';
import 'package:ahiaa_web/core/routes/app_router2.dart';
import 'package:ahiaa_web/core/routes/routes.dart';
import 'package:ahiaa_web/features/personalization/presentation/screens/widgets/user_avater.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/utils/constants/text_strings.dart';
import 'package:ahiaa_web/core/utils/logging/logger.dart';
import 'package:ahiaa_web/core/utils/validators/validation.dart';
import 'package:flutter/material.dart' hide Colors, Form, FormField, TextField;
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart'
    hide Theme, TextButton, Checkbox;

class AboutYou extends StatefulWidget {
  const AboutYou({
    super.key,
    this.shouldUseKai = false,
  });
  final bool shouldUseKai;

  @override
  State<AboutYou> createState() => _AboutYouState();
}

class _AboutYouState extends State<AboutYou> {
  final phoneController = TextEditingController();
  final schoolController = TextEditingController();
  DateTime dob = DateTime.now();

  final _agree = const CheckboxKey('agree');

  CheckboxState state = CheckboxState.unchecked;

  Validator validatePassword =
      const LengthValidator() & const SafePasswordValidator();

  @override
  Widget build(BuildContext context) {
      final responsive = ResponsiveBreakpoints.of(context);

    return Padding(
        padding:  EdgeInsets.symmetric(horizontal:responsive.isMobile? 0: 30.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        spacing: 28,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            spacing: 15,

            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const UserAvater(),
              const Text('Tell Us More About You').x3Large.bold.black,
              const Text('A few quick questions to personalise your practice')
                  .xSmall
            ],
          ),
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 38,
                        children: [
                          Expanded(
                            child: TextFieldForm(
                              controller: phoneController,
                              fieldName: 'Phone',
                              labelText: 'Phone  number',
                              icon: Iconsax.call,
                              validator: PValidator.validatePhoneNumber,
                            ),
                          ),
                          const Expanded(child: DatePickerContainerScreen()),
                        ],
                      ),
                      TextFieldForm(
                        controller: schoolController,
                        fieldName: 'School',
                        labelText: 'School',
                        icon: Iconsax.building,
                        validator: (value) =>
                            PValidator.validateEmptyText('School', value),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      getIt<AppRouter>().router.goNamed(KRoutes.onboarding);
                    },
                    style: ElevatedButton.styleFrom(
                      maximumSize: const Size(490, 56),
                      minimumSize: const Size(490, 56),
                    ),
                    child: const Text('Continue'),
                  ),
                  TextButton(
                      onPressed: () {}, child: const Text('Skip for now'))
                ],
              ))
        ],
      ).withPadding(vertical: 40, horizontal:responsive.isMobile? 0: 50),
    );
  }
}
