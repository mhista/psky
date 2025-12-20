import 'dart:convert';

import 'package:ahiaa_web/core/common/loaders/loading_button.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/date_selector.dart';
import 'package:ahiaa_web/core/common/widgets/fields/custom_textfield.dart';
import 'package:ahiaa_web/core/common/widgets/taosts/toast.dart';
import 'package:ahiaa_web/core/routes/app_router2.dart';
import 'package:ahiaa_web/core/routes/routes.dart';
import 'package:ahiaa_web/features/authentication/presentation/business/auth_page_cubit/auth_page_controller_cubit.dart';
import 'package:ahiaa_web/features/authentication/presentation/business/cubit/profile_cubit.dart';
import 'package:ahiaa_web/features/personalization/presentation/cubit/cubit/user_cubit.dart';
import 'package:ahiaa_web/features/personalization/presentation/screens/widgets/user_avater.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/utils/logging/logger.dart';
import 'package:ahiaa_web/core/utils/validators/validation.dart';
import 'package:flutter/material.dart' hide Colors, Form, FormField, TextField;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart'
    hide Theme, TextButton, Checkbox;

class AboutYou extends StatefulWidget {
  const AboutYou({
    super.key,
    this.shouldUseKai = false, required this.controller,
  });
  final bool shouldUseKai;
  final AuthPageControllerCubit controller;

  @override
  State<AboutYou> createState() => _AboutYouState();
}

class _AboutYouState extends State<AboutYou> {
  final user = getIt<UserCubit>().currentUser!;
  final phoneController = TextEditingController();
  final schoolController = TextEditingController();
  DateTime? dob;

  final _agree = const CheckboxKey('agree');

  CheckboxState state = CheckboxState.unchecked;

  Validator validatePassword =
      const LengthValidator() & const SafePasswordValidator();
  @override
  void initState() {
    super.initState();
    dob = user.dob;
  }

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
            profileUpdated: (user) => KToasters.showToaster(
                  context: context,
                  title: 'Success',
                  subtitle: 'Info updated successfully',
                ));
      },
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: responsive.isMobile ? 0 : 30.0),
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
                            Expanded(
                                child: DatePickerContainerScreen(
                              initialDate: dob,
                              onDateSelected: (date) {
                                setState(() => dob = date);
                              },
                            )),
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
                    BlocBuilder<ProfileCubit, ProfileState>(
                      bloc: getIt<ProfileCubit>(),
                      builder: (context, state) {
                        final isLoading = state.maybeWhen(
                          orElse: () => false,
                          loading: () => true,
                        );
                        return ElevatedButton(
                          onPressed: isLoading
                              ? () {}
                              : () async {
                                  await getIt<ProfileCubit>().updateProfile(
                                    userId: user.id,
                                    phoneNumber: phoneController.text,
                                    dob: dob,
                                    school: schoolController.text,
                                  );

                                 widget.controller.nextPage(1);
                                },
                          style: ElevatedButton.styleFrom(
                            maximumSize: const Size(490, 56),
                            minimumSize: const Size(490, 56),
                          ),
                          child: isLoading
                              ? const LoadingAnimator()
                              : const Text('Continue'),
                        );
                      },
                    ),
                    BlocBuilder<ProfileCubit, ProfileState>(
                      bloc: getIt<ProfileCubit>(),
                      builder: (context, state) {
                        final isLoading = state.maybeWhen(
                          orElse: () => false,
                          loading: () => true,
                        );
                        return TextButton(
                            onPressed: isLoading
                                ? () {}
                                : () async {
                                    await getIt<ProfileCubit>().updateProfile(
                                        userId: user.id, hasOnboarded: true);
                                    getIt<AppRouter>()
                                        .router
                                        .goNamed(KRoutes.dashboard);
                                  },
                            child: const Text('Skip for now'));
                      },
                    )
                  ],
                ))
          ],
        ).withPadding(vertical: 40, horizontal: responsive.isMobile ? 0 : 50),
      ),
    );
  }
}
