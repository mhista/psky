import 'package:ahiaa_web/core/common/loaders/loading_button.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/routes/app_router2.dart';
import 'package:ahiaa_web/core/routes/routes.dart';
import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/features/authentication/presentation/business/auth_page_cubit/auth_page_controller_cubit.dart';
import 'package:ahiaa_web/features/authentication/presentation/business/cubit/profile_cubit.dart';
import 'package:ahiaa_web/features/personalization/presentation/cubit/cubit/user_cubit.dart';
import 'package:ahiaa_web/features/personalization/presentation/screens/widgets/user_avater.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:flutter/material.dart' hide Colors, Form, FormField, TextField;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart'
    hide Theme, TextButton, Checkbox;

class ExamType extends StatefulWidget {
  const ExamType({super.key, required this.controller});
  final AuthPageControllerCubit controller;

  @override
  State<ExamType> createState() => _ExamTypeState();
}

class _ExamTypeState extends State<ExamType> {
  ExamBody? examBody;
  Set<String>? examBodies;
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);
    return BlocListener<ProfileCubit, ProfileState>(
      bloc: getIt<ProfileCubit>(),
      listener: (context, state) {
        // TODO: implement listener
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
                SizedBox(
                    width: 381,
                    child: const Text('Which exams are you preparing for?')
                        .x3Large
                        .bold
                        .black
                        .textCenter),
              ],
            ),
            Column(
              spacing: 20,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TRoundedContainer(
                  width: 506,
                  height: 224,
                  padding: const EdgeInsets.all(0),
                  backgroundColor: PColors.primary.withValues(alpha: 0.3),
                  child: Column(
                    children: [
                      ExamTypeSelector(
                        text: 'WAEC',
                        isSelected: examBody == ExamBody.waec,
                        onChecked: (value) {
                          setState(() {
                            examBodies = {};
                            examBody = ExamBody.waec;
                            examBodies?.add(ExamBody.waec.name);
                          });
                          debugPrint(examBodies.toString());
                        },
                      ),
                      ExamTypeSelector(
                        isSelected: examBody == ExamBody.jamb,
                        text: 'JAMB',
                        onChecked: (value) {
                          setState(() {
                            examBodies = {};
                            examBody = ExamBody.jamb;
                            examBodies?.add(ExamBody.jamb.name);
                          });
                          debugPrint(examBodies.toString());
                        },
                      ),
                      ExamTypeSelector(
                        isSelected: examBody == ExamBody.neco,
                        text: 'NECO',
                        onChecked: (value) {
                          setState(() {
                            examBodies = {};
                            examBody = ExamBody.neco;
                            examBodies?.add(ExamBody.neco.name);
                          });
                          debugPrint(examBodies.toString());
                        },
                      ),
                    ],
                  ),
                ),
                BlocBuilder<ProfileCubit, ProfileState>(
                  bloc: getIt<ProfileCubit>(),
                  builder: (context, state) {
                    final isLoading = state.maybeWhen(
                      orElse: () => false,
                      loading: () => true,
                    );
                    return ElevatedButton(
                      onPressed: () async {
                        await getIt<ProfileCubit>().updateProfile(
                            userId: getIt<UserCubit>().currentUser!.id,
                            examBody: examBodies?.toList());
                        widget.controller.nextPage(2);
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
                TextButton(
                    onPressed: () {
                      widget.controller.prevPage(0);
                    },
                    child: const Text('Go back'))
              ],
            )
          ],
        ).withPadding(vertical: 40, horizontal: responsive.isMobile ? 0 : 50),
      ),
    );
  }
}

class ExamTypeSelector extends StatelessWidget {
  const ExamTypeSelector({
    super.key,
    required this.text,
    this.onChecked,
    this.isSelected = false,
  });
  final String text;
  final Function(bool?)? onChecked;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: TRoundedContainer(
        height: 56,
        // radius: 0,
        backgroundColor: !isSelected ? PColors.transparent : null,
        gradient: !isSelected
            ? null
            : LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                    PColors.primary.withValues(alpha: 0.3),
                    PColors.primary.withValues(alpha: 0.3),
                    PColors.primary.withValues(alpha: 0.3),
                    PColors.primary.withValues(alpha: 0.5),
                  ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text),
            Checkbox(value: isSelected, onChanged: onChecked)
          ],
        ),
      ),
    );
  }
}
