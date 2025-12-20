import 'dart:math';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

/// ColorGenerator - A deterministic color generation utility for Flutter
/// Generates consistent colors across devices based on input strings
/// 
/// Example:
/// ```dart
/// final cg = ColorGenerator();
/// final color = cg.generate("Diwe Innocent"); // Always same color
/// final initialsColor = cg.fromInitials("Diwe Innocent");
/// ```

class ColorGenerator {
  final ColorGeneratorOptions options;

  ColorGenerator({ColorGeneratorOptions? options})
      : options = options ?? ColorGeneratorOptions();

  /// Hash algorithms for deterministic number generation
  int _hash(String str, {HashAlgorithm? algorithm}) {
    algorithm ??= options.algorithm;
    
    switch (algorithm) {
      case HashAlgorithm.djb2:
        return _djb2Hash(str);
      case HashAlgorithm.sdbm:
        return _sdbmHash(str);
      case HashAlgorithm.fnv1a:
        return _fnv1aHash(str);
    }
  }

  int _djb2Hash(String str) {
    int hash = 5381;
    for (int i = 0; i < str.length; i++) {
      hash = ((hash << 5) + hash) + str.codeUnitAt(i);
    }
    return hash.abs();
  }

  int _sdbmHash(String str) {
    int hash = 0;
    for (int i = 0; i < str.length; i++) {
      hash = str.codeUnitAt(i) + (hash << 6) + (hash << 16) - hash;
    }
    return hash.abs();
  }

  int _fnv1aHash(String str) {
    int hash = 2166136261;
    for (int i = 0; i < str.length; i++) {
      hash ^= str.codeUnitAt(i);
      hash += (hash << 1) + (hash << 4) + (hash << 7) + (hash << 8) + (hash << 24);
    }
    return hash.abs();
  }

  /// Generate color from full string
  Color generate(String input) {
    final hash = _hash(input.toLowerCase());
    final hue = (hash % 360).toDouble();
    
    final modeConfig = _getModeConfig(options.mode);
    final satRange = modeConfig['saturation'] as List<double>;
    final lightRange = modeConfig['lightness'] as List<double>;
    
    final sat = satRange[0] + (hash % (satRange[1] - satRange[0]).toInt());
    final light = lightRange[0] + (hash % (lightRange[1] - lightRange[0]).toInt());
    
    return _hslToColor(hue, sat, light);
  }

  /// Generate color from initials (e.g., "Diwe Innocent" -> "DI")
  Color fromInitials(String input) {
    final initials = input
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .map((word) => word[0].toUpperCase())
        .join('');
    
    return generate(initials);
  }

  /// Generate color from first word only
  Color fromFirstWord(String input) {
    final firstWord = input.split(RegExp(r'\s+'))[0];
    return generate(firstWord);
  }

  /// Generate color from last word only
  Color fromLastWord(String input) {
    final words = input.split(RegExp(r'\s+'));
    final lastWord = words.isNotEmpty ? words.last : input;
    return generate(lastWord);
  }

  /// Generate color based on character count
  Color fromLength(String input) {
    final length = input.replaceAll(RegExp(r'\s+'), '').length;
    return generate(length.toString());
  }

  /// Generate color based on vowel count
  Color fromVowelCount(String input) {
    final vowels = input.toLowerCase().replaceAll(RegExp(r'[^aeiou]'), '');
    return generate(vowels.length.toString());
  }

  /// Generate color based on consonant pattern
  Color fromConsonantPattern(String input) {
    final consonants = input.toLowerCase().replaceAll(RegExp(r'[^bcdfghjklmnpqrstvwxyz]'), '');
    return generate(consonants);
  }

  /// Generate a palette of colors from input
  List<ColorInfo> generatePalette(String input, {int count = 5}) {
    final palette = <ColorInfo>[];
    
    for (int i = 0; i < count; i++) {
      final hash = _hash(input + i.toString());
      final hue = (hash % 360).toDouble();
      
      final modeConfig = _getModeConfig(options.mode);
      final satRange = modeConfig['saturation'] as List<double>;
      final lightRange = modeConfig['lightness'] as List<double>;
      
      final sat = satRange[0] + (hash % (satRange[1] - satRange[0]).toInt());
      final light = lightRange[0] + (hash % (lightRange[1] - lightRange[0]).toInt());
      
      final color = _hslToColor(hue, sat, light);
      palette.add(ColorInfo(
        color: color,
        hsl: HSLColor.fromColor(color),
        input: '$input-$i',
      ));
    }
    
    return palette;
  }

