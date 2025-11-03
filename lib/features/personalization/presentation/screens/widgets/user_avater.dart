import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' hide IconButton;

class UserAvater extends StatelessWidget {
   const UserAvater({
    super.key,  this.isExtended = false,  this.useAddButton = true, this.size = 50
  });
 final bool isExtended, useAddButton;
 final double size;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if(isExtended)

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
              children: [
                Icon(Icons.arrow_drop_down),
                Gap(5)
              ],
            ),
                   ),
         ),
        Avatar(
          size: size,
          backgroundColor: PColors.tertiary,
          initials: Avatar.getInitials('Diwe Innocent'),
          // provider: const NetworkImage(
          //     'https://avatars.githubusercontent.com/u/64018564?v=4'),
          badge:useAddButton?  const AvatarBadge(
            child: TRoundedContainer(
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
          ):null,
        ),
       
      ],
    );
  }
}