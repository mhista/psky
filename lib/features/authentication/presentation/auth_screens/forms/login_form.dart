import 'dart:convert';

import 'package:ahiaa_web/core/common/layout/headers/header2.dart';
import 'package:ahiaa_web/core/common/loaders/loading_button.dart';
import 'package:ahiaa_web/core/common/widgets/fields/custom_textfield.dart';
import 'package:ahiaa_web/core/common/widgets/signup_login/form_divider.dart';
import 'package:ahiaa_web/core/common/widgets/signup_login/social_button.dart';
import 'package:ahiaa_web/core/common/widgets/taosts/toast.dart';
import 'package:ahiaa_web/core/routes/app_router2.dart';
import 'package:ahiaa_web/core/routes/routes.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
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
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart'
    hide Theme, TextButton, Checkbox;

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    this.shouldUseKai = false,
    required this.controller,
  });
  final bool shouldUseKai;
  final AuthPageControllerCubit controller;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _agree = const CheckboxKey('agree');
  final authCubit = getIt<AuthCubit>();

  CheckboxState state = CheckboxState.unchecked;

  Validator validatePassword =
      const LengthValidator() & const SafePasswordValidator();
  void _handleSignIn() {
    // Add validation before calling signup
    if (emailController.text.trim().isEmpty ||
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

    authCubit.login(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);

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
            getIt<AppRouter>().router.goNamed(KRoutes.dashboard);
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
      builder: (context, state) {
         // Determine if loading
        final isLoading = state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );
        return Padding(
          padding:  EdgeInsets.symmetric(horizontal:responsive.isMobile? 0: 30.0),
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
                      onPressed: () {
                        widget.controller.nextPage(1);
                      },
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
                            controller: emailController,
                            fieldName: 'Email',
                            labelText: 'Your email',
                            icon: Iconsax.direct,
                            validator: PValidator.validateEmail,
                          ),
                          TextFieldForm(
                            controller: passwordController,
                            fieldName: 'Password',
                            labelText: 'Your password',
                            icon: Iconsax.password_check,
                            useSuffixIcon: true,
                            suffixIcon: Iconsax.eye_slash,
                            obscureText: true,
                            maxLines: 1,
                            // obscureText: true,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Remeber me
                              Row(
                                children: [
                                  Checkbox(value: true, onChanged: (value) {}),
                                  const Text(PTexts.remember),
                                ],
                              ),
                              // forget password
                              TextButton(
                                onPressed: () {},
                                child: const Text(PTexts.forgetPassword),
                              ),
                            ],
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: isLoading ? (){} : _handleSignIn,
                        style: ElevatedButton.styleFrom(
                          maximumSize: const Size(490, 56),
                          minimumSize: const Size(490, 56),
                        ),
                        child: isLoading
                        ? const LoadingAnimator()
                        : const Text('Sign In'),
                      ),
                      const PFormeDivider(dividerText: 'Or'),
                      const PSocialButton()
                    ],
                  ))
            ],
          ).withPadding(vertical: 40, horizontal:responsive.isMobile? 0: 50),
        );
      },
    );
  }
}