  /// Generate color schemes (complementary, triadic, analogous, etc.)
  List<Color> generateScheme(String input, {ColorScheme scheme = ColorScheme.complementary}) {
    final hash = _hash(input.toLowerCase());
    final baseHue = (hash % 360).toDouble();
    
    final modeConfig = _getModeConfig(options.mode);
    final satRange = modeConfig['saturation'] as List<double>;
    final lightRange = modeConfig['lightness'] as List<double>;
    
    final sat = satRange[0] + (hash % (satRange[1] - satRange[0]).toInt());
    final light = lightRange[0] + (hash % (lightRange[1] - lightRange[0]).toInt());
    
    final List<double> hueOffsets;
    switch (scheme) {
      case ColorScheme.complementary:
        hueOffsets = [0, 180];
        break;
      case ColorScheme.triadic:
        hueOffsets = [0, 120, 240];
        break;
      case ColorScheme.analogous:
        hueOffsets = [0, 30, 60];
        break;
      case ColorScheme.splitComplementary:
        hueOffsets = [0, 150, 210];
        break;
      case ColorScheme.tetradic:
        hueOffsets = [0, 90, 180, 270];
        break;
      case ColorScheme.square:
        hueOffsets = [0, 90, 180, 270];
        break;
    }
    
    return hueOffsets.map((offset) {
      final hue = (baseHue + offset) % 360;
      return _hslToColor(hue, sat, light);
    }).toList();
  }

  /// Generate gradient between two inputs
  List<Color> generateGradient(String input1, String input2, {int steps = 5}) {
    final color1 = generate(input1);
    final color2 = generate(input2);
    
    final hsl1 = HSLColor.fromColor(color1);
    final hsl2 = HSLColor.fromColor(color2);
    
    final gradient = <Color>[];
    
    for (int i = 0; i < steps; i++) {
      final t = i / (steps - 1);
      final h = hsl1.hue + (hsl2.hue - hsl1.hue) * t;
      final s = hsl1.saturation + (hsl2.saturation - hsl1.saturation) * t;
      final l = hsl1.lightness + (hsl2.lightness - hsl1.lightness) * t;
      
      gradient.add(_hslToColor(h, s * 100, l * 100));
    }
    
    return gradient;
  }

  /// Get detailed color information including accessibility
  ColorInfo getColorInfo(String input) {
    final color = generate(input);
    final hsl = HSLColor.fromColor(color);
    
    final luminance = color.computeLuminance();
    final contrastWithWhite = _getContrastRatio(luminance, 1.0);
    final contrastWithBlack = _getContrastRatio(luminance, 0.0);
    
    return ColorInfo(
      input: input,
      color: color,
      hsl: hsl,
      luminance: luminance,
      contrastWithWhite: contrastWithWhite,
      contrastWithBlack: contrastWithBlack,
      isAccessibleOnWhite: contrastWithWhite >= 4.5,
      isAccessibleOnBlack: contrastWithBlack >= 4.5,
    );
  }

  /// Generate text color (black or white) based on background
  Color getTextColor(String input) {
    final bgColor = generate(input);
    final luminance = bgColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  /// Generate a Material Color swatch from input
  MaterialColor generateMaterialColor(String input) {
    final baseColor = generate(input);
    final hsl = HSLColor.fromColor(baseColor);
    
    return MaterialColor(
      baseColor.value,
      <int, Color>{
        50: _hslToColor(hsl.hue, hsl.saturation * 100, 95),
        100: _hslToColor(hsl.hue, hsl.saturation * 100, 90),
        200: _hslToColor(hsl.hue, hsl.saturation * 100, 80),
        300: _hslToColor(hsl.hue, hsl.saturation * 100, 70),
        400: _hslToColor(hsl.hue, hsl.saturation * 100, 60),
        500: baseColor,
        600: _hslToColor(hsl.hue, hsl.saturation * 100, 45),
        700: _hslToColor(hsl.hue, hsl.saturation * 100, 35),
        800: _hslToColor(hsl.hue, hsl.saturation * 100, 25),
        900: _hslToColor(hsl.hue, hsl.saturation * 100, 15),
      },
    );
  }

  // Helper methods
  Map<String, dynamic> _getModeConfig(ColorMode mode) {
    switch (mode) {
      case ColorMode.vibrant:
        return {'saturation': [60.0, 80.0], 'lightness': [45.0, 65.0]};
      case ColorMode.pastel:
        return {'saturation': [30.0, 50.0], 'lightness': [70.0, 85.0]};
      case ColorMode.dark:
        return {'saturation': [50.0, 70.0], 'lightness': [25.0, 40.0]};
      case ColorMode.light:
        return {'saturation': [40.0, 60.0], 'lightness': [75.0, 90.0]};
      case ColorMode.neon:
        return {'saturation': [90.0, 100.0], 'lightness': [50.0, 60.0]};
    }
  }

  Color _hslToColor(double h, double s, double l) {
    return HSLColor.fromAHSL(1.0, h, s / 100, l / 100).toColor();
  }

  double _getContrastRatio(double lum1, double lum2) {
    final lighter = max(lum1, lum2);
    final darker = min(lum1, lum2);
    return (lighter + 0.05) / (darker + 0.05);
  }
}

/// Configuration options for ColorGenerator
class ColorGeneratorOptions {
  final ColorMode mode;
  final HashAlgorithm algorithm;

