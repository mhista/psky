import 'package:flutter/material.dart';

class ResponsiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;
  final double? textScaleFactor;
  final StrutStyle? strutStyle;
  final Locale? locale;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final double? wordSpacing;
  final double? height;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final TextDecorationStyle? decorationStyle;
  final double? decorationThickness;
  final List<Shadow>? shadows;
  final String? fontFamily;
  final List<String>? fontFamilyFallback;
  
  // Responsive scaling options
  final bool enableResponsiveScaling;
  final double minFontSize;
  final double maxFontSize;

  const ResponsiveText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.textScaleFactor,
    this.strutStyle,
    this.locale,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.letterSpacing,
    this.wordSpacing,
    this.height,
    this.decoration,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
    this.shadows,
    this.fontFamily,
    this.fontFamilyFallback,
    this.enableResponsiveScaling = true,
    this.minFontSize = 8,
    this.maxFontSize = 48,
  });
  
  // Convenience method for color
  ResponsiveText copyWith({
    String? text,
    TextStyle? style,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    double? textScaleFactor,
    StrutStyle? strutStyle,
    Locale? locale,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    double? height,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    List<Shadow>? shadows,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    bool? enableResponsiveScaling,
    double? minFontSize,
    double? maxFontSize,
  }) {
    return ResponsiveText(
      text ?? this.text,
      style: style ?? this.style,
      textAlign: textAlign ?? this.textAlign,
      maxLines: maxLines ?? this.maxLines,
      overflow: overflow ?? this.overflow,
      softWrap: softWrap ?? this.softWrap,
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
      strutStyle: strutStyle ?? this.strutStyle,
      locale: locale ?? this.locale,
      textWidthBasis: textWidthBasis ?? this.textWidthBasis,
      textHeightBehavior: textHeightBehavior ?? this.textHeightBehavior,
      color: color ?? this.color,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      fontStyle: fontStyle ?? this.fontStyle,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      wordSpacing: wordSpacing ?? this.wordSpacing,
      height: height ?? this.height,
      decoration: decoration ?? this.decoration,
      decorationColor: decorationColor ?? this.decorationColor,
      decorationStyle: decorationStyle ?? this.decorationStyle,
      decorationThickness: decorationThickness ?? this.decorationThickness,
      shadows: shadows ?? this.shadows,
      fontFamily: fontFamily ?? this.fontFamily,
      fontFamilyFallback: fontFamilyFallback ?? this.fontFamilyFallback,
      enableResponsiveScaling: enableResponsiveScaling ?? this.enableResponsiveScaling,
      minFontSize: minFontSize ?? this.minFontSize,
      maxFontSize: maxFontSize ?? this.maxFontSize,
    );
  }

  double _getResponsiveFontSize(BuildContext context, double baseFontSize) {
    if (!enableResponsiveScaling) return baseFontSize;
    
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Define breakpoints for different screen sizes
    double scaleFactor;
    
    if (screenWidth <= 360) {
      // Small phones - scale down slightly
      scaleFactor = 0.9;
    } else if (screenWidth <= 390) {
      // Average phones (iPhone 12, 13, 14) - no scaling
      scaleFactor = 1.0;
    } else if (screenWidth <= 428) {
      // Larger phones (iPhone Pro Max) - slight scale up
      scaleFactor = 1.05;
    } else if (screenWidth <= 600) {
      // Large phones / Small tablets - moderate scale up
      scaleFactor = 1.1;
    } else if (screenWidth <= 900) {
      // Tablets - more scale up
      scaleFactor = 1.15;
    } else {
      // Large screens - cap the scaling
      scaleFactor = 1.2;
    }
    
    // Apply scale factor and clamp between min and max
    final scaledSize = baseFontSize * scaleFactor;
    return scaledSize.clamp(minFontSize, maxFontSize);
  }

  @override
  Widget build(BuildContext context) {
    // Get base style from theme or provided style
    TextStyle baseStyle = style ?? DefaultTextStyle.of(context).style;
    
    // Get the base font size
    final baseFontSize = fontSize ?? baseStyle.fontSize ?? 14.0;
    
    // Calculate responsive font size
    final responsiveFontSize = _getResponsiveFontSize(context, baseFontSize);
    
    // Merge all style properties
    final finalStyle = baseStyle.copyWith(
      color: color,
      fontSize: responsiveFontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      height: height,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      shadows: shadows,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
    );

    return Text(
      text,
      style: finalStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textScaleFactor: textScaleFactor,
      strutStyle: strutStyle,
      locale: locale,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
    );
  }
}

