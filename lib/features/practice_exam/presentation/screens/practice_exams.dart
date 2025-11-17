import 'package:ahiaa_web/core/common/layout/templates/site_template.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/services/subject_helper.dart';
import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_cubit.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/screens/desktop/practice_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  @override
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final examCubit = getIt<ExamCubit>();

    return BlocBuilder<ExamCubit, ExamState>(
      bloc: getIt<ExamCubit>(),
      builder: (context, state) {
        return  const SiteTemplate2(
            useLayout: true,
            desktop: DesktopPracticeScreen(
              
            ),
          );
      },
    );
  }
}
