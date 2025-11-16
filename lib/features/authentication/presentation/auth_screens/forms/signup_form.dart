import 'dart:convert';

import 'package:ahiaa_web/core/common/layout/headers/header2.dart';
import 'package:ahiaa_web/core/common/loaders/loading_button.dart';
import 'package:ahiaa_web/core/common/widgets/fields/custom_textfield.dart';
import 'package:ahiaa_web/core/common/widgets/signup_login/form_divider.dart';
import 'package:ahiaa_web/core/common/widgets/signup_login/social_button.dart';
import 'package:ahiaa_web/core/common/widgets/taosts/toast.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/routes/app_router2.dart';
import 'package:ahiaa_web/core/routes/routes.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/utils/constants/text_strings.dart';
import 'package:ahiaa_web/core/utils/logging/logger.dart';
import 'package:ahiaa_web/core/utils/validators/validation.dart';
import 'package:ahiaa_web/features/authentication/presentation/business/auth_page_cubit/auth_page_controller_cubit.dart';
import 'package:ahiaa_web/features/authentication/presentation/business/cubit/auth_cubit.dart';
import 'package:flutter/material.dart' hide Colors, Form, FormField, TextField;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' hide Theme;

class SignupForm extends StatefulWidget {
  const SignupForm({
    super.key,
    this.shouldUseKai = false,
    required this.controller,
  });
  final bool shouldUseKai;
  final AuthPageControllerCubit controller;

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _agree = const CheckboxKey('agree');
  final router = getIt<AppRouter>().router;
  final authCubit = getIt<AuthCubit>();

  CheckboxState state = CheckboxState.unchecked;

  Validator validatePassword =
      const LengthValidator() & const SafePasswordValidator();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _handleSignup() {
    // Add validation before calling signup
    if (firstNameController.text.trim().isEmpty ||
        lastNameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      KToasters.showToaster(
        context: context,
        title: 'Please fill in all fields',
      );
      return;
    }

    // Validate email format
    final emailError = PValidator.validateEmail(emailController.text.trim());
    if (emailError != null) {
      KToasters.showToaster(
        context: context,
        title: emailError,
      );
      return;
    }

    authCubit.signUp(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      phoneNumber: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      bloc: authCubit, // Explicitly provide the bloc instance
      listenWhen: (previous, current) {
        // Only listen when state actually changes
        return previous != current;
      },
      listener: (context, state) {
        state.when(
          initial: () {
            // Do nothing on initial state
          },
          loading: () {
            // Optionally show a loading indicator
            PLoggerHelper.debug('Auth loading...');
          },
          authenticated: (user) {
            // Show success message
            KToasters.showToaster(
              context: context,
              title: 'Welcome onboard ${user.firstName}',
            );
            
            // Navigate after a short delay to ensure toast is visible
               widget.controller.nextPage(0);
          },
          unauthenticated: () {
            // Handle unauthenticated state if needed
          },
          error: (message) {
            KToasters.showToaster(
              context: context,
              title: message.isNotEmpty 
                ? message 
                : 'An error occurred, please try again',
            );
          },
        );
      },
      buildWhen: (previous, current) {
        // Rebuild on every state change
        return true;
      },
      builder: (context, authState) {
        // Determine if loading
        final isLoading = authState.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );

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
                    onPressed: isLoading 
                      ? null 
                      : () {
                          widget.controller.nextPage(0);
                        },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 24,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: Text(
                      'Sign in',
                      style: Theme.of(context).textTheme.labelSmall!.apply(
                        fontWeightDelta: 5,
                        fontSizeDelta: 1,
                        color: PColors.primary4,
                      ),
                    ),
                  ),
                ],
              ),
              const Text('Create an account').x3Large.bold.black,
              Form(
                onSubmit: (context, values) {
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
                          spacing: 12,
                          children: [
                            Expanded(
                              child: TextFieldForm(
                                controller: firstNameController,
                                fieldName: 'First Name',
                                labelText: PTexts.firstname,
                                validator: (value) =>
                                    PValidator.validateEmptyText(
                                  'firstname',
                                  value,
                                ),
                                icon: Iconsax.user,
                                enabled: !isLoading,
                              ),
                            ),
                            Expanded(
                              child: TextFieldForm(
                                controller: lastNameController,
                                fieldName: 'Last Name',
                                labelText: PTexts.lastname,
                                validator: (value) =>
                                    PValidator.validateEmptyText(
                                  'lastname',
                                  value,
                                ),
                                icon: Iconsax.user,
                                enabled: !isLoading,
                              ),
                            )
                          ],
                        ),
                        TextFieldForm(
                          controller: emailController,
                          fieldName: 'Email',
                          labelText: 'Your email',
                          icon: Iconsax.direct,
                          validator: PValidator.validateEmail,
                          enabled: !isLoading,
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
                          enabled: !isLoading,
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: isLoading ? (){} : _handleSignup,
                      style: ElevatedButton.styleFrom(
                        maximumSize: const Size(490, 56),
                        minimumSize: const Size(490, 56),
                      ),
                      child: isLoading
                        ? const LoadingAnimator()
                        : const Text('Create Account'),
                    ),
                    // Only show social buttons when not loading
                    if (!isLoading) ...[
                      const PFormeDivider(dividerText: 'Or'),
                      const PSocialButton(),
                    ],
                  ],
                ),
              )
            ],
          ).withPadding(vertical: 40, horizontal: 50),
        );
      },
    );
  }
}