  const ColorGeneratorOptions({
    this.mode = ColorMode.vibrant,
    this.algorithm = HashAlgorithm.djb2,
  });
}

/// Color modes for different aesthetics
enum ColorMode {
  vibrant,
  pastel,
  dark,
  light,
  neon,
}

/// Hash algorithms
enum HashAlgorithm {
  djb2,
  sdbm,
  fnv1a,
}

/// Color schemes
enum ColorScheme {
  complementary,
  triadic,
  analogous,
  splitComplementary,
  tetradic,
  square,
}

/// Detailed color information
class ColorInfo {
  final String input;
  final Color color;
  final HSLColor hsl;
  final double? luminance;
  final double? contrastWithWhite;
  final double? contrastWithBlack;
  final bool? isAccessibleOnWhite;
  final bool? isAccessibleOnBlack;

  ColorInfo({
    required this.input,
    required this.color,
    required this.hsl,
    this.luminance,
    this.contrastWithWhite,
    this.contrastWithBlack,
    this.isAccessibleOnWhite,
    this.isAccessibleOnBlack,
  });

  String get hexString => '#${color.value.toRadixString(16).padLeft(8, '0').substring(2)}';
  
  String get rgbString => 'rgb(${color.red}, ${color.green}, ${color.blue})';
  
  String get hslString => 
      'hsl(${hsl.hue.toStringAsFixed(0)}, ${(hsl.saturation * 100).toStringAsFixed(0)}%, ${(hsl.lightness * 100).toStringAsFixed(0)}%)';

  @override
  String toString() {
    return '''
ColorInfo:
  Input: $input
  Hex: $hexString
  RGB: $rgbString
  HSL: $hslString
  Luminance: ${luminance?.toStringAsFixed(3)}
  Contrast (White): ${contrastWithWhite?.toStringAsFixed(2)}
  Contrast (Black): ${contrastWithBlack?.toStringAsFixed(2)}
  Accessible on White: $isAccessibleOnWhite
  Accessible on Black: $isAccessibleOnBlack
    ''';
  }
}

// USAGE EXAMPLES:
/*

// Basic usage
void main() {
  final generator = ColorGenerator();
  
  // Generate color from full name
  final color1 = generator.generate("Diwe Innocent");
  print(color1); // Always produces same color
  
  // Generate from initials
  final color2 = generator.fromInitials("Diwe Innocent"); // "DI"
  
  // Generate from first name only
  final color3 = generator.fromFirstWord("Diwe Innocent");
  
  // Different modes
  final pastelGenerator = ColorGenerator(
    options: ColorGeneratorOptions(mode: ColorMode.pastel)
  );
  final pastelColor = pastelGenerator.generate("Diwe");
  
  // Get detailed color info
  final info = generator.getColorInfo("Diwe Innocent");
  print(info.hexString);
  print(info.isAccessibleOnWhite);
  
  // Generate color schemes
  final complementary = generator.generateScheme(
    "Diwe Innocent",
    scheme: ColorScheme.complementary
  );
  
  // Generate palette
  final palette = generator.generatePalette("Diwe", count: 5);
  
  // Generate Material Color
  final materialColor = generator.generateMaterialColor("Diwe Innocent");
  
  // Get appropriate text color for background
  final textColor = generator.getTextColor("Diwe Innocent");
  
  // Generate gradient
  final gradient = generator.generateGradient("Diwe", "Innocent", steps: 10);
}

// In a Flutter Widget
class UserAvatar extends StatelessWidget {
  final String name;
  
  const UserAvatar({required this.name});
  
  @override
  Widget build(BuildContext context) {
    final generator = ColorGenerator();
    final bgColor = generator.fromInitials(name);
    final textColor = generator.getTextColor(name);
    final initials = name
        .split(RegExp(r'\s+'))
        .map((word) => word[0].toUpperCase())
        .take(2)
        .join('');
    
    return CircleAvatar(
      backgroundColor: bgColor,
      child: Text(
        initials,
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}

*/