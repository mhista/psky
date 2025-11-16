// ============================================================================
// STREAK TRACKING SERVICE
// ============================================================================

import 'dart:convert';

import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_models/esam_session.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class StreakService {
  final FirebaseFirestore _firestore;
  final SharedPreferences _prefs;

  static const String _streakKey = 'user_streak_data';
  static const String _streakCollection = 'user_streaks';

  StreakService(this._firestore, this._prefs);

  // ============================================================================
  // CALCULATE STREAKS FROM SESSIONS
  // ============================================================================

  /// Calculate all streak data from exam sessions
  Future<StreakData> calculateStreakData({
    required String userId,
    required List<ExamSession> sessions,
  }) async {
    final now = DateTime.now();
    final completedSessions = sessions
        .where((s) => s.status == ExamSessionStatus.completed)
        .toList();

    if (completedSessions.isEmpty) {
      return StreakData.empty();
    }

    // Sort by completion date
    completedSessions.sort((a, b) => 
        a.completedAt!.compareTo(b.completedAt!)
    );

    // Calculate daily streak (consecutive days)
    final dailyStreak = _calculateDailyStreak(completedSessions, now);

    // Calculate monthly activity (30-day grid)
    final monthlyActivity = _calculateMonthlyActivity(
      completedSessions,
      now,
    );

    // Calculate statistics
    final stats = _calculateStreakStats(
      completedSessions,
      monthlyActivity,
      now,
    );

    final streakData = StreakData(
      userId: userId,
      currentStreak: dailyStreak.current,
      longestStreak: dailyStreak.longest,
      totalActiveDays: _getTotalActiveDays(completedSessions),
      lastActivityDate: completedSessions.last.completedAt,
      monthlyActivity: monthlyActivity,
      stats: stats,
      lastUpdated: DateTime.now(),
    );

    // Save streak data
    await _saveStreakData(streakData);

    return streakData;
  }

  // ============================================================================
  // DAILY STREAK CALCULATION
  // ============================================================================

  /// Calculate current and longest streak (consecutive days)
  DailyStreakInfo _calculateDailyStreak(
    List<ExamSession> sessions,
    DateTime now,
  ) {
    // Get unique activity dates (ignore time)
    final activityDates = sessions
        .map((s) => _normalizeDate(s.completedAt!))
        .toSet()
        .toList()
      ..sort();

    if (activityDates.isEmpty) {
      return DailyStreakInfo(current: 0, longest: 0);
    }

    int currentStreak = 0;
    int longestStreak = 0;
    int tempStreak = 1;

    final today = _normalizeDate(now);
    final yesterday = today.subtract(const Duration(days: 1));

    // Check if streak is still active (today or yesterday)
    final lastActivityDate = activityDates.last;
    final streakActive = lastActivityDate == today || 
                        lastActivityDate == yesterday;

    // Calculate current streak (working backwards from last activity)
    if (streakActive) {
      currentStreak = 1;
      DateTime checkDate = lastActivityDate.subtract(const Duration(days: 1));

      for (int i = activityDates.length - 2; i >= 0; i--) {
        if (activityDates[i] == checkDate) {
          currentStreak++;
          checkDate = checkDate.subtract(const Duration(days: 1));
        } else if (activityDates[i].isBefore(checkDate)) {
          break; // Streak broken
        }
      }
    }

    // Calculate longest streak ever
    for (int i = 1; i < activityDates.length; i++) {
      final daysDiff = activityDates[i]
          .difference(activityDates[i - 1])
          .inDays;

      if (daysDiff == 1) {
        tempStreak++;
      } else {
        longestStreak = tempStreak > longestStreak ? tempStreak : longestStreak;
        tempStreak = 1;
      }
    }
    longestStreak = tempStreak > longestStreak ? tempStreak : longestStreak;

    // Current streak might be the longest
    if (currentStreak > longestStreak) {
      longestStreak = currentStreak;
    }

    return DailyStreakInfo(
      current: currentStreak,
      longest: longestStreak,
      isActive: streakActive,
      lastActivityDate: lastActivityDate,
    );
  }

  // ============================================================================
  // MONTHLY ACTIVITY (30-DAY GRID)
  // ============================================================================

  /// Calculate 30-day activity grid (like GitHub contributions)
  List<DayActivity> _calculateMonthlyActivity(
    List<ExamSession> sessions,
    DateTime now,
  ) {
    final activities = <DayActivity>[];
    final startDate = now.subtract(const Duration(days: 29)); // Last 30 days

    // Group sessions by date
    final sessionsByDate = <DateTime, List<ExamSession>>{};
    for (final session in sessions) {
      final date = _normalizeDate(session.completedAt!);
      if (date.isAfter(startDate.subtract(const Duration(days: 1)))) {
        sessionsByDate.putIfAbsent(date, () => []).add(session);
      }
    }

    // Generate 30-day grid
    for (int i = 29; i >= 0; i--) {
      final date = _normalizeDate(now.subtract(Duration(days: i)));
      final daySessions = sessionsByDate[date] ?? [];

      activities.add(DayActivity(
        date: date,
        sessionCount: daySessions.length,
        questionsAnswered: _countQuestionsAnswered(daySessions),
        totalTimeMinutes: _calculateTotalTime(daySessions),
        averageScore: _calculateAverageScore(daySessions),
        intensity: _calculateIntensity(daySessions),
      ));
    }

    return activities;
  }

  // ============================================================================
  // STATISTICS CALCULATION
  // ============================================================================

  /// Calculate streak statistics
  StreakStats _calculateStreakStats(
    List<ExamSession> sessions,
    List<DayActivity> monthlyActivity,
    DateTime now,
  ) {
    // Activity days in last 30 days
    final activeDaysThisMonth = monthlyActivity
        .where((day) => day.sessionCount > 0)
        .length;

    // Most productive day
    final sortedByActivity = List<DayActivity>.from(monthlyActivity)
      ..sort((a, b) => b.sessionCount.compareTo(a.sessionCount));
    final mostProductiveDay = sortedByActivity.first.sessionCount > 0
        ? sortedByActivity.first
        : null;

    // Least active day of week
    final dayOfWeekCounts = <int, int>{};
    for (final activity in monthlyActivity) {
      if (activity.sessionCount > 0) {
        final dayOfWeek = activity.date.weekday;
        dayOfWeekCounts[dayOfWeek] = 
            (dayOfWeekCounts[dayOfWeek] ?? 0) + activity.sessionCount;
      }
    }

    int? leastActiveDayOfWeek;
    if (dayOfWeekCounts.isNotEmpty) {
      leastActiveDayOfWeek = dayOfWeekCounts.entries
          .reduce((a, b) => a.value < b.value ? a : b)
          .key;
    }

    // Total sessions this month
    final totalSessionsThisMonth = monthlyActivity
        .fold<int>(0, (sum, day) => sum + day.sessionCount);

    // Average sessions per active day
    final avgSessionsPerDay = activeDaysThisMonth > 0
        ? totalSessionsThisMonth / activeDaysThisMonth
        : 0.0;

    // Consistency score (0-100)
    final consistencyScore = _calculateConsistencyScore(monthlyActivity);

    // Trend (increasing, decreasing, stable)
    final trend = _calculateTrend(monthlyActivity);

    return StreakStats(
      activeDaysThisMonth: activeDaysThisMonth,
      totalSessionsThisMonth: totalSessionsThisMonth,
      avgSessionsPerDay: avgSessionsPerDay,
      mostProductiveDay: mostProductiveDay,
      leastActiveDayOfWeek: leastActiveDayOfWeek,
      consistencyScore: consistencyScore,
      trend: trend,
    );
  }

  // ============================================================================
  // HELPER METHODS
  // ============================================================================

  /// Normalize date to midnight (ignore time)
  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Count total active days (unique dates)
  int _getTotalActiveDays(List<ExamSession> sessions) {
    return sessions
        .map((s) => _normalizeDate(s.completedAt!))
        .toSet()
        .length;
  }

  /// Count questions answered in sessions
  int _countQuestionsAnswered(List<ExamSession> sessions) {
    return sessions.fold<int>(
      0,
      (sum, s) => sum + (s.progress?.answeredCount ?? 0),
    );
  }

  /// Calculate total time spent
  int _calculateTotalTime(List<ExamSession> sessions) {
    return sessions.fold<int>(
      0,
      (sum, s) => sum + (s.progress?.timeElapsedMinutes ?? 0),
    );
  }

  /// Calculate average score
  double _calculateAverageScore(List<ExamSession> sessions) {
    if (sessions.isEmpty) return 0.0;

    final scores = sessions.map((s) {
      final correct = s.questions.where((q) {
        if (q.questionType == QuestionType.objective) {
          return q.selectedAnswer == q.correctAnswer;
        }
        return false;
      }).length;

      return s.questions.isEmpty 
          ? 0.0 
          : (correct / s.questions.length) * 100;
    }).toList();

    return scores.reduce((a, b) => a + b) / scores.length;
  }

  /// Calculate activity intensity (0 = none, 1 = low, 2 = medium, 3 = high, 4 = very high)
  int _calculateIntensity(List<ExamSession> sessions) {
    if (sessions.isEmpty) return 0;
    if (sessions.length == 1) return 1;
    if (sessions.length == 2) return 2;
    if (sessions.length <= 4) return 3;
    return 4; // 5+ sessions = very high
  }

  /// Calculate consistency score (0-100)
  double _calculateConsistencyScore(List<DayActivity> activities) {
    final activeDays = activities.where((a) => a.sessionCount > 0).length;
    
    if (activeDays == 0) return 0.0;

    // Base score from percentage of active days
    final baseScore = (activeDays / 30) * 60; // Max 60 points

    // Bonus for consecutive days
    int longestStreak = 0;
    int currentStreak = 0;

    for (final activity in activities) {
      if (activity.sessionCount > 0) {
        currentStreak++;
        if (currentStreak > longestStreak) {
          longestStreak = currentStreak;
        }
      } else {
        currentStreak = 0;
      }
    }

    final streakBonus = (longestStreak / 30) * 40; // Max 40 points

    return (baseScore + streakBonus).clamp(0, 100);
  }

  /// Calculate activity trend
  ActivityTrend _calculateTrend(List<DayActivity> activities) {
    if (activities.length < 6) return ActivityTrend.stable;

    // Compare first week vs last week
    final firstWeek = activities.take(7).toList();
    final lastWeek = activities.skip(activities.length - 7).toList();

    final firstWeekTotal = firstWeek
        .fold<int>(0, (sum, a) => sum + a.sessionCount);
    final lastWeekTotal = lastWeek
        .fold<int>(0, (sum, a) => sum + a.sessionCount);

    if (lastWeekTotal > firstWeekTotal * 1.2) {
      return ActivityTrend.increasing;
    } else if (lastWeekTotal < firstWeekTotal * 0.8) {
      return ActivityTrend.decreasing;
    } else {
      return ActivityTrend.stable;
    }
  }

  // ============================================================================
  // STORAGE OPERATIONS
  // ============================================================================

  /// Save streak data to Firestore and local cache
  Future<void> _saveStreakData(StreakData data) async {
    try {
      // Save to Firestore
      await _firestore
          .collection(_streakCollection)
          .doc(data.userId)
          .set(data.toJson());

      // Save to local cache
      await _prefs.setString(_streakKey, jsonEncode(data.toJson()));
    } catch (e) {
      print('Error saving streak data: $e');
    }
  }

  /// Load streak data from Firestore
  Future<StreakData?> loadStreakData(String userId) async {
    try {
      final doc = await _firestore
          .collection(_streakCollection)
          .doc(userId)
          .get();

      if (doc.exists) {
        return StreakData.fromJson(doc.data()!);
      }

      // Try local cache
      final cached = _prefs.getString(_streakKey);
      if (cached != null) {
        return StreakData.fromJson(jsonDecode(cached));
      }

      return null;
    } catch (e) {
      print('Error loading streak data: $e');
      return null;
    }
  }

  /// Update streak when new session completes
  Future<void> updateStreakOnSessionComplete({
    required String userId,
    required ExamSession session,
    required List<ExamSession> allSessions,
  }) async {
    await calculateStreakData(
      userId: userId,
      sessions: allSessions,
    );
  }

  // ============================================================================
  // STREAK NOTIFICATIONS
  // ============================================================================

  /// Check if user should get streak reminder
  bool shouldSendStreakReminder(StreakData streakData) {
    if (streakData.currentStreak == 0) return false;
    
    final lastActivity = streakData.lastActivityDate;
    if (lastActivity == null) return false;

    final now = DateTime.now();
    final today = _normalizeDate(now);
    final lastActivityDate = _normalizeDate(lastActivity);

    // If last activity was yesterday and it's past noon, remind
    final yesterday = today.subtract(const Duration(days: 1));
    if (lastActivityDate == yesterday && now.hour >= 12) {
      return true;
    }

    return false;
  }

  /// Get milestone info if user reached one
  StreakMilestone? checkMilestone(int currentStreak) {
    const milestones = [3, 7, 14, 30, 50, 100, 365];
    
    if (milestones.contains(currentStreak)) {
      return StreakMilestone(
        days: currentStreak,
        title: _getMilestoneTitle(currentStreak),
        message: _getMilestoneMessage(currentStreak),
        reward: _getMilestoneReward(currentStreak),
      );
    }

    return null;
  }

  String _getMilestoneTitle(int days) {
    if (days == 3) return '3-Day Streak! 🔥';
    if (days == 7) return 'Week Warrior! 🎯';
    if (days == 14) return 'Two-Week Champion! 🏆';
    if (days == 30) return 'Month Master! 👑';
    if (days == 50) return '50-Day Legend! ⭐';
    if (days == 100) return '100-Day Hero! 💎';
    if (days == 365) return 'Year-Long Dedication! 🌟';
    return '$days-Day Streak!';
  }

  String _getMilestoneMessage(int days) {
    if (days == 3) return 'You\'re on fire! Keep it going!';
    if (days == 7) return 'A full week of dedication!';
    if (days == 14) return 'Two weeks of consistent learning!';
    if (days == 30) return 'A whole month of hard work!';
    if (days == 50) return 'Incredible consistency!';
    if (days == 100) return 'You\'re unstoppable!';
    if (days == 365) return 'A full year of learning! Amazing!';
    return 'Keep up the great work!';
  }

  int _getMilestoneReward(int days) {
    if (days == 3) return 10;
    if (days == 7) return 25;
    if (days == 14) return 50;
    if (days == 30) return 100;
    if (days == 50) return 200;
    if (days == 100) return 500;
    if (days == 365) return 1000;
    return days;
  }
}

