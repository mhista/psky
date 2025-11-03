import 'package:ahiaa_web/features/practice_exam/presentation/bloc/bloc/editor_bloc.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_cubit.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/screens/widgets/editor.dart';
import 'package:ahiaa_web/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionPageView extends StatelessWidget {
  const QuestionPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<ExamCubit>();
    return BlocBuilder<ExamCubit, ExamState>(builder: (context, state) {
      return PageView.builder(
        controller: cubit.pageController,
        onPageChanged: cubit.updateQuestionIndex,
        itemCount: state.totalQuestions,
        itemBuilder: (context, index) {
          return const QuillEditorScreen();
        },
      );
    });
  }
}
