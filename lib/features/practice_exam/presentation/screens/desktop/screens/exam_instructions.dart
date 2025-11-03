import 'package:ahiaa_web/core/common/layout/templates/site_template.dart';
import 'package:ahiaa_web/core/common/widgets/buttons/elevated_r_button.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/routes/app_router2.dart';
import 'package:ahiaa_web/core/routes/routes.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

class ExamInstructionsScreen extends StatelessWidget {
  const ExamInstructionsScreen({
    super.key,
    this.isLoading = false,
    this.hasError = false,
    this.expand = false,
    this.isFirstTime = true,
    this.hasData = false,
  });

  final bool isLoading, hasError, hasData, expand, isFirstTime;

  @override
  Widget build(BuildContext context) {
    return SiteTemplate2(
      useLayout: true,
      desktop: TRoundedContainer(
        padding:const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  getIt<AppRouter>().router.pop();
                },
                icon: const Icon(Icons.arrow_back_rounded),
              ),
            ),
            const ResponsiveText('Exam Instructions').withSize(18).bold,
            const ResponsiveText('Read carefully before you begin')
                .withSize(10),
            const Expanded(
              child: TRoundedContainer(
                backgroundColor: PColors.light,
                // padding: const EdgeInsets.all(0),
                child: SingleChildScrollView(
                  child: GptMarkdown(
                    """In this examination, you will be tested on the following subjects: [Insert Subjects e.g., Mathematics, English Language, Biology].

You will be given a total of [X questions], carefully selected from past and model questions in the chosen subjects. These questions are designed to simulate the real WAEC experience and help you practice effectively.

You are expected to read each question carefully before selecting or providing an answer. Use the Next button to move forward, and the Previous button if you wish to return to an earlier question. You may also mark any question for review by selecting the "Review Later" option, which allows you to revisit flagged questions before submission.

You will have [Insert Time e.g., 1 hour 30 minutes] to complete this exam. The timer will begin as soon as you start. If you are unable to finish within the allocated time, your work will be saved automatically and your attempted answers will be submitted.

Please note the following:

- If you do not know the answer to a question, you may skip it and return later if time permits.
- Once you click "Submit Exam", your answers will be finalized, and you will immediately see your score.
- At the end of the exam, you will also receive detailed feedback, including the correct answers and areas where you need improvement.
- Your progress is continuously saved, ensuring you do not lose work due to accidental disconnection or page refresh.

If you have read and understood the instructions above, kindly click on "Proceed to Exam" below to begin your test.

Best of luck — stay calm, focus, and give it your best effort.""",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
            TElevatedButton(
              text: 'Proceed to Exam',
              onTap: () {
                  getIt<AppRouter>().router.pushNamed(KRoutes.mainExamScreen);

              },
              bgColor: PColors.primary,
              color: PColors.white,
            )
          ],
        ),
      ),
    );
  }
}