// ============================================================================
// DATA MODELS
// ============================================================================

class StreakData {
  final String userId;
  final int currentStreak;
  final int longestStreak;
  final int totalActiveDays;
  final DateTime? lastActivityDate;
  final List<DayActivity> monthlyActivity;
  final StreakStats stats;
  final DateTime lastUpdated;

  StreakData({
    required this.userId,
    required this.currentStreak,
    required this.longestStreak,
    required this.totalActiveDays,
    this.lastActivityDate,
    required this.monthlyActivity,
    required this.stats,
    required this.lastUpdated,
  });

  factory StreakData.empty() {
    return StreakData(
      userId: '',
      currentStreak: 0,
      longestStreak: 0,
      totalActiveDays: 0,
      monthlyActivity: [],
      stats: StreakStats.empty(),
      lastUpdated: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'currentStreak': currentStreak,
        'longestStreak': longestStreak,
        'totalActiveDays': totalActiveDays,
        'lastActivityDate': lastActivityDate?.toIso8601String(),
        'monthlyActivity': monthlyActivity.map((a) => a.toJson()).toList(),
        'stats': stats.toJson(),
        'lastUpdated': lastUpdated.toIso8601String(),
      };

  factory StreakData.fromJson(Map<String, dynamic> json) => StreakData(
        userId: json['userId'],
        currentStreak: json['currentStreak'],
        longestStreak: json['longestStreak'],
        totalActiveDays: json['totalActiveDays'],
        lastActivityDate: json['lastActivityDate'] != null
            ? DateTime.parse(json['lastActivityDate'])
            : null,
        monthlyActivity: (json['monthlyActivity'] as List)
            .map((a) => DayActivity.fromJson(a))
            .toList(),
        stats: StreakStats.fromJson(json['stats']),
        lastUpdated: DateTime.parse(json['lastUpdated']),
      );
}

class DayActivity {
  final DateTime date;
  final int sessionCount;
  final int questionsAnswered;
  final int totalTimeMinutes;
  final double averageScore;
  final int intensity; // 0-4

