import 'dart:convert';

import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/date_selector.dart';
import 'package:ahiaa_web/core/common/widgets/fields/custom_textfield.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/routes/app_router2.dart';
import 'package:ahiaa_web/core/routes/routes.dart';
import 'package:ahiaa_web/core/utils/logging/logger.dart';
import 'package:ahiaa_web/core/utils/validators/validation.dart';
import 'package:ahiaa_web/features/personalization/presentation/screens/widgets/user_avater.dart';
import 'package:ahiaa_web/features/settings/presentation/screens/widgets/gender_radio.dart';
import 'package:ahiaa_web/injection_container.dart';
import 'package:flutter/material.dart' hide Form;
import 'package:iconsax/iconsax.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart'
    hide TextButton, Radio, RadioGroup;

class EditProfile extends StatefulWidget {
  EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final phoneController = TextEditingController();

  final schoolController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final dobController = TextEditingController();
  final genderController = TextEditingController();
  final emailController = TextEditingController();
  final bioController = TextEditingController();

  DateTime dob = DateTime.now();

  CheckboxState state = CheckboxState.unchecked;

  Validator validatePassword =
      const LengthValidator() & const SafePasswordValidator();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        spacing: 28,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Edit Profile').x3Large.bold.black,
          Column(
            spacing: 15,

            // crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              UserAvater(
                size: 60,
              ),
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
                                controller: firstNameController,
                                fieldName: 'First Name',
                                labelText: 'First Name',
                                icon: Iconsax.user,
                                validator: (value) =>
                                    PValidator.validateEmptyText(
                                        'First Name', value)),
                          ),
                          Expanded(
                            child: TextFieldForm(
                              controller: lastNameController,
                              fieldName: 'Last Name',
                              labelText: 'Last Name',
                              icon: Iconsax.user,
                              validator: (value) =>
                                  PValidator.validateEmptyText(
                                      'Last Name', value),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 38,
                        children: [
                          Expanded(
                            child: TextFieldForm(
                              controller: emailController,
                              fieldName: 'Email',
                              labelText: 'Email',
                              icon: Icons.mail_outline_rounded,
                              validator: PValidator.validateEmail,
                            ),
                          ),
                          Expanded(
                            child: TextFieldForm(
                              controller: phoneController,
                              fieldName: 'Phone',
                              labelText: '+234',
                              icon: Iconsax.call,
                              validator: (value) =>
                                  PValidator.validateEmptyText(
                                      'Phone number', value),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 38,
                        children: [
                          const Expanded(child: DatePickerContainerScreen()),
                          Expanded(child: GenderRadioGroup(onChanged: (value) {
                            debugPrint(value);
                          })),
                        ],
                      ),
                      TextFieldForm(
                        controller: schoolController,
                        fieldName: 'School',
                        labelText: 'ABC International College',
                        // icon: Iconsax.call,
                        validator: (value) =>
                            PValidator.validateEmptyText('School', value),
                      ),
                      BioTextField(bioController: bioController),
                    ],
                  ),
                 Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        getIt<AppRouter>().router.goNamed(KRoutes.onboarding);
                      },
                      style: ElevatedButton.styleFrom(
                        maximumSize: const Size(172, 56),
                        minimumSize: const Size(172, 56),
                      ),
                      child: const Text('Save changes'),
                    ),
                  ),
                ],
              ))
        ],
      ).withPadding(vertical: 40, horizontal: 50),
    );
  }
}

class BioTextField extends StatefulWidget {
  const BioTextField({
    super.key,
    required this.bioController,
  });

  final TextEditingController bioController;

  @override
  State<BioTextField> createState() => _BioTextFieldState();
}

class _BioTextFieldState extends State<BioTextField> {
  int wordCount = 500;
  int newwordCount = 0;
  bool enabled = true;
  @override
  initState() {
    super.initState();
    widget.bioController.addListener(() {
      int length = widget.bioController.text.length;
      if (length >= 500) {
        setState(() {});
        return;
      }
      newwordCount = wordCount - length;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFieldForm(
          controller: widget.bioController,
          fieldName: 'Bio',
          hintText: 'Tell us about yourself',
          labelText: 'Tell us about yourself',
          enabled: enabled,
          minLines: 5,
          maxLines: null,
          // icon: Iconsax.call,
          validator: (value) =>
              PValidator.validateEmptyText('Phone number', value),
        ),
        ResponsiveText('${newwordCount == 0 ? wordCount:newwordCount} words left').withSize(8)
      ],
    );
  }
}
