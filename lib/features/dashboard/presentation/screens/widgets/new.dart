import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/images/edge_rounded_images.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/utils/enums/enums.dart';
import 'package:ahiaa_web/core/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class QuickStartWidget extends StatefulWidget {
  const QuickStartWidget({
    super.key,
    required this.bgColor,
    required this.text,
    required this.icon,
    this.useAi = false,
  });

  final Color bgColor;
  final String text;
  final IconData icon;
  final bool useAi;

  @override
  State<QuickStartWidget> createState() => _QuickStartWidgetState();
}

class _QuickStartWidgetState extends State<QuickStartWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: TRoundedContainer(
          height: _isExpanded ? 184 : 72,
          backgroundColor: widget.bgColor.withValues(alpha: 0.3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 12,
                children: [
                  if (widget.useAi)
                    PRoundedImage(
                      onPressed: () {},
                      imageType: ImagesType.asset,
                      image: PImages.ai,
                      height: 40,
                      width: 40,
                      borderRadius: 100,
                    ),
                  if (!widget.useAi)
                    TRoundedContainer(
                      height: 40,
                      width: 40,
                      radius: 100,
                      padding: const EdgeInsets.all(0),
                      backgroundColor: PColors.light.withValues(alpha: 0.8),
                      child: Icon(
                        widget.icon,
                        color: widget.bgColor,
                      ),
                    ),
                  Text(
                    widget.text,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .apply(color: widget.bgColor),
                  ),
                ],
              ),
              Icon(
                _isExpanded
                    ? Icons.arrow_drop_up_rounded
                    : Icons.arrow_drop_down_rounded,
                size: 30,
              )
            ],
          ),
        )
            .animate(target: _isExpanded ? 1 : 0)
            .custom(
              duration: 300.ms,
              curve: Curves.easeInOut,
              builder: (context, value, child) {
                return TRoundedContainer(
                  height: 72 + (112 * value), // 72 + (184-72) * value
                  backgroundColor: widget.bgColor.withValues(alpha: 0.3),
                  child: child,
                );
              },
            ),
      ),
    );
  }
}