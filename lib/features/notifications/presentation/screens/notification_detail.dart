// Direct usage example for your NotificationDetails widget
import 'package:ahiaa_web/core/common/widgets/texts/content_texts.dart';
import 'package:flutter/material.dart';

class NotificationDetails extends StatelessWidget {
  const NotificationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    const content = """In this examination, you will be tested on the following subjects: [Insert Subjects e.g., Mathematics, English Language, Biology].
You will be given a total of [X questions], carefully selected from past and model questions in the chosen subjects. These questions are designed to simulate the real WAEC experience and help you practice effectively.
You are expected to read each question carefully before selecting or providing an answer. Use the Next button to move forward, and the Previous button if you wish to return to an earlier question. You may also mark any question for review by selecting the "Review Later" option, which allows you to revisit flagged questions before submission.""";

    return NotificationContentBuilder()
      .addTitle('Your test results are ready!')
      .addSubtitle('Oct. 10 2025, 1:49PM (4 days ago)')
      .addBodyWithAutoParagraphs(content)  // ✨ Automatically splits by \n
      .withStyleConfig(
        const NotificationStyleConfig(
          titleColor: Color(0xFF1F1F1F),
          subtitleColor: Color(0xFF666666),
          bodyColor: Color(0xFF333333),
          titleWeight: FontWeight.w400,
          titleSize: 24,
          subtitleSize: 9,
          bodySize: 10
        ),
      )
      .withPadding(const EdgeInsets.all(24))
      .build();
  }
}