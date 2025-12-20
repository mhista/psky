import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/utils/helpers/color_generator.dart';
import 'package:ahiaa_web/features/authentication/presentation/business/cubit/auth_cubit.dart';
import 'package:ahiaa_web/features/authentication/presentation/business/cubit/profile_cubit.dart';
import 'package:ahiaa_web/features/personalization/presentation/cubit/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' hide IconButton;

class UserAvater extends StatelessWidget {
  const UserAvater(
      {super.key,
      this.isExtended = false,
      this.useAddButton = false,
      this.size = 50});
  final bool isExtended, useAddButton;
  final double size;
  @override
  Widget build(BuildContext context) {
    final generator = ColorGenerator();
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return state.maybeWhen(
            orElse: () => const SizedBox.shrink(),
            hasUser: (user) => Stack(
                  children: [
                    if (isExtended)
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: TRoundedContainer(
                          width: 68,
                          height: size,
                          padding: const EdgeInsets.all(0),
                          radius: 28,
                          backgroundColor: PColors.light,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [Icon(Icons.arrow_drop_down), Gap(5)],
                          ),
                        ),
                      ),
                    Avatar(
                      size: size,
                      backgroundColor: generator
                          .fromInitials(user.fullName.capitalizeFirst ?? ''),
                      initials: Avatar.getInitials(user.fullName),
                      provider: user.profilePicture.isNotEmpty
                          ? NetworkImage(user.profilePicture)
                          : null,
                      badge: useAddButton
                          ? AvatarBadge(
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    getIt<ProfileCubit>()
                                        .updateProfilePictureFlow(
                                            userId: user.id,
                                            source: ImageSource.gallery);
                                  },
                                  child: const TRoundedContainer(
                                    padding: EdgeInsets.all(0),
                                    height: 16,
                                    width: 16,
                                    radius: 100,
                                    backgroundColor: PColors.primary,
                                    child: Center(
                                      child: Icon(
                                        Icons.add,
                                        color: PColors.white,
                                        size: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : null,
                    ),
                  ],
                ));
      },
    );
  }
}
