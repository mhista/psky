import 'package:intl/intl.dart';

/// Extension on DateTime to provide various formatting options
extension DateTimeFormatting on DateTime {
  // ============================================================================
  // COMMON FORMATS
  // ============================================================================

  /// Format: 25/09/2025
  String get toDDMMYYYY => DateFormat('dd/MM/yyyy').format(this);

  /// Format: 09/25/2025
  String get toMMDDYYYY => DateFormat('MM/dd/yyyy').format(this);

  /// Format: 2025/09/25
  String get toYYYYMMDD => DateFormat('yyyy/MM/dd').format(this);

  /// Format: 25-09-2025
  String get toDDMMYYYYDash => DateFormat('dd-MM-yyyy').format(this);

  /// Format: 09-25-2025
  String get toMMDDYYYYDash => DateFormat('MM-dd-yyyy').format(this);

  /// Format: 2025-09-25
  String get toYYYYMMDDDash => DateFormat('yyyy-MM-dd').format(this);

  // ============================================================================
  // READABLE FORMATS
  // ============================================================================

  /// Format: 25 September 2025
  String get toReadable => DateFormat('dd MMMM yyyy').format(this);

  /// Format: 25 Sep 2025
  String get toReadableShort => DateFormat('dd MMM yyyy').format(this);

  /// Format: September 25, 2025
  String get toReadableUS => DateFormat('MMMM dd, yyyy').format(this);

  /// Format: Sep 25, 2025
  String get toReadableUSShort => DateFormat('MMM dd, yyyy').format(this);

  /// Format: Thursday, 25 September 2025
  String get toFullReadable => DateFormat('EEEE, dd MMMM yyyy').format(this);

  /// Format: Thu, 25 Sep 2025
  String get toFullReadableShort => DateFormat('EEE, dd MMM yyyy').format(this);

  // ============================================================================
  // TIME FORMATS
  // ============================================================================

  /// Format: 14:30
  String get toTime24 => DateFormat('HH:mm').format(this);

  /// Format: 14:30:45
  String get toTime24WithSeconds => DateFormat('HH:mm:ss').format(this);

  /// Format: 2:30 PM
  String get toTime12 => DateFormat('h:mm a').format(this);

  /// Format: 2:30:45 PM
  String get toTime12WithSeconds => DateFormat('h:mm:ss a').format(this);

  // ============================================================================
  // DATE + TIME FORMATS
  // ============================================================================

  /// Format: 25/09/2025 14:30
  String get toDateTimeShort => DateFormat('dd/MM/yyyy HH:mm').format(this);

  /// Format: 25/09/2025 2:30 PM
  String get toDateTimeShort12 => DateFormat('dd/MM/yyyy h:mm a').format(this);

  /// Format: 25 Sep 2025, 14:30
  String get toDateTimeReadable => DateFormat('dd MMM yyyy, HH:mm').format(this);

  /// Format: 25 Sep 2025, 2:30 PM
  String get toDateTimeReadable12 => DateFormat('dd MMM yyyy, h:mm a').format(this);

  /// Format: Thu, 25 Sep 2025 at 2:30 PM
  String get toFullDateTime => DateFormat('EEE, dd MMM yyyy \'at\' h:mm a').format(this);

  /// Format: 2025-09-25T14:30:00 (ISO 8601)
  String get toISO8601 => toIso8601String();

  // ============================================================================
  // RELATIVE FORMATS (Today, Yesterday, etc.)
  // ============================================================================

  /// Returns relative time string (Today, Yesterday, Tomorrow, or date)
  String get toRelative {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final tomorrow = today.add(const Duration(days: 1));
    final thisDate = DateTime(year, month, day);

    if (thisDate == today) {
      return 'Today';
    } else if (thisDate == yesterday) {
      return 'Yesterday';
    } else if (thisDate == tomorrow) {
      return 'Tomorrow';
    } else if (year == now.year) {
      // Same year, show date without year
      return DateFormat('dd MMM').format(this);
    } else {
      // Different year, show full date
      return DateFormat('dd MMM yyyy').format(this);
    }
  }

  /// Returns relative time with time (e.g., "Today at 2:30 PM")
  String get toRelativeWithTime {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final tomorrow = today.add(const Duration(days: 1));
    final thisDate = DateTime(year, month, day);

    final time = DateFormat('h:mm a').format(this);

    if (thisDate == today) {
      return 'Today at $time';
    } else if (thisDate == yesterday) {
      return 'Yesterday at $time';
    } else if (thisDate == tomorrow) {
      return 'Tomorrow at $time';
    } else {
      return '${DateFormat('dd MMM yyyy').format(this)} at $time';
    }
  }

  /// Returns time ago (e.g., "2 hours ago", "5 minutes ago")
  String get toTimeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return '$minutes ${minutes == 1 ? 'minute' : 'minutes'} ago';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours ${hours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return '$days ${days == 1 ? 'day' : 'days'} ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    }
  }

  // ============================================================================
  // MONTH & YEAR FORMATS
  // ============================================================================

  /// Format: September 2025
  String get toMonthYear => DateFormat('MMMM yyyy').format(this);

  /// Format: Sep 2025
  String get toMonthYearShort => DateFormat('MMM yyyy').format(this);

  /// Format: Sep '25
  String get toMonthYearAbbrev => DateFormat('MMM \'yy').format(this);

  // ============================================================================
  // DAY FORMATS
  // ============================================================================

  /// Format: Thursday
  String get toDayName => DateFormat('EEEE').format(this);

  /// Format: Thu
  String get toDayNameShort => DateFormat('EEE').format(this);

  /// Format: 25
  String get toDayNumber => DateFormat('dd').format(this);

  // ============================================================================
  // CUSTOM FORMAT METHOD
  // ============================================================================

  /// Custom format using pattern
  /// Example: formatCustom('dd/MM/yyyy HH:mm:ss')
  String formatCustom(String pattern) => DateFormat(pattern).format(this);

  // ============================================================================
  // UTILITY METHODS
  // ============================================================================

  /// Check if date is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Check if date is yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year && 
           month == yesterday.month && 
           day == yesterday.day;
  }

  /// Check if date is tomorrow
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year && 
           month == tomorrow.month && 
           day == tomorrow.day;
  }

  /// Check if date is in the past
  bool get isPast => isBefore(DateTime.now());

  /// Check if date is in the future
  bool get isFuture => isAfter(DateTime.now());

  /// Check if date is in current week
  bool get isThisWeek {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    
    return isAfter(startOfWeek.subtract(const Duration(days: 1))) && 
           isBefore(endOfWeek.add(const Duration(days: 1)));
  }

  /// Check if date is in current month
  bool get isThisMonth {
    final now = DateTime.now();
    return year == now.year && month == now.month;
  }

  /// Check if date is in current year
  bool get isThisYear {
    final now = DateTime.now();
    return year == now.year;
  }

  /// Get start of day (00:00:00)
  DateTime get startOfDay => DateTime(year, month, day);

  /// Get end of day (23:59:59)
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);

  /// Get start of week (Monday)
  DateTime get startOfWeek => subtract(Duration(days: weekday - 1));

  /// Get end of week (Sunday)
  DateTime get endOfWeek => add(Duration(days: 7 - weekday));

  /// Get start of month
  DateTime get startOfMonth => DateTime(year, month, 1);

  /// Get end of month
  DateTime get endOfMonth => DateTime(year, month + 1, 0, 23, 59, 59, 999);

  /// Get start of year
  DateTime get startOfYear => DateTime(year, 1, 1);

  /// Get end of year
  DateTime get endOfYear => DateTime(year, 12, 31, 23, 59, 59, 999);
}