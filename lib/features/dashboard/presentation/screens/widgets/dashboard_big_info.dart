import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/images/edge_rounded_images.dart';
import 'package:ahiaa_web/core/common/widgets/shimmer/three_to_one_shimmer.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/routes/app_router2.dart';
import 'package:ahiaa_web/core/routes/routes.dart';
import 'package:ahiaa_web/core/services/exam_result_calculator.dart';
import 'package:ahiaa_web/core/services/subject_service.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/utils/enums/enums.dart';
import 'package:ahiaa_web/core/utils/constants/image_strings.dart';
import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/core/utils/logging/logger.dart';
import 'package:ahiaa_web/features/authentication/domain/entities/user.dart';
import 'package:ahiaa_web/features/personalization/presentation/cubit/cubit/user_cubit.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart'
    hide Theme, Colors, TextButton;

class DashboardBigInfo extends StatelessWidget {
  const DashboardBigInfo({
    super.key,
    this.isLoading = false,
    this.hasData = false,
    this.hasError = false,
  });

  final bool isLoading;
  final bool hasData;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    final examCubit = getIt<ExamCubit>();
    final responsive = ResponsiveBreakpoints.of(context);
    return responsive.isMobile
        ? DashBoardInfo(
            isLoading: isLoading,
            hasData: hasData,
            hasError: hasError,
            examCubit: examCubit)
        : Expanded(
            child: DashBoardInfo(
                isLoading: isLoading,
                hasData: hasData,
                hasError: hasError,
                examCubit: examCubit));
  }
}

class DashBoardInfo extends StatelessWidget {
  const DashBoardInfo({
    super.key,
    required this.isLoading,
    required this.hasData,
    required this.hasError,
    required this.examCubit,
  });

