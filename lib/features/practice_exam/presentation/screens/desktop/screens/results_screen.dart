import 'package:ahiaa_web/core/common/layout/templates/site_template.dart';
import 'package:ahiaa_web/core/common/widgets/buttons/elevated_r_button.dart';
import 'package:ahiaa_web/core/common/widgets/buttons/outlined_r_button.dart';
import 'package:ahiaa_web/core/common/widgets/buttons/text_r_button.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/images/edge_rounded_images.dart';
import 'package:ahiaa_web/core/common/widgets/progress/dynamic_circular_progress.dart'
    show DynamicCircularProgress;
import 'package:ahiaa_web/core/common/widgets/shimmer/three_to_one_shimmer.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/routes/app_router2.dart';
import 'package:ahiaa_web/core/routes/routes.dart';
import 'package:ahiaa_web/core/services/subject_service.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/utils/constants/image_strings.dart';
import 'package:ahiaa_web/core/utils/constants/text_strings.dart';
import 'package:ahiaa_web/core/utils/enums/enums.dart';
import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/core/utils/logging/logger.dart';
import 'package:ahiaa_web/features/authentication/domain/entities/user.dart';
import 'package:ahiaa_web/features/dashboard/presentation/screens/widgets/ai_insights.dart';
import 'package:ahiaa_web/features/personalization/presentation/cubit/cubit/user_cubit.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/ai_cubits/cubit/ai_exam_cubit.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_cubit.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' hide Divider;
import 'package:uuid/uuid.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final responsive = ResponsiveBreakpoints.of(context);
    final examCubit = getIt<ExamCubit>();

    return SiteTemplate2(
      useLayout: true,
      desktop: BlocBuilder<ExamCubit, ExamState>(
        builder: (context, state) {
          // Extract state information
          final stateData = state.maybeWhen(
            orElse: () => (
              loaderState: LoaderState.error,
              examSessions: null,
              completedSession: null,
            ),
            loading: () => (
              loaderState: LoaderState.loading,
              examSessions: null,
              completedSession: null,
            ),
            initial: () => (
              loaderState: LoaderState.loading,
              examSessions: null,
              completedSession: null,
            ),
            completed: (examSessions, completedSession) => (
              loaderState: LoaderState.done,
              examSessions: examSessions,
              completedSession: completedSession,
            ),
          );

          // Derive shimmer states from BLoC state
          final isLoading = stateData.loaderState == LoaderState.loading;
          final hasError = stateData.loaderState == LoaderState.error;
          final hasData = stateData.loaderState == LoaderState.done;
          final aggregate = examCubit.calculateAggregateResults();
          final correctScores = aggregate?.aggregateScore.correct;
          final totalQuestions = aggregate?.aggregateScore.totalQuestions;

          final grade = aggregate?.overallGrade.grade;
          final description = aggregate?.overallGrade.description;
          final globalMetrics = examCubit.getGlobalTimeMetrics();

          final remarks = aggregate?.overallGrade.remarks;
          final individualResults = aggregate?.individualResults ?? [];
          pskyLog(aggregate?.totalTimeSpent);
          pskyLog(
              " current: ${examCubit.getTotalTimeSpentAcrossAllSessions()}  total: ${examCubit.getTotalTimeLimitAcrossAllSessions()}");
          final recommendation = aggregate?.bestPerformance.recommendations;
          recommendation?.shuffle();

          return ThreeToOneShimmer(
            isLoading: isLoading,
            hasError: hasError,
            hasData: hasData,
            width: responsive.screenWidth,
            height: responsive.screenHeight,
            errorColor: PColors.tertiary.withValues(alpha: 0.5),
            radius: 16,
            errorText: "We couldn't load your results right now",
            errorButtonText: 'Retry',
            canReload: true,
            useFunction: true,
            callBack: () {
              // Trigger reload logic
              examCubit.calculateAggregateResults();
            },
            loadedWidget: TRoundedContainer(
              padding:  EdgeInsets.symmetric(horizontal:responsive.isMobile ? 12: 0,vertical:  responsive.isMobile? 16:0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 31,
                  children: [
                    // SUBJECT INTRO SECTION
                    Column(
                      spacing: 12,
                      children: [
                        const PRoundedImage(
                          imageType: ImagesType.asset,
                          image: PImages.passed,
                        ),
                        SizedBox(
                            width: 340,
                            child: const ResponsiveText(
                                    'Well done! Your exam is complete')
                                .withSize(21)
                                .bold
                                .withAlign(TextAlign.center)),
                      ],
                    ),
                    TRoundedContainer(
                      width: 468,
                      child: Column(
                        children: [
                          TRoundedContainer(
                            width: 409,
                            height: 52,
                            backgroundColor: PColors.light,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const ResponsiveText('Subject')
                                    .bold
                                    .withSize(10),
                                const ResponsiveText('Score').bold.withSize(10),
                                const ResponsiveText('Grade').bold.withSize(10)
                              ],
                            ),
                          ),
                          ...individualResults.map((result) {
                            final resultSubject = getIt<SubjectRepository>()
                                    .getSubjectById(
                                        result?.examSession.subjectId ?? '')
                                    ?.name ??
                                '';
                            return TRoundedContainer(
                              width: 439,
                              child: Column(
                                spacing: 10,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ResponsiveText(resultSubject)
                                          .withSize(10),
                                      ResponsiveText(
                                              '${result.score.correct}/${result.score.totalQuestions}')
                                          .withSize(10),
                                      TRoundedContainer(
                                        padding: const EdgeInsets.all(0),
                                        backgroundColor:
                                            Color(result.grade.color)
                                                .withValues(alpha: 0.3),
                                        width: 32,
                                        height: 28,
                                        radius: 1000,
                                        child: Center(
                                          child: ResponsiveText(
                                                  result.grade.grade)
                                              .withSize(11)
                                              .withColor(
                                                  Color(result.grade.color)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    height: 0.2,
                                    color: PColors.grey,
                                  )
                                ],
                              ),
                            );
                          })
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 40,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const ResponsiveText('Total Score')
                                .withSize(10)
                                .bold
                                .withAlign(TextAlign.center)
                                .withOpacity(0.7),
                            ResponsiveText('$correctScores/$totalQuestions')
                                .withSize(34)
                                .bold
                                .withAlign(TextAlign.center),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const ResponsiveText('Grade')
                                .withSize(10)
                                .bold
                                .withAlign(TextAlign.center)
                                .withOpacity(0.7),
                            ResponsiveText(
                                    '${grade ?? ''} - ${description ?? ''}')
                                .withSize(34)
                                .bold
                                .withAlign(TextAlign.center),
                          ],
                        )
                      ],
                    ),
                    Center(
                      child: Wrap(
                        spacing: 30,
                        runSpacing: 30,
                        alignment: WrapAlignment.center,
                        children: [
                          DynamicCircularProgress.time(
                            current: examCubit.getAverageTimeSpentPerSession(),
                            total:
                                examCubit.getTotalTimeLimitAcrossAllSessions(),
                            label: 'Time Spent',
                            size: 71,
                            animate: true,
                          ),
                          // DynamicCircularProgress.time(
                          //   current: const Duration(hours: 1, minutes: 30),
                          //   total: const Duration(hours: 2),
                          //   label: 'Allocated Time',
                          //   size: 71,
                          //   animate: true,
                          //   progressColor: const Color(0xFF6366F1),
                          //   backgroundColor: const Color(0xFFE0E7FF),
                          //   textColor: const Color(0xFF6366F1),
                          // ),
                          DynamicCircularProgress.grade(
                            currentGrade: aggregate?.aggregateScore.incorrect
                                    .toDouble() ??
                                0,
                            totalGrade: aggregate?.aggregateScore.totalQuestions
                                    .toDouble() ??
                                0,
                            label: 'Questions wrong',
                            size: 71,
                            animate: true,
                            progressColor: const Color(0xFFEC4899),
                            backgroundColor: const Color(0xFFFCE7F3),
                            textColor: const Color(0xFFEC4899),
                          ),
                          DynamicCircularProgress.grade(
                            currentGrade:
                                aggregate?.aggregateScore.correct.toDouble() ??
                                    0,
                            totalGrade: aggregate?.aggregateScore.totalQuestions
                                    .toDouble() ??
                                0,
                            label: 'Questions correct',
                            size: 71,
                            animate: true,
                            progressColor: const Color(0xFF10B981),
                            backgroundColor: const Color(0xFFD1FAE5),
                            textColor: const Color(0xFF10B981),
                          ),
                          DynamicCircularProgress.grade(
                            currentGrade:
                                aggregate?.aggregateScore.skipped.toDouble() ??
                                    0,
                            totalGrade: aggregate?.aggregateScore.totalQuestions
                                    .toDouble() ??
                                0,
                            label: 'Questions Skipped',
                            size: 71,
                            animate: true,
                            progressColor: const Color(0xFFF59E0B),
                            backgroundColor: const Color(0xFFFEF3C7),
                            textColor: const Color(0xFFF59E0B),
                          ),
                          DynamicCircularProgress(
                            currentValue:
                                aggregate?.averageAccuracy.toDouble() ?? 0.0,
                            totalValue: 100,
                            label: 'Complete',
                            valueFormatter: (curr, total) => '${curr.toInt()}%',
                            size: 71,
                            animate: true,
                            progressColor: const Color(0xFF8B5CF6),
                            backgroundColor: const Color(0xFFEDE9FE),
                            textColor: const Color(0xFF8B5CF6),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        width: 646,
                        child: AiInsightWidget(
                          aiText: recommendation?.first,
                          bgColor: PColors.grey,
                          extra: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: TElevatedButton(
                              text: 'View full Report',
                              bgColor: PColors.primary,
                              color: PColors.white,
                              onTap: () {
                                final user = getIt<UserCubit>().user ??
                                    UserEntity.empty();
                                final session = stateData.examSessions?.first;
                                final subjects = stateData.examSessions
                                    ?.map((s) => getIt<SubjectRepository>()
                                        .getSubjectById(s.subjectId))
                                    .toList()
                                    .map((s) => s?.name ?? '')
                                    .toList();
                                examCubit.startExam(
                                    userId: user.id,
                                    subjectId: session?.subjectId ?? '',
                                    examBody:
                                        session?.examBody ?? ExamBody.waec,
                                    paperType: session?.paperType ??
                                        PaperType.objective,
                                    questions: session?.questions ?? [],
                                    currentSubjects: subjects ?? [],
                                    examMode: ExamMode.custom,
                                    totalMarks: session?.totalMarks ?? 0);
                                getIt<AppRouter>()
                                    .router
                                    .goNamed(KRoutes.mainExamScreen);
                              },
                            ),
                          ),
                        )),
                    Wrap(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      alignment: WrapAlignment.center,
                      spacing: 12,
                      runSpacing: 12,

                      children: [
                        TElevatedButton(
                          text: 'View Report',
                          bgColor: PColors.primary,
                          color: PColors.white,
                          onTap: ()async {
                            final user =
                                getIt<UserCubit>().user ?? UserEntity.empty();
                            final session = stateData.examSessions?.first;
                            final subjects = stateData.examSessions
                                ?.map((s) => getIt<SubjectRepository>()
                                    .getSubjectById(s.subjectId))
                                .toList()
                                .map((s) => s?.name ?? '')
                                .toList();
                           await examCubit.startExam(
                                userId: user.id,
                                subjectId: session?.subjectId ?? '',
                                examBody: session?.examBody ?? ExamBody.waec,
                                paperType:
                                    session?.paperType ?? PaperType.objective,
                                questions: session?.questions ?? [],
                                currentSubjects: subjects ?? [],
                                examMode: ExamMode.custom,
                                totalMarks: session?.totalMarks ?? 0);
                            getIt<AppRouter>()
                                .router
                                .goNamed(KRoutes.mainExamScreen);
                          },
                        ),
                        TOutlinedButton(
                          text: 'Retake Exam',
                          bgColor: PColors.primary,
                          color: PColors.primary,
                          onTap: () {
                            final aiCubit = getIt<AiExamCubit>();
                            final _uuid = Uuid();
                            final user =
                                getIt<UserCubit>().user ?? UserEntity.empty();
                            final session = stateData.examSessions?.first;
                            final subject = getIt<SubjectRepository>()
                                .getSubjectById(session?.subjectId ?? '');
                            // aiCubit.initializeExam(
                            //   id: _uuid.v4(),
                            //   studentName: user.fullName,
                            //   subject: subject?.name ??"",
                            //   totalNumberOfQuestions: PTexts.examTotalCounts,
                            //   topics: session?.,
                            //   examBody: ExamBody.waec.name,
                            //   paperType: PaperType.objective.name,
                            //   numberOfQuestions: 5,
                            //   // timeLimitMinutes:
                            // );
                          },
                        ),
                        TTextButton(
                          text: 'Create Custom Practice',
                          bgColor: PColors.primary,
                          color: PColors.primary,
                          onTap: () async {
                            await examCubit.forceSyncToFirebase();
                            getIt<ExamSessionCubit>().clear();

                            examCubit.clear();
                            getIt<AiExamCubit>().reset();

                            getIt<AppRouter>()
                                .router
                                .pushReplacementNamed(KRoutes.practiceExam);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
