import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/features/test/presentation/screens/widgets/test_screen_first_section.dart';
import 'package:ahiaa_web/features/test/presentation/screens/widgets/test_screen_second_section.dart';
import 'package:ahiaa_web/features/test/presentation/screens/widgets/test_screen_third_section.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' hide TextButton;

class DesktopTestScreen extends StatelessWidget {
  const DesktopTestScreen(
      {super.key,
      this.isLoading = false,
      this.hasError = false,
      this.expand = false,
      this.isFirstTime = false,
      this.hasData = true});
  final bool isLoading, hasError, hasData, expand, isFirstTime;
  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: const EdgeInsets.all(0),
      child: SingleChildScrollView(
        child: Column(
          spacing: 12,
          children: [
                // FIRST SECTION

            TestScreenFirstSection(isLoading: isLoading, hasData: hasData, hasError: hasError),
            // SECOND SECTION
            TestScreenSecondSection(isLoading: isLoading, hasData: hasData, hasError: hasError, isFirstTime: isFirstTime),
            TestScreenThirdSection(isLoading: isLoading, hasData: hasData, hasError: hasError, isFirstTime: isFirstTime)
          ],
        ),
      ),
    );
  }
}



