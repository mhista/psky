import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@singleton
class ResponsiveUtils {
  // Base design dimensions (your original design size)
  static const double _baseWidth = 360.0;
  static const double _baseHeight = 690.0;
  // Get current device type
  static DeviceType getDeviceType(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 450) return DeviceType.mobile;
    if (screenWidth <= 800) return DeviceType.tablet;
    if (screenWidth <= 1920) return DeviceType.desktop;
    return DeviceType.ultrawide;
  }

  // Get scale factor based on current screen size
  static double getScaleFactor(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final deviceType = getDeviceType(context);

    switch (deviceType) {
      case DeviceType.mobile:
        return screenWidth / _baseWidth;
      case DeviceType.tablet:
        return (screenWidth / _baseWidth) *
            0.8; // Slightly smaller scale for tablets
      case DeviceType.desktop:
        return (screenWidth / _baseWidth) *
            0.6; // Much smaller scale for desktop
      case DeviceType.ultrawide:
        return (screenWidth / _baseWidth) * 0.4; // Even smaller for ultra-wide
    }
  }

  // Get responsive font size
  static double fontSize(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
    double? ultrawide,
    double? minSize,
    double? maxSize,
  }) {
    double size;
    final deviceType = getDeviceType(context);

    if (kIsWeb) {
      // For web, use predefined sizes or calculate based on screen
      switch (deviceType) {
        case DeviceType.ultrawide:
          size = ultrawide ?? desktop ?? (mobile * 1.4);
          break;
        case DeviceType.desktop:
          size = desktop ?? (mobile * 1.2);
          break;
        case DeviceType.tablet:
          size = tablet ?? (mobile * 1.1);
          break;
        case DeviceType.mobile:
          size = mobile;
          break;
      }
    } else {
      // For mobile, scale based on screen size
      final scaleFactor = getScaleFactor(context);
      size = mobile * scaleFactor;
    }

    // Apply min/max constraints
    if (minSize != null) size = size.clamp(minSize, double.infinity);
    if (maxSize != null) size = size.clamp(0, maxSize);

    return size;
  }

  // Get responsive spacing
  static double spacing(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
    double? ultrawide,
  }) {
    final deviceType = getDeviceType(context);

    if (kIsWeb) {
      switch (deviceType) {
        case DeviceType.ultrawide:
          return ultrawide ?? desktop ?? (mobile * 2.0);
        case DeviceType.desktop:
          return desktop ?? (mobile * 1.5);
        case DeviceType.tablet:
          return tablet ?? (mobile * 1.2);
        case DeviceType.mobile:
          return mobile;
      }
    } else {
      final scaleFactor = getScaleFactor(context);
      return mobile * scaleFactor;
    }
  }

  // Get responsive width
  static double width(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
    double? ultrawide,
  }) {
    final deviceType = getDeviceType(context);

    if (kIsWeb) {
      switch (deviceType) {
        case DeviceType.ultrawide:
          return ultrawide ?? desktop ?? (mobile * 3.0);
        case DeviceType.desktop:
          return desktop ?? (mobile * 2.0);
        case DeviceType.tablet:
          return tablet ?? (mobile * 1.5);
        case DeviceType.mobile:
          return mobile;
      }
    } else {
      final scaleFactor = getScaleFactor(context);
      return mobile * scaleFactor;
    }
  }

  // Get responsive height
  static double height(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
    double? ultrawide,
  }) {
    final deviceType = getDeviceType(context);

    if (kIsWeb) {
      switch (deviceType) {
        case DeviceType.ultrawide:
          return ultrawide ?? desktop ?? (mobile * 1.4);
        case DeviceType.desktop:
          return desktop ?? (mobile * 1.2);
        case DeviceType.tablet:
          return tablet ?? (mobile * 1.1);
        case DeviceType.mobile:
          return mobile;
      }
    } else {
      final scaleFactor = getScaleFactor(context);
      return mobile * scaleFactor;
    }
  }

  // Get max width for content on web to prevent stretching
  static double getMaxContentWidth(BuildContext context) {
    final deviceType = getDeviceType(context);

    switch (deviceType) {
      case DeviceType.ultrawide:
        return 1600;
      case DeviceType.desktop:
        return 1200;
      case DeviceType.tablet:
        return 768;
      case DeviceType.mobile:
        return double.infinity;
    }
  }

  // Get responsive padding with context-aware values
  static EdgeInsets getPadding(
    BuildContext context, {
    EdgeInsets? mobile,
    EdgeInsets? tablet,
    EdgeInsets? desktop,
    EdgeInsets? ultrawide,
  }) {
    final deviceType = getDeviceType(context);
    final defaultMobile = mobile ?? const EdgeInsets.all(16);

    switch (deviceType) {
      case DeviceType.ultrawide:
        return ultrawide ??
            desktop ??
            const EdgeInsets.symmetric(horizontal: 60, vertical: 32);
      case DeviceType.desktop:
        return desktop ??
            const EdgeInsets.symmetric(horizontal: 40, vertical: 24);
      case DeviceType.tablet:
        return tablet ??
            const EdgeInsets.symmetric(horizontal: 24, vertical: 20);
      case DeviceType.mobile:
        if (kIsWeb) {
          return defaultMobile;
        } else {
          final scaleFactor = getScaleFactor(context);
          return EdgeInsets.all(defaultMobile.left * scaleFactor);
        }
    }
  }

  // Get responsive margin
  static EdgeInsets getMargin(
    BuildContext context, {
    EdgeInsets? mobile,
    EdgeInsets? tablet,
    EdgeInsets? desktop,
    EdgeInsets? ultrawide,
  }) {
    final deviceType = getDeviceType(context);
    final defaultMobile = mobile ?? const EdgeInsets.all(8);

    switch (deviceType) {
      case DeviceType.ultrawide:
        return ultrawide ??
            desktop ??
            const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
      case DeviceType.desktop:
        return desktop ??
            const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
      case DeviceType.tablet:
        return tablet ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 10);
      case DeviceType.mobile:
        if (kIsWeb) {
          return defaultMobile;
        } else {
          final scaleFactor = getScaleFactor(context);
          return EdgeInsets.all(defaultMobile.left * scaleFactor);
        }
    }
  }

  // Get responsive border radius
  static BorderRadius getBorderRadius(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
    double? ultrawide,
  }) {
    final deviceType = getDeviceType(context);
    double radius;

    switch (deviceType) {
      case DeviceType.ultrawide:
        radius = ultrawide ?? desktop ?? (mobile * 1.5);
        break;
      case DeviceType.desktop:
        radius = desktop ?? (mobile * 1.3);
        break;
      case DeviceType.tablet:
        radius = tablet ?? (mobile * 1.1);
        break;
      case DeviceType.mobile:
        if (kIsWeb) {
          radius = mobile;
        } else {
          final scaleFactor = getScaleFactor(context);
          radius = mobile * scaleFactor;
        }
        break;
    }

    return BorderRadius.circular(radius);
  }

  // Get responsive icon size
  static double getIconSize(
    BuildContext context, {
    double mobile = 24,
    double? tablet,
    double? desktop,
    double? ultrawide,
  }) {
    return fontSize(
      context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      ultrawide: ultrawide,
    );
  }

  // Get responsive button height
  static double getButtonHeight(BuildContext context) {
    final deviceType = getDeviceType(context);

    switch (deviceType) {
      case DeviceType.ultrawide:
      case DeviceType.desktop:
        return 56;
      case DeviceType.tablet:
        return 52;
      case DeviceType.mobile:
        if (kIsWeb) {
          return 48;
        } else {
          final scaleFactor = getScaleFactor(context);
          return 48 * scaleFactor;
        }
    }
  }

  // Get responsive grid columns
  static int getGridColumns(BuildContext context, {int maxColumns = 4}) {
    final deviceType = getDeviceType(context);

    switch (deviceType) {
      case DeviceType.ultrawide:
        return maxColumns;
      case DeviceType.desktop:
        return (maxColumns * 0.8).round().clamp(1, maxColumns);
      case DeviceType.tablet:
        return (maxColumns * 0.6).round().clamp(1, maxColumns);
      case DeviceType.mobile:
        return (maxColumns * 0.4).round().clamp(1, 2);
    }
  }

  // Check if current device is touch-enabled (useful for web)
  static bool isTouchDevice(BuildContext context) {
    return kIsWeb ? getDeviceType(context) == DeviceType.mobile : true;
  }

  // Get responsive container constraints
  static BoxConstraints getContainerConstraints(BuildContext context) {
    final maxWidth = getMaxContentWidth(context);
    final deviceType = getDeviceType(context);

    return BoxConstraints(
      maxWidth: maxWidth,
      minHeight: deviceType == DeviceType.mobile ? 0 : 200,
    );
  }

  // Helper method to get screen breakpoint info
  static ScreenBreakpoint getBreakpointInfo(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final deviceType = getDeviceType(context);
    final scaleFactor = getScaleFactor(context);

    return ScreenBreakpoint(
      width: screenWidth,
      height: screenHeight,
      deviceType: deviceType,
      scaleFactor: scaleFactor,
      isPortrait: screenHeight > screenWidth,
      isLandscape: screenWidth > screenHeight,
    );
  }

  // static get desktop =>
}

// Enums and helper classes
enum DeviceType { mobile, tablet, desktop, ultrawide }

class ScreenBreakpoint {
  final double width;
  final double height;
  final DeviceType deviceType;
  final double scaleFactor;
  final bool isPortrait;
  final bool isLandscape;

  const ScreenBreakpoint({
    required this.width,
    required this.height,
    required this.deviceType,
    required this.scaleFactor,
    required this.isPortrait,
    required this.isLandscape,
  });

  @override
  String toString() {
    return 'ScreenBreakpoint(${deviceType.name}, ${width}x$height, scale: ${scaleFactor.toStringAsFixed(2)})';
  }
}
