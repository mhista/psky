import 'package:ahiaa_web/core/common/widgets/buttons/elevated_r_button.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/images/edge_rounded_images.dart';
import 'package:ahiaa_web/core/common/widgets/shimmer/three_to_one_shimmer.dart'
    show ThreeToOneShimmer;
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_cubit.dart';
import 'package:ahiaa_web/features/test/presentation/screens/widgets/text_containers.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/utils/enums/enums.dart';
import 'package:ahiaa_web/core/utils/constants/image_strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:shadcn_flutter/shadcn_flutter.dart';

class TestScreenSecondSection extends StatelessWidget {
  const TestScreenSecondSection({
    super.key,
    required this.isLoading,
    required this.hasData,
    required this.hasError,
    required this.isFirstTime,
  });

  final bool isLoading;
  final bool hasData;
  final bool hasError;
  final bool isFirstTime;

  @override
  Widget build(BuildContext context) {
    final examCubit = getIt<ExamCubit>();
    final responsive = ResponsiveBreakpoints.of(context);


    return BlocBuilder<ExamCubit, ExamState>(
      bloc: examCubit,
      builder: (context, state) {
        final progress = examCubit.getAllActiveSessions();
        final list = progress.length > 6 ? progress.take(6) : progress;
        final isFirstTime = progress.isEmpty;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            const ResponsiveText('Ongoing Tests').withSize(responsive.isMobile? 24: 28).bold,
            ThreeToOneShimmer(
                isLoading: isLoading,
                hasData: hasData,
                hasError: hasError,
                width: double.infinity,
                radius: 16,
                // height:responsive.isMobile? double.infinity: 185,
                useFunction: true,
                errorText:
                    "Something went wrong while fetching yor tests. Please refresh",
                errorColor: PColors.tertiary.withValues(alpha: 0.5),
                // shouldUseLoadedData: true,
                loadedWidget: TRoundedContainer(
                    backgroundColor: isFirstTime
                        ? PColors.primary.withValues(alpha: 0.4)
                        : null,
                    padding: isFirstTime
                        ? const EdgeInsets.only(right: 16, top: 16)
                        : const EdgeInsets.only(right: 0, top: 0),
                    // height:responsive.isMobile? double.infinity: 185,
                    width: double.infinity,
                    child: isFirstTime
                        ? Row(
                            spacing: 30,
                            children: [
                              const PRoundedImage(
                                imageType: ImagesType.asset,
                                image: PImages.kaiTest,
                                height: 166,
                                width: 290,
                                fit: BoxFit.fill,
                                padding: 0,
                                borderRadius: 12,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const ResponsiveText('No tests in progress')
                                      .withOpacity(0.6)
                                      .bold,
                                  const Gap(5),
                                  const ResponsiveText(
                                          ' Ready to start practicing')
                                      .withOpacity(0.6)
                                      .bold,
                                  const Gap(10),
                                  const TElevatedButton(
                                    text: 'Start Mock Exam',
                                    bgColor: PColors.primary,
                                    color: PColors.white,
                                    density: -2,
                                    verticalPadding: 2,
                                    size: 10,
                                  ),
                                ],
                              )
                            ],
                          )
                        : Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            alignment: WrapAlignment.center,
                            children: list
                                .map((p) =>  TestContainers(session: p,))
                                .toList(),
                          ))),
          ],
        );
      },
    );
  }
}
