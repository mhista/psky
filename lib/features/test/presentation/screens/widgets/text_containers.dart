import 'package:ahiaa_web/core/common/widgets/buttons/elevated_r_button.dart';
import 'package:ahiaa_web/core/common/widgets/progress/animated_circular_progress.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/routes/app_router2.dart';
import 'package:ahiaa_web/core/routes/routes.dart';
import 'package:ahiaa_web/core/services/subject_service.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/features/authentication/domain/entities/user.dart';
import 'package:ahiaa_web/features/personalization/presentation/cubit/cubit/user_cubit.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_models/esam_session.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_cubit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

class TestContainers extends StatelessWidget {
  const TestContainers({super.key, required this.session});
  final ExamSession session;
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);

    final name = getIt<SubjectRepository>().getSubjectById(session.subjectId);
    return Container(
      constraints:
          BoxConstraints(maxWidth: responsive.isMobile ? double.infinity : 285),
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: PColors.light,
        borderRadius: BorderRadius.circular(12),
      ),
      height: 86,
      child: Column(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ResponsiveText(name?.name ?? '').withSize(11).bold,
                  ResponsiveText(session.examBody.name.toUpperCase())
                      .withSize(5),
                ],
              ),
              // Different colors
              RoundedGradeProgress(
                currentGrade:
                    session.progress?.currentQuestionIndex.toDouble() ?? 0,
                animationDuration: 1500.milliseconds,
                // animate: false,
                totalGrade: session.progress?.totalQuestions.toDouble() ?? 0,
                size: 30,
                progressColor: PColors.primary,
                backgroundColor: PColors.primary.withValues(alpha: 0.2),
                textColor: PColors.primary,
              )
            ],
          ),
          Row(
            children: [
              TElevatedButton(
                text: 'Resume',
                bgColor: PColors.deepBlack,
                color: PColors.white,
                verticalPadding: 0,
                onTap: () async {
                  final user = getIt<UserCubit>().user ?? UserEntity.empty();

                  final subjects = getIt<ExamCubit>()
                      .getAllSessions()
                      .map((s) => getIt<SubjectRepository>()
                          .getSubjectById(s.subjectId))
                      .toList()
                      .map((s) => s?.name ?? '')
                      .toList();
                  await getIt<ExamCubit>().startExam(
                      userId: user.id,
                      subjectId: session.subjectId ?? '',
                      examBody: session.examBody ?? ExamBody.waec,
                      paperType: session.paperType ?? PaperType.objective,
                      questions: session.questions ?? [],
                      currentSubjects: subjects ?? [],
                      customTimeLimit: (session.timeLimitMinutes -
                          (session.progress?.timeElapsedMinutes ?? 0)),
                      examMode: ExamMode.custom,
                      totalMarks: session.totalMarks ?? 0);
                  getIt<AppRouter>().router.goNamed(KRoutes.mainExamScreen);
                },
              ),
              TextButton(
                onPressed: () {
                  getIt<AppRouter>().router.goNamed(KRoutes.practiceExam);
                },
                child: const ResponsiveText('Start new session')
                    .bold
                    .withSize(8)
                    .withColor(PColors.primary),
              ),
            ],
          )
        ],
      ),
    );
  }
}