// Extension methods for easy property chaining
extension ResponsiveTextExtensions on ResponsiveText {
  // Color extensions
  ResponsiveText get white => copyWith(color: Colors.white);
  ResponsiveText get black => copyWith(color: Colors.black);
  ResponsiveText get red => copyWith(color: Colors.red);
  ResponsiveText get blue => copyWith(color: Colors.blue);
  ResponsiveText get green => copyWith(color: Colors.green);
  ResponsiveText get yellow => copyWith(color: Colors.yellow);
  ResponsiveText get orange => copyWith(color: Colors.orange);
  ResponsiveText get purple => copyWith(color: Colors.purple);
  ResponsiveText get grey => copyWith(color: Colors.grey);
  ResponsiveText withColor(Color color) => copyWith(color: color);
  
  // FontWeight extensions
  ResponsiveText get exBold => copyWith(fontWeight: FontWeight.w800);

  ResponsiveText get bold => copyWith(fontWeight: FontWeight.bold);
  ResponsiveText get semiBold => copyWith(fontWeight: FontWeight.w600);
  ResponsiveText get medium => copyWith(fontWeight: FontWeight.w500);
  ResponsiveText get normal => copyWith(fontWeight: FontWeight.normal);
  ResponsiveText get light => copyWith(fontWeight: FontWeight.w300);
  ResponsiveText withWeight(FontWeight weight) => copyWith(fontWeight: weight);
  
  // FontStyle extensions
  ResponsiveText get italic => copyWith(fontStyle: FontStyle.italic);
  
  // TextAlign extensions
  ResponsiveText get center => copyWith(textAlign: TextAlign.center);
  ResponsiveText get left => copyWith(textAlign: TextAlign.left);
  ResponsiveText get right => copyWith(textAlign: TextAlign.right);
  ResponsiveText get justify => copyWith(textAlign: TextAlign.justify);
  ResponsiveText withAlign(TextAlign align) => copyWith(textAlign: align);
  
  // TextDecoration extensions
  ResponsiveText get underline => copyWith(decoration: TextDecoration.underline);
  ResponsiveText get lineThrough => copyWith(decoration: TextDecoration.lineThrough);
  ResponsiveText get overline => copyWith(decoration: TextDecoration.overline);
  ResponsiveText withDecoration(TextDecoration decoration) => copyWith(decoration: decoration);
  
  // Size extensions based on your theme
  ResponsiveText withSize(double size) => copyWith(fontSize: size);
  
  // Theme-based size shortcuts
  ResponsiveText get headlineLarge => copyWith(fontSize: 50, fontWeight: FontWeight.w700);
  ResponsiveText get headlineMedium => copyWith(fontSize: 24, fontWeight: FontWeight.w600);
  ResponsiveText get headlineSmall => copyWith(fontSize: 18, fontWeight: FontWeight.w600);
  ResponsiveText get titleLarge => copyWith(fontSize: 16, fontWeight: FontWeight.w600);
  ResponsiveText get titleMedium => copyWith(fontSize: 16, fontWeight: FontWeight.w500);
  ResponsiveText get titleSmall => copyWith(fontSize: 16, fontWeight: FontWeight.w400);
  ResponsiveText get bodyLarge => copyWith(fontSize: 14, fontWeight: FontWeight.w500);
  ResponsiveText get bodyMedium => copyWith(fontSize: 14, fontWeight: FontWeight.normal);
  ResponsiveText get bodySmall => copyWith(fontSize: 13, fontWeight: FontWeight.w500);
  ResponsiveText get labelLarge => copyWith(fontSize: 12, fontWeight: FontWeight.normal);
  ResponsiveText get labelMedium => copyWith(fontSize: 12, fontWeight: FontWeight.normal);
  
  // Overflow extensions
  ResponsiveText get ellipsis => copyWith(overflow: TextOverflow.ellipsis);
  ResponsiveText get fade => copyWith(overflow: TextOverflow.fade);
  ResponsiveText get clip => copyWith(overflow: TextOverflow.clip);
  ResponsiveText withMaxLines(int lines) => copyWith(maxLines: lines);
  
  // Letter spacing
  ResponsiveText withLetterSpacing(double spacing) => copyWith(letterSpacing: spacing);
  
  // Line height
  ResponsiveText withHeight(double height) => copyWith(height: height);
  
  // Disable/Enable responsive scaling
  ResponsiveText get noResponsive => copyWith(enableResponsiveScaling: false);
  ResponsiveText get responsive => copyWith(enableResponsiveScaling: true);
}
