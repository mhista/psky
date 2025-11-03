import 'package:ahiaa_web/core/common/widgets/buttons/elevated_r_button.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/images/edge_rounded_images.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/utils/enums/enums.dart';
import 'package:ahiaa_web/core/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';

class QuickStartWidget extends StatefulWidget {
  const QuickStartWidget({
    super.key,
    required this.bgColor,
    required this.text,
    required this.icon,
    this.useAi = false,
    this.isAlreadyExpanded = false, required this.buttonText, required this.subtitle, this.addEndSpacing = false,

  });

  final Color bgColor;
  final String text;
  final IconData icon;
  final bool useAi, isAlreadyExpanded, addEndSpacing;
  final String buttonText, subtitle;


  @override
  State<QuickStartWidget> createState() => _QuickStartWidgetState();
}

class _QuickStartWidgetState extends State<QuickStartWidget> {
  bool _isExpanded = false;
  
  @override
  initState(){
    super.initState();
  
      if(widget.isAlreadyExpanded){
        setState(() {
            _isExpanded = true;
          
        });
      }
  }

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
        child: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Container(
            margin: EdgeInsets.only(right:widget.addEndSpacing? 16:0),
            decoration: BoxDecoration(
              color: widget.bgColor.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              spacing: 10,
              children: [
                Row(
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
                    if(!widget.isAlreadyExpanded)
                    Icon(
                      _isExpanded
                          ? Icons.arrow_drop_up_rounded
                          : Icons.arrow_drop_down_rounded,
                      size: 30,
                    )
                  ],
                ),
                if (_isExpanded || (widget.isAlreadyExpanded == true)) ...[
                  Padding(
                    padding: const EdgeInsets.only(right: 40),
                    child: ResponsiveText(
                      widget.subtitle,
                    ).withSize(10).withColor(PColors.black),
                  ),
                  const SizedBox(height: 8),
                   TElevatedButton(
                    onTap: () {
                      
                    },
                    text: widget.buttonText,
                    bgColor: PColors.white,
                    size: 8,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}