  DayActivity({
    required this.date,
    required this.sessionCount,
    required this.questionsAnswered,
    required this.totalTimeMinutes,
    required this.averageScore,
    required this.intensity,
  });

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'sessionCount': sessionCount,
        'questionsAnswered': questionsAnswered,
        'totalTimeMinutes': totalTimeMinutes,
        'averageScore': averageScore,
        'intensity': intensity,
      };

  factory DayActivity.fromJson(Map<String, dynamic> json) => DayActivity(
        date: DateTime.parse(json['date']),
        sessionCount: json['sessionCount'],
        questionsAnswered: json['questionsAnswered'],
        totalTimeMinutes: json['totalTimeMinutes'],
        averageScore: json['averageScore'],
        intensity: json['intensity'],
      );
}

class DailyStreakInfo {
  final int current;
  final int longest;
  final bool isActive;
  final DateTime? lastActivityDate;

  DailyStreakInfo({
    required this.current,
    required this.longest,
    this.isActive = false,
    this.lastActivityDate,
  });
}

class StreakStats {
  final int activeDaysThisMonth;
  final int totalSessionsThisMonth;
  final double avgSessionsPerDay;
  final DayActivity? mostProductiveDay;
  final int? leastActiveDayOfWeek; // 1=Monday, 7=Sunday
  final double consistencyScore; // 0-100
  final ActivityTrend trend;

