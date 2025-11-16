import 'package:ahiaa_web/core/common/layout/headers/header2.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/images/edge_rounded_images.dart';
import 'package:ahiaa_web/features/authentication/presentation/business/auth_page_cubit/auth_page_controller_cubit.dart';
import 'package:ahiaa_web/features/authentication/presentation/auth_screens/forms/forget_password.dart';
import 'package:ahiaa_web/features/authentication/presentation/auth_screens/forms/login_form.dart';
import 'package:ahiaa_web/features/authentication/presentation/auth_screens/forms/reset_password.dart';
import 'package:ahiaa_web/features/authentication/presentation/auth_screens/forms/signup_form.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/utils/enums/enums.dart';
import 'package:ahiaa_web/core/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' hide Theme;

class AuthDesktop extends StatelessWidget {
  const AuthDesktop(
      {super.key,
      this.shouldUseKai = true,
      this.title = 'Smart WAEC Practice, powered by AI.'});
  final bool shouldUseKai;
  final String title;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);
    final controller = getIt<AuthPageControllerCubit>();
    return Row(
      children: [
        TRoundedContainer(
          padding: const EdgeInsets.all(0),
          width: 628,
          height: responsive.screenHeight,

          // backgroundColor: PColors.primary,
          radius: 0,
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                PColors.primary2,
                PColors.primary2,
                PColors.primary4,
                PColors.tertiary,
                PColors.white
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!shouldUseKai)
                const Padding(
                  padding: EdgeInsets.all(44.0),
                  child: AppDesktopLogo(
                    inverse: true,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(44.0),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineLarge!.apply(
                      fontSizeDelta: -3,
                      fontWeightDelta: 10,
                      color: shouldUseKai ? PColors.white : PColors.primary5,
                      letterSpacingDelta: 1.1),
                ),
              ),
              if (shouldUseKai) const Gap(40),
              if (shouldUseKai)
                const Expanded(
                    child: PRoundedImage(
                  imageType: ImagesType.asset,
                  image: PImages.kaiHappy,
                  width: 628,
                  fit: BoxFit.fill,
                  borderRadius: 0,
                  backgroundColor: PColors.transparent,
                ))
            ],
          ),
        ),
        Expanded(
          child: TRoundedContainer(
            backgroundColor: PColors.transparent,
            height: responsive.screenHeight,
            child: GestureDetector(
              onHorizontalDragEnd: controller.canSwipe,
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller.pageController,
                onPageChanged: controller.changePage,
                allowImplicitScrolling: true,
                children: [
                  SingleChildScrollView(
                      child: LoginForm(
                    controller: controller,
                    shouldUseKai: shouldUseKai,
                  )),
                  SingleChildScrollView(
                      child: SignupForm(
                    controller: controller,
                    shouldUseKai: shouldUseKai,
                  )),
                  SingleChildScrollView(
                      child: ForgotPasswordPage(
                    controller: controller,
                    shouldUseKai: shouldUseKai,
                  )),
                  SingleChildScrollView(
                      child: ResetPasswordPage(
                    controller: controller,
                    shouldUseKai: shouldUseKai,
                  )),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
