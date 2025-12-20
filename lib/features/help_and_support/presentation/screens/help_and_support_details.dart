// Direct usage example for your NotificationDetails widget
import 'package:ahiaa_web/core/common/widgets/texts/content_texts.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/features/help_and_support/presentation/cubits/help_and_support_cubit.dart';
import 'package:flutter/material.dart';

class HelpAndSupportDetails extends StatelessWidget {
  const HelpAndSupportDetails({super.key, required this.helpCubit});
  final HelpAndSupportCubit helpCubit;

  @override
  Widget build(BuildContext context) {
    const content =
        """In this examination, you will be tested on the following subjects: [Insert Subjects e.g., Mathematics, English Language, Biology].
You will be given a total of [X questions], carefully selected from past and model questions in the chosen subjects. These questions are designed to simulate the real WAEC experience and help you practice effectively.
You are expected to read each question carefully before selecting or providing an answer. Use the Next button to move forward, and the Previous button if you wish to return to an earlier question. You may also mark any question for review by selecting the "Review Later" option, which allows you to revisit flagged questions before submission.""";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        SizedBox(
          width: 100,
          child: TextButton(
            onPressed: () => helpCubit.previous(),
            child: Row(
              spacing: 5,
              children: [
                const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 13,
                ),
                const ResponsiveText('Back').withSize(10)
              ],
            ),
          ),
        ),
        Expanded(
          child: NotificationContentBuilder()
              .addTitle(helpCubit.state.article?.title ?? '')
              .addSubtitle('')
              .addBodyWithAutoParagraphs(helpCubit.state.article?.content ??
                  '') // ✨ Automatically splits by \n
              .withStyleConfig(
                const NotificationStyleConfig(
                    titleColor: Color(0xFF1F1F1F),
                    subtitleColor: Color(0xFF666666),
                    bodyColor: Color(0xFF333333),
                    titleWeight: FontWeight.w400,
                    titleSize: 24,
                    subtitleSize: 9,
                    bodySize: 10),
              )
              .withPadding(const EdgeInsets.all(24))
              .build(),
        ),
      ],
    );
  }
}
