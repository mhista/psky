import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' hide Checkbox;

class NotificationSettings extends StatelessWidget {
  const NotificationSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Column(
         spacing: 28,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Notifications').x3Large.bold.black,
          TRoundedContainer(
            backgroundColor: PColors.light,
            width: double.infinity,
            
            child: Column(
              children: [
                  TRoundedContainer(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          spacing: 6,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const ResponsiveText(
                              'Test Reminders'
                            ).withSize(12),
                            const ResponsiveText(
                              'Get notified when it’s time for a scheduled or saved test.'
                            ).withSize(10)
                          ],
                        ),
                        Checkbox(value: true, onChanged: (v){})
                      ],
                    ),
                  )
              ],
            ),
          )
          ]
          
      ),
    );
  }
}