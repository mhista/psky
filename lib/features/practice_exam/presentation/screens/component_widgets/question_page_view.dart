import 'package:ahiaa_web/features/practice_exam/presentation/bloc/bloc/editor_bloc.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_controller_cubit.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/screens/component_widgets/editor.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/screens/desktop/screens/main_exam_page.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/screens/tablet/option_question_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionPageView extends StatelessWidget {
  const QuestionPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<ExamControllerCubit>();
    return BlocBuilder<ExamControllerCubit, ExamPageState>(
        builder: (context, state) {
      return PageView.builder(
        controller: cubit.pageController,
        onPageChanged: cubit.updateQuestionIndex,
        itemCount: state.totalQuestions,
        itemBuilder: (context, index) {
          // return const QuillEditorScreen();
         return const OptionedQuestionWidget();
        },
      );
    });
  }
}
