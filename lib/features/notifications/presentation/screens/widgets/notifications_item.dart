// Reusable Notification Item Widget
import 'package:ahiaa_web/core/common/widgets/buttons/elevated_r_button.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/images/edge_rounded_images.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/utils/constants/image_strings.dart' show PImages;
import 'package:ahiaa_web/core/utils/enums/enums.dart';
import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final String timeAgo;
  final String title;
  final String subtitle;
  final String imageUrl;
  final ImagesType imageType;
  final VoidCallback onViewReport;
  final bool isRead;

  const NotificationItem({
    Key? key,
    required this.timeAgo,
    required this.title,
    required this.subtitle,
    this.imageUrl = PImages.filter,
    this.imageType = ImagesType.asset,
    required this.onViewReport,
    this.isRead = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      backgroundColor: isRead ? PColors.light : PColors.light,
      padding: const EdgeInsets.all(16),
      radius: 12,
      showBorder: true,
      borderColor: PColors.light,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Leading Image
          PRoundedImage(
            imageType: imageType,
            image: imageUrl,
            fit: BoxFit.scaleDown,
            width: 48,
            height: 48,
          ),

          const SizedBox(width: 16),

          // Content Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Time ago
                ResponsiveText(timeAgo)
                    .withSize(6)
                    .withColor(PColors.deepBlack.withValues(alpha: 0.6)),

                const SizedBox(height: 4),

                // Title
                ResponsiveText(title)
                    .withSize(9)
                    .bold
                    .withColor(PColors.deepBlack),

                const SizedBox(height: 4),

                // Subtitle
                ResponsiveText(subtitle)
                    .withSize(7)
                    .withColor(PColors.deepBlack.withValues(alpha: 0.7))
                    .withMaxLines(2),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // Trailing Button
          TElevatedButton(
            text: 'View Report',
            onTap: onViewReport,
            bgColor: PColors.primary,
            color: PColors.white,
          ),
        ],
      ),
    );
  }
}