  final bool isLoading;
  final bool hasData;
  final bool hasError;
  final ExamCubit examCubit;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);

    return ThreeToOneShimmer(
        isLoading: isLoading,
        hasData: hasData,
        hasError: hasError,
        width: double.infinity,
        maxWidth: 699,
        radius: 16,
        height: 161,
        useFunction: true,
        errorText:
            "Couldn't load your text progress, please refresh or try again",
        errorColor: PColors.tertiary.withValues(alpha: 0.5),
        loadedWidget: BlocBuilder<ExamCubit, ExamState>(
          bloc: examCubit,
          builder: (context, state) {
            final isNotEmptyState = state.maybeWhen(
              orElse: () => false,
              hasData:
                  (examMode, selectedSubjects, examSessions, currentSession) =>
                      true,
              completed: (examSessions, completedSession) => true,
            );
            final hasData = state.maybeWhen(
                orElse: () {},
                hasData:
                    (examMode, selectedSubjects, examSessions, currentSession) {
                  final activeSessions = examCubit.getAllActiveSessions();
                  if (activeSessions.isEmpty) {
                    return null; // Return null instead of trying to access .last
                  }

                  final currentProgress = activeSessions.last;
                  return (
                    currentProgress,
                    examMode,
                    selectedSubjects,
                    examSessions,
                    currentSession
                  );
                });
            pskyLog(hasData?.$1, logType: 'Dashboard Info');
            final isEmpty =
                hasData?.$1 == null || examCubit.getAllActiveSessions().isEmpty;

            final session = hasData?.$1;

            pskyLog(session?.subjectId);
            final name = getIt<SubjectRepository>()
                .getSubjectById(session?.subjectId ?? '')
                ?.name;
            final timeMetrics = ExamCalculator.calculateTimeMetrics(
              timeLimitMinutes: session?.timeLimitMinutes ?? 0,
              timeElapsedMinutes: session?.progress?.timeElapsedMinutes ?? 0,
            );
            return TRoundedContainer(
              padding: EdgeInsets.zero,
              height: 161,
              width: double.infinity,
              backgroundColor: PColors.primary2,
              gradient: isEmpty
                  ? const LinearGradient(colors: [PColors.sec2, PColors.sec1])
                  : const LinearGradient(
                      colors: [PColors.primary2, PColors.primary3]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    child: Column(
                      spacing: 4,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // INFO BUTTONS
                        if (isNotEmptyState && !isEmpty)
                          Row(
                            spacing: 8,
                            children: [
                              Text(
                                'Resume Test',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .apply(
                                        color: Colors.white,
                                        fontSizeDelta:
                                            !responsive.isDesktop ? -4 : 0),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 0,
                                        horizontal:
                                            !responsive.isDesktop ? 5 : 8),
                                    visualDensity:
                                        const VisualDensity(vertical: -4),
                                    backgroundColor: const Color(0xffDCF9E0)),
                                child: ResponsiveText(
                                  name ?? '',
                                )
                                    .responsive
                                    .labelMedium
                                    .withColor(PColors.secondary1)
                                    .withSize(!responsive.isDesktop ? 6 : 9),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 0,
                                        horizontal:
                                            !responsive.isDesktop ? 5 : 8),
                                    visualDensity:
                                        const VisualDensity(vertical: -4),
                                    backgroundColor: const Color(0xffF9DEDC)),
                                child: ResponsiveText(
                                  'Est. time left ~ ${timeMetrics.timeRemainingMinutes}mins',
                                )
                                    .responsive
                                    .labelMedium
                                    .withColor(PColors.bg2)
                                    .withSize(!responsive.isDesktop ? 6 : 9),
                              ),
                            ],
                          ),
                        // WELCOME MESSAGE
                        if (responsive.isMobile) const Gap(5),
                        if (isEmpty) const Gap(12),
                        Align(
                          alignment: Alignment.topLeft,
                          child: SizedBox(
                              width: !responsive.isDesktop ? 136 : 284,
                              child: ResponsiveText(
                                isEmpty
                                    ? 'Build your streak'
                                    : isNotEmptyState
                                        ? 'You’re on question ${session?.progress?.currentQuestionIndex} of ${session?.questions.length} — keep the momentum!'
                                        : 'Welcome to your dashboard',
                              )
                                  .white
                                  .left
                                  .headlineMedium
                                  .responsive
                                  .withSize(isNotEmptyState
                                      ? !responsive.isDesktop
                                          ? 11
                                          : 18
                                      : !responsive.isDesktop
                                          ? 13
                                          : 20)),
                        ),
                        if (isNotEmptyState && !isEmpty) const Gap(10),
                        if (!isNotEmptyState && !isEmpty)
                          Align(
                            alignment: Alignment.topLeft,
                            child: SizedBox(
                                width: 203,
                                child: const ResponsiveText(
                                  'No test in progress yet. Start practising to see your progress here.',
                                )
                                    .left
                                    .bodySmall
                                    .responsive
                                    .withSize(!responsive.isDesktop ? 6 : 8)
                                    .withWeight(FontWeight.w200)
                                    .withColor(
                                        PColors.white.withValues(alpha: 0.7))),
                          ),
                        if (isEmpty)
                          Align(
                            alignment: Alignment.topLeft,
                            child: SizedBox(
                                width: 203,
                                child: const ResponsiveText(
                                  'Complete one practice today to kick off your study streak.',
                                )
                                    .left
                                    .bodySmall
                                    .responsive
                                    .withSize(!responsive.isDesktop ? 6 : 8)
                                    .withWeight(FontWeight.w200)
                                    .withColor(
                                        PColors.white.withValues(alpha: 0.7))),
                          ),

                        if (isEmpty) const Gap(12),

                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                pskyLog(session?.questions);
                                if (isEmpty) {
                                  getIt<AppRouter>()
                                      .router
                                      .goNamed(KRoutes.practiceExam);
                                  return;
                                }
                                if (isNotEmptyState) {
                                  final user = getIt<UserCubit>().user ??
                                      UserEntity.empty();

                                  final subjects = hasData?.$4
                                      .map((s) => getIt<SubjectRepository>()
                                          .getSubjectById(s.subjectId))
                                      .toList()
                                      .map((s) => s?.name ?? '')
                                      .toList();
                                  await examCubit.startExam(
                                      userId: user.id,
                                      subjectId: session?.subjectId ?? '',
                                      examBody:
                                          session?.examBody ?? ExamBody.waec,
                                      paperType: session?.paperType ??
                                          PaperType.objective,
                                      questions: session?.questions ?? [],
                                      currentSubjects: subjects ?? [],
                                      customTimeLimit:
                                          timeMetrics?.timeRemainingMinutes,
                                      examMode: ExamMode.custom,
                                      totalMarks: session?.totalMarks ?? 0);
                                  getIt<AppRouter>()
                                      .router
                                      .goNamed(KRoutes.mainExamScreen);
                                } else {
                                  getIt<AppRouter>()
                                      .router
                                      .goNamed(KRoutes.practiceExam);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 15),
                                  visualDensity:
                                      const VisualDensity(vertical: -4),
                                  backgroundColor: PColors.white),
                              child: ResponsiveText(
                                isEmpty
                                    ? 'Start now'
                                    : isNotEmptyState
                                        ? 'Continue Test'
                                        : 'Start your mock exam',
                                letterSpacing: 1.0,
                              )
                                  .responsive
                                  .labelMedium
                                  .withColor(
                                      isEmpty ? PColors.sec1 : PColors.primary)
                                  .withSize(!responsive.isDesktop ? 5 : 6)
                                  .exBold,
                            ),
                            if (isNotEmptyState && !isEmpty)
                              TextButton(
                                onPressed: () {
                                  getIt<AppRouter>()
                                      .router
                                      .goNamed(KRoutes.practiceExam);
                                },
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 15),
                                  visualDensity:
                                      const VisualDensity(vertical: -4),
                                ),
                                child: const ResponsiveText(
                                  'Start New Session',
                                  letterSpacing: 1.0,
                                )
                                    .responsive
                                    .labelMedium
                                    .withColor(PColors.white)
                                    .withSize(!responsive.isDesktop ? 5 : 7)
                                    .exBold,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (responsive.isTablet && !isEmpty)
                    Expanded(
                      child: PRoundedImage(
                        imageType: ImagesType.asset,
                        image: isEmpty
                            ? PImages.flash
                            : isNotEmptyState
                                ? PImages.kaiWave
                                : PImages.kaiMascot,
                        height: 166,
                        width: 200,
                        fit: BoxFit.fill,
                        padding: 0,
                        borderRadius: 12,
                      ),
                    ),
                  if (responsive.isTablet && isEmpty)
                    const Stack(
                      children: [
                        Expanded(
                          child: PRoundedImage(
                            imageType: ImagesType.asset,
                            image: PImages.flash,
                            height: 166,
                            width: 150,
                            fit: BoxFit.cover,
                            padding: 0,
                            borderRadius: 12,
                          ),
                        ),
                        Positioned(
                          left: -15,
                          child: Expanded(
                            child: PRoundedImage(
                              imageType: ImagesType.asset,
                              image: PImages.flash,
                              height: 166,
                              width: 150,
                              fit: BoxFit.cover,
                              padding: 0,
                              borderRadius: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (responsive.isDesktop && !isEmpty)
                    PRoundedImage(
                      imageType: ImagesType.asset,
                      image: isEmpty
                          ? PImages.flash
                          : isNotEmptyState
                              ? PImages.kaiWave
                              : PImages.flash,
                      height: 166,
                      width: 290,
                      fit: BoxFit.fill,
                      padding: 0,
                      borderRadius: 12,
                    ),
                  if (responsive.isDesktop && isEmpty)
                    const Stack(
                      children: [
                        Expanded(
                          child: PRoundedImage(
                            imageType: ImagesType.asset,
                            image: PImages.flash,
                            height: 166,
                            width: 150,
                            fit: BoxFit.cover,
                            padding: 0,
                            borderRadius: 12,
                          ),
                        ),
                        Positioned(
                          left: -30,
                          child: Expanded(
                            child: PRoundedImage(
                              imageType: ImagesType.asset,
                              image: PImages.flash,
                              height: 166,
                              width: 150,
                              fit: BoxFit.cover,
                              padding: 0,
                              borderRadius: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            );
          },
        ));
  }
}
