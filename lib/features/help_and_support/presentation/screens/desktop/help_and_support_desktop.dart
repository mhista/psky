import 'package:ahiaa_web/core/common/custom_dropdown/custom_dropdown_with_search.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/data/help_and_support_data.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/features/help_and_support/presentation/cubits/help_and_support_cubit.dart';
import 'package:ahiaa_web/features/help_and_support/presentation/screens/help_and_support_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HelpAndSupportDesktop extends StatelessWidget {
  const HelpAndSupportDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final helpCubit = getIt<HelpAndSupportCubit>();
    return BlocBuilder<HelpAndSupportCubit, HelpAndSupportPageState>(
      bloc: helpCubit,
      builder: (context, state) {
        return PageView(
          controller: helpCubit.pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: helpCubit.updatePageIndicator,
          children: [
            SingleChildScrollView(
              child: Column(
                spacing: 16,
                children: [
                  // SECTION 1
                  ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 575),
                      child: const PSearchContainer(text: 'Search...')),

                  // SECOND SECTION
                  Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 10,
                      runSpacing: 10,
                      children: HelpData.categories
                          .map((help) => TRoundedContainer(
                                backgroundColor: PColors.light,
                                height: 353,
                                width: 290,
                                child: Column(
                                  spacing: 12,
                                  children: [
                                    Row(
                                      children: [
                                        ResponsiveText(help.title).bold,
                                      ],
                                    ),
                                    const Divider(),
                                    ...help.articles.map((article) => SizedBox(
                                          height: 48,
                                          child: MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: GestureDetector(
                                              onTap: () {
                                                helpCubit.setArticle(article);
                                                helpCubit.next();
                                              },
                                              child: Row(
                                                  spacing: 12,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        child: ResponsiveText(
                                                                article.title)
                                                            .withSize(13)),
                                                    const Icon(Icons
                                                        .keyboard_arrow_right_rounded)
                                                  ]),
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                              ))
                          .toList())
                ],
              ),
            ),
            HelpAndSupportDetails(helpCubit: helpCubit),
          ],
        );
      },
    );
  }
}