  StreakStats({
    required this.activeDaysThisMonth,
    required this.totalSessionsThisMonth,
    required this.avgSessionsPerDay,
    this.mostProductiveDay,
    this.leastActiveDayOfWeek,
    required this.consistencyScore,
    required this.trend,
  });

  factory StreakStats.empty() => StreakStats(
        activeDaysThisMonth: 0,
        totalSessionsThisMonth: 0,
        avgSessionsPerDay: 0,
        consistencyScore: 0,
        trend: ActivityTrend.stable,
      );

  Map<String, dynamic> toJson() => {
        'activeDaysThisMonth': activeDaysThisMonth,
        'totalSessionsThisMonth': totalSessionsThisMonth,
        'avgSessionsPerDay': avgSessionsPerDay,
        'mostProductiveDay': mostProductiveDay?.toJson(),
        'leastActiveDayOfWeek': leastActiveDayOfWeek,
        'consistencyScore': consistencyScore,
        'trend': trend.name,
      };

  factory StreakStats.fromJson(Map<String, dynamic> json) => StreakStats(
        activeDaysThisMonth: json['activeDaysThisMonth'],
        totalSessionsThisMonth: json['totalSessionsThisMonth'],
        avgSessionsPerDay: json['avgSessionsPerDay'],
        mostProductiveDay: json['mostProductiveDay'] != null
            ? DayActivity.fromJson(json['mostProductiveDay'])
            : null,
        leastActiveDayOfWeek: json['leastActiveDayOfWeek'],
        consistencyScore: json['consistencyScore'],
        trend: ActivityTrend.values.firstWhere(
          (e) => e.name == json['trend'],
          orElse: () => ActivityTrend.stable,
        ),
      );
}

enum ActivityTrend {
  increasing,
  stable,
  decreasing,
}

class StreakMilestone {
  final int days;
  final String title;
  final String message;
  final int reward; // Points/XP

  StreakMilestone({
    required this.days,
    required this.title,
    required this.message,
    required this.reward,
  });
}

// Helper extension for day of week names
extension DayOfWeekName on int {
  String get dayName {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[this - 1];
  }
}