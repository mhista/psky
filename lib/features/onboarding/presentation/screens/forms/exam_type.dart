import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/routes/app_router2.dart';
import 'package:ahiaa_web/core/routes/routes.dart';
import 'package:ahiaa_web/features/personalization/presentation/screens/widgets/user_avater.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:flutter/material.dart' hide Colors, Form, FormField, TextField;
import 'package:shadcn_flutter/shadcn_flutter.dart'
    hide Theme, TextButton, Checkbox;

class ExamType extends StatelessWidget {
  const ExamType({super.key});

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
                  child: const Text('Which exams are you preparing for?')
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
              TRoundedContainer(
                width: 506,
                height: 224,
                padding: const EdgeInsets.all(0),
                backgroundColor: PColors.primary.withValues(alpha: 0.3),
                child: const Column(
                  children: [
                    ExamTypeSelector(text: 'WAEC', isSelected: true,),
                    ExamTypeSelector(text: 'JAMB'),
                    ExamTypeSelector(text: 'NECO'),
                    ExamTypeSelector(text: 'Others'),

                    
                  ],
                ),
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
              TextButton(onPressed: () {}, child: const Text('Go back'))
            ],
          )
        ],
      ).withPadding(vertical: 40, horizontal: 50),
    );
  }
}

class ExamTypeSelector extends StatelessWidget {
  const ExamTypeSelector({
    super.key, required this.text, this.onChecked, this.isSelected = false,
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
        backgroundColor: !isSelected? PColors.transparent:null,
        gradient: !isSelected? null:  LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              PColors.primary.withValues(alpha: 0.3),
              PColors.primary.withValues(alpha: 0.3),
              PColors.primary.withValues(alpha: 0.3),
      
              PColors.primary.withValues(alpha: 0.5),
             
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Text(text),
            Checkbox(value: isSelected, onChanged: onChecked)
          ],
        ),
      ),
    );
  }
}
