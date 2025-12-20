import 'dart:convert';

import 'package:ahiaa_web/core/common/loaders/loading_button.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/date_selector.dart';
import 'package:ahiaa_web/core/common/widgets/fields/custom_textfield.dart';
import 'package:ahiaa_web/core/common/widgets/taosts/toast.dart';
import 'package:ahiaa_web/core/routes/app_router2.dart';
import 'package:ahiaa_web/core/routes/routes.dart' show KRoutes;
import 'package:ahiaa_web/core/utils/logging/logger.dart';
import 'package:ahiaa_web/core/utils/validators/validation.dart';
import 'package:ahiaa_web/features/authentication/presentation/business/cubit/profile_cubit.dart';
import 'package:ahiaa_web/features/personalization/presentation/screens/widgets/user_avater.dart';
import 'package:ahiaa_web/features/settings/presentation/screens/edit_profile.dart';
import 'package:ahiaa_web/features/settings/presentation/screens/widgets/gender_radio.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:flutter/material.dart' hide Form;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' hide TextButton;

class PasswordSettings extends StatefulWidget {
  const PasswordSettings({super.key});

  @override
  State<PasswordSettings> createState() => _PasswordSettingsState();
}

class _PasswordSettingsState extends State<PasswordSettings> {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);

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
            passwordUpdated: () => KToasters.showToaster(
                  context: context,
                  title: 'Success',
                  subtitle: 'Password updated successfully.',
                ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.end,
          spacing: 28,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Password').x3Large.bold.black,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 22,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: TextFieldForm(
                            controller: oldPasswordController,
                            fieldName: 'Password',
                            labelText: 'Old password',
                            icon: Iconsax.lock,
                            useSuffixIcon: true,
                            suffixIcon: Iconsax.eye_slash,
                            obscureText: true,
                            maxLines: 1,
                            validator: (value) =>
                                PValidator.validatePassword(value),
                          ),
                        ),
                        TextFieldForm(
                          controller: newPasswordController,
                          fieldName: 'Password',
                          labelText: 'New password',
                          icon: Iconsax.lock,
                          useSuffixIcon: true,
                          suffixIcon: Iconsax.eye_slash,
                          obscureText: true,
                          maxLines: 1,
                          validator: (value) =>
                              PValidator.validatePassword(value),
                        ),
                        TextFieldForm(
                          controller: confirmPasswordController,
                          fieldName: 'Password',
                          labelText: 'Confirm New password',
                          icon: Iconsax.password_check,
                          useSuffixIcon: true,
                          suffixIcon: Iconsax.eye_slash,
                          obscureText: true,
                          maxLines: 1,
                          validator: (value) =>
                              PValidator.validatePassword(value),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
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
                                : () {
                                    if (newPasswordController.text !=
                                        confirmPasswordController.text) {
                                      KToasters.showToaster(
                                        context: context,
                                        title: 'Error',
                                        subtitle: 'Passwords do not match',
                                      );
                                      return;
                                    }
                                    getIt<ProfileCubit>().updatePassword(
                                      currentPassword:
                                          oldPasswordController.text,
                                      newPassword: newPasswordController.text,
                                    );
                                  },
                            style: ElevatedButton.styleFrom(
                              maximumSize: const Size(172, 48),
                              minimumSize: const Size(172, 48),
                            ),
                            child: isLoading
                                ? const LoadingAnimator()
                                : Text(
                                    'Change password',
                                    style: TextStyle(
                                        fontSize:
                                            responsive.isMobile ? 12 : 15),
                                  ),
                          );
                        },
                      ),
                    ),
                  ],
                ))
          ],
        ).withPadding(
            vertical: responsive.isMobile ? 30 : 40,
            horizontal: responsive.isMobile ? 0 : 50),
      ),
    );
  }
}
