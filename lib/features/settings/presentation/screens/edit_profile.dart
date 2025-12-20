import 'dart:convert';
import 'package:ahiaa_web/core/common/loaders/loading_button.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/date_selector.dart';
import 'package:ahiaa_web/core/common/widgets/fields/custom_textfield.dart';
import 'package:ahiaa_web/core/common/widgets/taosts/toast.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/routes/app_router2.dart';
import 'package:ahiaa_web/core/routes/routes.dart';
import 'package:ahiaa_web/core/utils/logging/logger.dart';
import 'package:ahiaa_web/core/utils/validators/validation.dart';
import 'package:ahiaa_web/features/authentication/presentation/business/cubit/profile_cubit.dart';
import 'package:ahiaa_web/features/personalization/presentation/cubit/cubit/user_cubit.dart';
import 'package:ahiaa_web/features/personalization/presentation/screens/widgets/user_avater.dart';
import 'package:ahiaa_web/features/settings/presentation/screens/widgets/gender_radio.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:flutter/material.dart' hide Form;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart'
    hide TextButton, Radio, RadioGroup;

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late final TextEditingController phoneController;
  late final TextEditingController schoolController;
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController dobController;
  late final TextEditingController genderController;
  late final TextEditingController emailController;
  late final TextEditingController bioController;

  String? gender;
  DateTime? dob;

  @override
  void initState() {
    super.initState();
    final user = getIt<UserCubit>().currentUser;

    // Initialize controllers with current user data
    firstNameController = TextEditingController(text: user?.firstName);
    lastNameController = TextEditingController(text: user?.lastName);
    emailController = TextEditingController(text: user?.email);
    phoneController = TextEditingController(text: user?.phoneNumber);
    schoolController = TextEditingController(text: user?.school);
    bioController = TextEditingController(text: user?.bio);
    genderController = TextEditingController(text: user?.gender);
    dobController = TextEditingController(text: user?.dob?.toIso8601String());

    // Set initial state values
    gender = user?.gender;
    dob = user?.dob;
  }

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    schoolController.dispose();
    bioController.dispose();
    genderController.dispose();
    dobController.dispose();
    super.dispose();
  }

  // Helper to safely get label text (handles null and empty)
  String _getLabelText(String? value, String fallback) {
    return (value == null || value.trim().isEmpty) ? fallback : value;
  }

  bool canUpdate() {
    return firstNameController.text.trim().isNotEmpty ||
        lastNameController.text.trim().isNotEmpty ||
        emailController.text.trim().isNotEmpty ||
        phoneController.text.trim().isNotEmpty ||
        schoolController.text.trim().isNotEmpty ||
        bioController.text.trim().isNotEmpty ||
        genderController.text.trim().isNotEmpty ||
        dob != null ||
        gender != null;
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);
    final user = getIt<UserCubit>().currentUser;

    return BlocListener<ProfileCubit, ProfileState>(
      bloc: getIt<ProfileCubit>(),
      listener: (context, state) {
        // TODO: implement listener
        state.maybeWhen(
            orElse: () {},
            error: (message) => KToasters.showToaster(
                  context: context,
                  title: 'Error',
                  subtitle: message,
                ),
            profileUpdated: (user) => KToasters.showToaster(
                  context: context,
                  title: 'Success',
                  subtitle: 'Profile updated successfully',
                ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: Column(
          spacing: 28,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Edit Profile').x3Large.bold.black,
            const Column(
              spacing: 15,
              children: [
                UserAvater(size: 60),
              ],
            ),
            Form(
              onSubmit: (context, values) {
                PLoggerHelper.debug(jsonEncode(
                    values.map((key, value) => MapEntry(key.key, value))));
              },
              child: Column(
                spacing: 20,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (responsive.isMobile)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 16,
                      children: [
                        // First & Last Name
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 16,
                          children: [
                            TextFieldForm(
                              controller: firstNameController,
                              fieldName: 'First Name',
                              labelText:
                                  _getLabelText(user?.firstName, 'First Name'),
                              icon: Iconsax.user,
                              validator: (value) =>
                                  PValidator.validateEmptyText(
                                      'First Name', value),
                            ),
                            TextFieldForm(
                              controller: lastNameController,
                              fieldName: 'Last Name',
                              labelText:
                                  _getLabelText(user?.lastName, 'Last Name'),
                              icon: Iconsax.user,
                              validator: (value) =>
                                  PValidator.validateEmptyText(
                                      'Last Name', value),
                            ),
                          ],
                        ),
                        // Email & Phone
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 16,
                          children: [
                            TextFieldForm(
                              controller: emailController,
                              fieldName: 'Email',
                              labelText: _getLabelText(user?.email, 'Email'),
                              icon: Icons.mail_outline_rounded,
                              validator: PValidator.validateEmail,
                            ),
                            TextFieldForm(
                              controller: phoneController,
                              fieldName: 'Phone',
                              labelText:
                                  _getLabelText(user?.phoneNumber, '+234'),
                              icon: Iconsax.call,
                              validator: (value) =>
                                  PValidator.validateEmptyText(
                                      'Phone number', value),
                            ),
                          ],
                        ),
                        // DOB & Gender
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 8,
                          children: [
                            DatePickerContainerScreen(
                              initialDate: dob,
                              onDateSelected: (date) {
                                setState(() => dob = date);
                              },
                            ),
                            SizedBox(
                              width: 250,
                              child: GenderRadioGroup(
                                initialValue: gender,
                                onChanged: (value) {
                                  setState(() => gender = value);
                                },
                              ),
                            ),
                          ],
                        ),
                        // School
                        TextFieldForm(
                          controller: schoolController,
                          fieldName: 'School',
                          labelText: _getLabelText(
                              user?.school, 'e.g. ABC International College'),
                          validator: (value) =>
                              PValidator.validateEmptyText('School', value),
                        ),
                        // Bio
                        BioTextField(
                          bioController: bioController,
                          initialText: user?.bio,
                        ),
                      ],
                    ),

                  // Desktop/Tablet Layout
                  if (!responsive.isMobile)
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
                                labelText: _getLabelText(
                                    user?.firstName, 'First Name'),
                                icon: Iconsax.user,
                                validator: (value) =>
                                    PValidator.validateEmptyText(
                                        'First Name', value),
                              ),
                            ),
                            Expanded(
                              child: TextFieldForm(
                                controller: lastNameController,
                                fieldName: 'Last Name',
                                labelText:
                                    _getLabelText(user?.lastName, 'Last Name'),
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
                                labelText: _getLabelText(user?.email, 'Email'),
                                icon: Icons.mail_outline_rounded,
                                validator: PValidator.validateEmail,
                              ),
                            ),
                            Expanded(
                              child: TextFieldForm(
                                controller: phoneController,
                                fieldName: 'Phone',
                                labelText:
                                    _getLabelText(user?.phoneNumber, '+234'),
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
                            Expanded(
                              child: DatePickerContainerScreen(
                                initialDate: dob,
                                onDateSelected: (date) =>
                                    setState(() => dob = date),
                              ),
                            ),
                            Expanded(
                              child: GenderRadioGroup(
                                initialValue: gender,
                                onChanged: (value) =>
                                    setState(() => gender = value),
                              ),
                            ),
                          ],
                        ),
                        TextFieldForm(
                          controller: schoolController,
                          fieldName: 'School',
                          labelText: _getLabelText(
                              user?.school, 'e.g. ABC International College'),
                          validator: (value) =>
                              PValidator.validateEmptyText('School', value),
                        ),
                        BioTextField(
                            bioController: bioController,
                            initialText: user?.bio),
                      ],
                    ),

                  // Save Button
                  Padding(
                    padding:
                        EdgeInsets.only(top: responsive.isMobile ? 14 : 20.0),
                    child: BlocBuilder<ProfileCubit, ProfileState>(
                      bloc: getIt<ProfileCubit>(),
                      builder: (context, state) {
                        final isLoading = state.maybeWhen(
                          orElse: () => false,
                          loading: () => true,
                        );
                        return ElevatedButton(
                          onPressed: isLoading
                              ? () {}
                              : !canUpdate()
                                  ? null
                                  : () {
                                      getIt<ProfileCubit>().updateProfile(
                                        userId:
                                            getIt<UserCubit>().currentUser!.id,
                                        firstName:
                                            firstNameController.text.trim(),
                                        lastName:
                                            lastNameController.text.trim(),
                                        email: emailController.text.trim(),
                                        phoneNumber:
                                            phoneController.text.trim(),
                                        dob: dob,
                                        gender: gender,
                                        school: schoolController.text.trim(),
                                        bio: bioController.text.trim(),
                                      );
                                    },
                          style: ElevatedButton.styleFrom(
                            maximumSize: const Size(172, 48),
                            minimumSize: const Size(172, 48),
                          ),
                          child: isLoading? const LoadingAnimator() : Text(
                            'Save changes',
                            style: TextStyle(
                                fontSize: responsive.isMobile ? 12 : 15),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ).withPadding(
          vertical: responsive.isMobile ? 30 : 40,
          horizontal: responsive.isMobile ? 0 : 50,
        ),
      ),
    );
  }
}

// Updated BioTextField with correct validation and word count
class BioTextField extends StatefulWidget {
  const BioTextField({
    super.key,
    required this.bioController,
    this.initialText,
  });

  final TextEditingController bioController;
  final String? initialText;

  @override
  State<BioTextField> createState() => _BioTextFieldState();
}

class _BioTextFieldState extends State<BioTextField> {
  static const int maxWords = 500;
  int remainingWords = maxWords;

  @override
  void initState() {
    super.initState();
    _updateWordCount();
    widget.bioController.addListener(_updateWordCount);
  }

  void _updateWordCount() {
    final length = widget.bioController.text.trim().length;
    setState(() {
      remainingWords = length >= maxWords ? 0 : maxWords - length;
    });
  }

  @override
  void dispose() {
    widget.bioController.removeListener(_updateWordCount);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFieldForm(
          controller: widget.bioController,
          fieldName: 'Bio',
          hintText: widget.initialText ?? 'Tell us about yourself',
          labelText: 'Tell us about yourself',
          minLines: 5,
          maxLines: null,
          validator: (value) => null, // Bio is optional
        ),
        const SizedBox(height: 4),
        ResponsiveText('$remainingWords characters left').withSize(8),
      ],
    );
  }
}
