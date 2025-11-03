import 'package:ahiaa_web/core/common/widgets/buttons/elevated_r_button.dart';
import 'package:ahiaa_web/core/common/widgets/buttons/outlined_r_button.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Gap(kToolbarHeight),
        TRoundedContainer(
          padding: const EdgeInsets.all(24),
          width: 488,
          height: 384,
          backgroundColor: PColors.tertiary.withValues(alpha: 0.3),
          child: Column(
            spacing: 16,
            children: [
              const Icon(
                Icons.info_rounded,
                color: PColors.bg2,
              ),
              const ResponsiveText('Delete Account').withSize(14).bold,
              const GptMarkdown(
                """
Deleting your account will permanently remove your profile, exam history, progress data, and AI insights. This action cannot be undone.

Before you go, please make sure you’ve:
  • Saved any important reports or results you might need later.
  • Canceled your active subscription (if applicable).

Are you sure you want to continue?""",
                style: TextStyle(fontSize: 12),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  spacing: 5,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TElevatedButton(
                      text: 'Yes, Delete My Account',
                      bgColor: PColors.bg2,
                      color: PColors.white,
                      onTap: () {},
                      verticalPadding: 2,
                    ),
                    TOutlinedButton(
                      text: 'Keep My Account',
                      bgColor: PColors.darkGrey,
                      color: PColors.black,
                      verticalPadding: 2,
                      onTap: () {},
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
