import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ahiaa_web/core/routes/app_router2.dart';
import 'package:ahiaa_web/core/routes/routes.dart';
import 'package:ahiaa_web/features/personalization/presentation/screens/widgets/user_avater.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:flutter/material.dart' hide Colors, Form, FormField, TextField;
import 'package:shadcn_flutter/shadcn_flutter.dart'
    hide Theme, TextButton, Checkbox;

class FavSubject extends StatelessWidget {
  const FavSubject({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        spacing: 28,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            spacing: 15,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
             const UserAvater(),
              SizedBox(
                  width: 381,
                  child: const Text('Pick your favorite subjects to practice')
                      .x3Large
                      .bold
                      .black
                      .textCenter),
            ],
          ),
          Column(
            spacing: 20,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  TRoundedContainer(
                      width: 506,
                      height: 224,
                      radius: 28,
                      padding: const EdgeInsets.only(top: 56),
                      backgroundColor: PColors.primary.withValues(alpha: 0.3),
                      child: ListView.builder(
                          itemBuilder: (context, index) =>
                              const ExamTypeSelector(
                                text: 'WAEC',
                                isSelected: true,
                              ),
                          itemCount: 6)),
                 const SizedBox(
                    width: 506,
                    child: const PSearchContainer(
                      text: 'Select subject...',
                      hasColor: true,
                      radius: 28,
                      useSuffix: false,
                      usePrefixSuffix: true,
                    ),
                  ),
                ],
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  SubjectChip(
                    text: 'English Language',
                    onTap: () {},
                  ),
                  SubjectChip(
                    text: 'Math',
                    onTap: () {},
                  ),
                  SubjectChip(
                    text: 'Chemistry',
                    onTap: () {},
                  ),
                  SubjectChip(
                    text: 'Biology',
                    onTap: () {},
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  getIt<AppRouter>().router.goNamed(KRoutes.onboarding);
                },
                style: ElevatedButton.styleFrom(
                  maximumSize: const Size(490, 56),
                  minimumSize: const Size(490, 56),
                ),
                child: const Text('Continue'),
              ),
              TextButton(onPressed: () {
                getIt<AppRouter>().router.goNamed(KRoutes.dashboard);
              }, child: const Text('Go back'))
            ],
          )
        ],
      ).withPadding(vertical: 40, horizontal: 50),
    );
  }
}



class SubjectChip extends StatelessWidget {
  const SubjectChip({
    super.key,
    this.onTap,
    required this.text,
  });
  final Function()? onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      radius: 12,
      showBorder: true,
      height: 40,
      width: text.length > 10
          ? text.length * 10
          : text.length > 8
              ? text.length * 15
              : text.length * 22,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      borderColor: PColors.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text).xSmall.bold,
          MouseRegion(
              cursor: SystemMouseCursors.click,
              child: InkWell(onTap: onTap, child: const Text('X').xSmall.bold)),
        ],
      ),
    );
  }
}

class ExamTypeSelector extends StatelessWidget {
  const ExamTypeSelector({
    super.key,
    required this.text,
    this.onChecked,
    this.isSelected = false,
  });
  final String text;
  final Function(bool?)? onChecked;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: TRoundedContainer(
        height: 56,
        // radius: 0,
        backgroundColor: !isSelected ? PColors.transparent : null,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text),
          ],
        ),
      ),
    );
  }
}
