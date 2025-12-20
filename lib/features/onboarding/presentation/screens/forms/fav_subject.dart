import 'package:ahiaa_web/core/common/custom_dropdown/custom_dropdown_with_search.dart';
import 'package:ahiaa_web/core/common/loaders/loading_button.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ahiaa_web/core/common/widgets/taosts/toast.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/routes/app_router2.dart';
import 'package:ahiaa_web/core/routes/routes.dart';
import 'package:ahiaa_web/core/services/subject_helper.dart';
import 'package:ahiaa_web/core/services/subject_service.dart';
import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/core/utils/logging/logger.dart';
import 'package:ahiaa_web/features/authentication/presentation/business/auth_page_cubit/auth_page_controller_cubit.dart';
import 'package:ahiaa_web/features/authentication/presentation/business/cubit/profile_cubit.dart';
import 'package:ahiaa_web/features/personalization/presentation/cubit/cubit/user_cubit.dart';
import 'package:ahiaa_web/features/personalization/presentation/screens/widgets/user_avater.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/screens/desktop/practice_screen.dart';
import 'package:flutter/material.dart' hide Colors, Form, FormField, TextField;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart'
    hide Theme, TextButton, Checkbox;

class FavSubject extends StatefulWidget {
  const FavSubject({super.key, required this.controller});
  final AuthPageControllerCubit controller;

  @override
  State<FavSubject> createState() => _FavSubjectState();
}

class _FavSubjectState extends State<FavSubject> {
  Set<String> selectedSubjects = {};
  final user = getIt<UserCubit>().currentUser;
  @override
  void initState() {
    super.initState();
    pskyLog(user);
    final examBody = ExamBodyExtension.fromString(
        (user?.examBody?.isNotEmpty ?? false) ? user?.examBody?.first ?? 'WAEC' : 'WAEC');
    getIt<SubjectDataHelper>()
        .loadAllSubjects(examBodies: [examBody ?? ExamBody.waec]);
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);
    return BlocListener<ProfileCubit, ProfileState>(
      bloc: getIt<ProfileCubit>(),
      listener: (context, state) {
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
                SizedBox(
                    width: 381,
                    child: const Text('Pick your favorite subjects to practice')
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
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      const ResponsiveText('Choose Subject').withSize(8).bold,
                      TRoundedContainer(
                        // width: 312,
                        backgroundColor: PColors.white,
                        // showBorder: true,
                        padding: const EdgeInsets.all(0.0),

                        radius: 28,
                        child: KCustomDropdownWithSearch(
                          items: getIt<SubjectRepository>()
                              .getAllSubjects()
                              .map((s) => s.name)
                              .toList(),
                          onChanged: (value) {
                            debugPrint('Selected value: $value'); // Debug print
                            if (value != null && value.isNotEmpty) {
                              selectedSubjects.add(value);
                              debugPrint('Current subjects: $selectedSubjects');
                              setState(() {});
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: selectedSubjects.map((e) {
                      return SubjectBox(
                        text: e,
                        onTap: () {
                          setState(() {
                            selectedSubjects.remove(e);
                          });
                        },
                      );
                    }).toList()),
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
                                userId: getIt<UserCubit>().currentUser!.id,
                                subjects: selectedSubjects.toList(),
                                hasOnboarded: true,
                              );
                              getIt<AppRouter>()
                                  .router
                                  .goNamed(KRoutes.dashboard);
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
                      widget.controller.prevPage(1);
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

class SubjectChip extends StatelessWidget {
  const SubjectChip({
    super.key,
    this.onTap,
    required this.text,
  });
  final Function()? onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      radius: 12,
      showBorder: true,
      height: 40,
      width: text.length > 10
          ? text.length * 10
          : text.length > 8
              ? text.length * 15
              : text.length * 22,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      borderColor: PColors.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text).xSmall.bold,
          MouseRegion(
              cursor: SystemMouseCursors.click,
              child: InkWell(onTap: onTap, child: const Text('X').xSmall.bold)),
        ],
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

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text),
          ],
        ),
      ),
    );
  }
}
