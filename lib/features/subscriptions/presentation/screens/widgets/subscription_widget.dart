import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SubscriptionWidget extends StatelessWidget {
  const SubscriptionWidget({
    super.key,
    required this.plan,
    required this.discountText,
    required this.duration,
    required this.isSubscribed,
    required this.price,
    required this.items,
  });
  final String plan, discountText, duration, price;
  final bool isSubscribed;
  final List<(bool, String)> items;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      showBorder: true,
      height: 308,
      width: 285,
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveText(plan).withSize(13).bold,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                   ResponsiveText('₦$price ').withSize(18).bold,
                  ResponsiveText('/ $duration')
                      .withSize(9)
                      .withPadding(top: 5)
                      .withOpacity(0.6),
                ],
              ),
              ResponsiveText(discountText).withSize(9),
            ],
          ),
          SizedBox(
              width: double.infinity,
              height: 32,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // backgroundColor: isSubscribed?PColors.
                ),
                  onPressed:isSubscribed?null: () {},
                  child: const ResponsiveText('Subscribe').withSize(9).withColor(isSubscribed?PColors.white:PColors.white))),
          Expanded(
              child: ListView.separated(
                  itemBuilder: (_, index) {
                    final item = items[index];
                    return Row(
                      spacing: 8,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          item.$1 == false ? Icons.close : Icons.check,
                          size: 12,
                        ),
                        Flexible(child: ResponsiveText(item.$2, overflow: TextOverflow.ellipsis,).withSize(8)),
                      ],
                    );
                  },
                  separatorBuilder: (_, __) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: items.length))
        ],
      ),
    );
  }
}