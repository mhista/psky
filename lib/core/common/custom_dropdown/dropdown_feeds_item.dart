import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class DropdownFeedsItem extends StatefulWidget {
  final IconData? icon;
  final String label;
  final Color? iconColor;
  final bool useIcon, alignRight, userCustomWidget;
  final Widget? iconWidget, customWidget;
  final double? textSize, iconSize;
  final Function()? onTap;

  const DropdownFeedsItem({super.key, 
    this.icon,
    required this.label,
    this.iconColor,
    this.useIcon = false,
    this.alignRight = true,

    this.iconWidget,
    this.onTap,
    this.textSize,
    this.iconSize,  this.userCustomWidget = false, this.customWidget,

  });

  @override
  State<DropdownFeedsItem> createState() => _DropdownFeedsItemState();
}

class _DropdownFeedsItemState extends State<DropdownFeedsItem> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          width: double.infinity,
           duration: const Duration(milliseconds: 200),
            transform: Matrix4.identity()
            ..scale(_isHovered ? 1.05 : 1.0),
          color: _isHovered?PColors.light:PColors.white,
          child: Padding(
            padding:  EdgeInsets.only(left: 8, top: 8, bottom: 5, right: widget.alignRight?8:0),
            child: Row(
              mainAxisAlignment:widget.alignRight? MainAxisAlignment.end:MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!widget.useIcon && !widget.alignRight) Icon(widget.icon, color: widget.iconColor ?? Colors.white, size: widget.iconSize,),
                if (widget.useIcon&& !widget.alignRight) widget.iconWidget!,
                if(widget.icon != null)
                const SizedBox(width: 10),
               widget.userCustomWidget? widget.customWidget! : Flexible(
                  child: ResponsiveText(widget.label,
                  maxLines: 2,
                  softWrap: true,
                  textAlign: widget.alignRight?TextAlign.end:TextAlign.start,
                   style: TextStyle(
                    fontWeight: FontWeight.w400,
                      color:_isHovered?PColors.dark: Colors.black,
                      fontSize: widget.textSize ?? 11,
                      
                  ),),
                ),
                 if(widget.icon != null || widget.iconWidget != null)
                const SizedBox(width: 10),
                if (!widget.useIcon && widget.alignRight) Icon(widget.icon, color: widget.iconColor ?? Colors.white, size: widget.iconSize,),
                if (widget.useIcon&& widget.alignRight) widget.iconWidget!,
                 if( widget.iconWidget != null)
                const SizedBox(width: 10),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
