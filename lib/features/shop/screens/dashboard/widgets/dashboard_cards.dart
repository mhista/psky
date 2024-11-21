import 'package:ahiaa_web/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../common/widgets/texts/section_heading.dart';

class TDashboardCard extends StatelessWidget {
  const TDashboardCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon = Iconsax.arrow_up_3,
    this.color = PColors.success,
    required this.stats,
    this.onTap,
  });
  final String title, subtitle;
  final IconData icon;
  final int stats;
  final Color color;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      onTap: onTap,
      padding: const EdgeInsets.all(PSizes.lg),
      child: Column(
        children: [
          // HEADING
          PSectionHeading(
            title: title,
            textColor: PColors.textSecondary,
            showActionButton: false,
          ),
          const SizedBox(
            height: PSizes.spaceBtwSections,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subtitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Icon(
                        icon,
                        color: PColors.success,
                        size: PSizes.iconSm,
                      ),
                      Text(
                        '$stats%',
                        style: Theme.of(context).textTheme.titleLarge!.apply(
                              color: PColors.success,
                              overflow: TextOverflow.ellipsis,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 135,
                    child: Text(
                      'Compared to Dec 2023',
                      style: Theme.of(context).textTheme.labelMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
