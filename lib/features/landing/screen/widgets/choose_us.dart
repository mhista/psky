import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ChooseUsWidget extends StatelessWidget {
  const ChooseUsWidget({
    super.key, required this.image, required this.title, required this.subtitle,
  }); 
final String image, title,subtitle;
  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      width: 269,
      height: 200,
      backgroundColor:PColors.primary.withValues(alpha: 0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TRoundedContainer(
            height: 40,
            width: 40,
            padding: const EdgeInsets.all(0),
            radius: 100,
            backgroundColor:PColors.primary.withValues(alpha: 0.3) ,
            child: Image.asset(image),),
          const Gap(20),
          Text(title, style: Theme.of(context).textTheme.titleLarge!.apply(
            color:const Color(
              0xff21005D
            )
          ),),
          const Gap(4),
          Text(subtitle, style: Theme.of(context).textTheme.labelSmall,)
    
        ],
      ),
    );
  }
}
