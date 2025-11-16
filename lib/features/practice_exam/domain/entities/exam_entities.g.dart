// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_entities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LeaderboardEntry _$LeaderboardEntryFromJson(Map<String, dynamic> json) =>
    _LeaderboardEntry(
      userId: json['userId'] as String,
      displayName: json['displayName'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      overallScore: (json['overallScore'] as num).toDouble(),
      subjectScores: (json['subjectScores'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      totalExamsCompleted: (json['totalExamsCompleted'] as num).toInt(),
      totalQuestionsAnswered: (json['totalQuestionsAnswered'] as num).toInt(),
      totalCorrectAnswers: (json['totalCorrectAnswers'] as num).toInt(),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      streak: (json['streak'] as num?)?.toInt() ?? 0,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$LeaderboardEntryToJson(_LeaderboardEntry instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'overallScore': instance.overallScore,
      'subjectScores': instance.subjectScores,
      'totalExamsCompleted': instance.totalExamsCompleted,
      'totalQuestionsAnswered': instance.totalQuestionsAnswered,
      'totalCorrectAnswers': instance.totalCorrectAnswers,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
      'streak': instance.streak,
      'metadata': instance.metadata,
    };

_LeaderboardRank _$LeaderboardRankFromJson(Map<String, dynamic> json) =>
    _LeaderboardRank(
      rank: (json['rank'] as num).toInt(),
      totalUsers: (json['totalUsers'] as num).toInt(),
      percentile: (json['percentile'] as num).toDouble(),
    );

Map<String, dynamic> _$LeaderboardRankToJson(_LeaderboardRank instance) =>
    <String, dynamic>{
      'rank': instance.rank,
      'totalUsers': instance.totalUsers,
      'percentile': instance.percentile,
    };

_UserExamStatistics _$UserExamStatisticsFromJson(Map<String, dynamic> json) =>
    _UserExamStatistics(
      userId: json['userId'] as String,
      totalSessions: (json['totalSessions'] as num).toInt(),
      completedSessions: (json['completedSessions'] as num).toInt(),
      averageScore: (json['averageScore'] as num).toDouble(),
      totalTimeSpentMinutes: (json['totalTimeSpentMinutes'] as num).toInt(),
      lastActive: json['lastActive'] == null
          ? null
          : DateTime.parse(json['lastActive'] as String),
    );

Map<String, dynamic> _$UserExamStatisticsToJson(_UserExamStatistics instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'totalSessions': instance.totalSessions,
      'completedSessions': instance.completedSessions,
      'averageScore': instance.averageScore,
      'totalTimeSpentMinutes': instance.totalTimeSpentMinutes,
      'lastActive': instance.lastActive?.toIso8601String(),
    };

_OfflineOperation _$OfflineOperationFromJson(Map<String, dynamic> json) =>
    _OfflineOperation(
      id: json['id'] as String,
      type: $enumDecode(_$OperationTypeEnumMap, json['type']),
      userId: json['userId'] as String,
      data: json['data'] as Map<String, dynamic>,
      createdAt: DateTime.parse(json['createdAt'] as String),
      retryCount: (json['retryCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$OfflineOperationToJson(_OfflineOperation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$OperationTypeEnumMap[instance.type]!,
      'userId': instance.userId,
      'data': instance.data,
      'createdAt': instance.createdAt.toIso8601String(),
      'retryCount': instance.retryCount,
    };

const _$OperationTypeEnumMap = {
  OperationType.saveSession: 'saveSession',
  OperationType.deleteSession: 'deleteSession',
  OperationType.updateLeaderboard: 'updateLeaderboard',
};

_SyncResult _$SyncResultFromJson(Map<String, dynamic> json) => _SyncResult(
      success: json['success'] as bool,
      sessionsSynced: (json['sessionsSynced'] as num).toInt(),
      sessionsSkipped: (json['sessionsSkipped'] as num).toInt(),
      syncTime: DateTime.parse(json['syncTime'] as String),
      error: json['error'] as String?,
      failedSessionIds: (json['failedSessionIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$SyncResultToJson(_SyncResult instance) =>
    <String, dynamic>{
      'success': instance.success,
      'sessionsSynced': instance.sessionsSynced,
      'sessionsSkipped': instance.sessionsSkipped,
      'syncTime': instance.syncTime.toIso8601String(),
      'error': instance.error,
      'failedSessionIds': instance.failedSessionIds,
    };

_SyncStatus _$SyncStatusFromJson(Map<String, dynamic> json) => _SyncStatus(
      isSyncing: json['isSyncing'] as bool,
      hasUnsyncedChanges: json['hasUnsyncedChanges'] as bool,
      lastSyncTime: json['lastSyncTime'] == null
          ? null
          : DateTime.parse(json['lastSyncTime'] as String),
      unsyncedCount: (json['unsyncedCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SyncStatusToJson(_SyncStatus instance) =>
    <String, dynamic>{
      'isSyncing': instance.isSyncing,
      'hasUnsyncedChanges': instance.hasUnsyncedChanges,
      'lastSyncTime': instance.lastSyncTime?.toIso8601String(),
      'unsyncedCount': instance.unsyncedCount,
    };

_BatchOperationResult _$BatchOperationResultFromJson(
        Map<String, dynamic> json) =>
    _BatchOperationResult(
      total: (json['total'] as num).toInt(),
      successful: (json['successful'] as num).toInt(),
      failed: (json['failed'] as num).toInt(),
      failedIds: (json['failedIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      errorMessages: (json['errorMessages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$BatchOperationResultToJson(
        _BatchOperationResult instance) =>
    <String, dynamic>{
      'total': instance.total,
      'successful': instance.successful,
      'failed': instance.failed,
      'failedIds': instance.failedIds,
      'errorMessages': instance.errorMessages,
    };

_ExamSessionFilter _$ExamSessionFilterFromJson(Map<String, dynamic> json) =>
    _ExamSessionFilter(
      status: $enumDecodeNullable(_$ExamSessionStatusEnumMap, json['status']),
      subjectId: json['subjectId'] as String?,
      examBody: $enumDecodeNullable(_$ExamBodyEnumMap, json['examBody']),
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      minScore: (json['minScore'] as num?)?.toInt(),
      maxScore: (json['maxScore'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
      offset: (json['offset'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ExamSessionFilterToJson(_ExamSessionFilter instance) =>
    <String, dynamic>{
      'status': _$ExamSessionStatusEnumMap[instance.status],
      'subjectId': instance.subjectId,
      'examBody': _$ExamBodyEnumMap[instance.examBody],
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'minScore': instance.minScore,
      'maxScore': instance.maxScore,
      'limit': instance.limit,
      'offset': instance.offset,
    };

const _$ExamSessionStatusEnumMap = {
  ExamSessionStatus.inProgress: 'inProgress',
  ExamSessionStatus.paused: 'paused',
  ExamSessionStatus.completed: 'completed',
  ExamSessionStatus.abandoned: 'abandoned',
};

const _$ExamBodyEnumMap = {
  ExamBody.waec: 'waec',
  ExamBody.neco: 'neco',
  ExamBody.jamb: 'jamb',
};

_QuerySort _$QuerySortFromJson(Map<String, dynamic> json) => _QuerySort(
      field: $enumDecode(_$SortFieldEnumMap, json['field']),
      order: $enumDecodeNullable(_$SortOrderEnumMap, json['order']) ??
          SortOrder.descending,
    );

Map<String, dynamic> _$QuerySortToJson(_QuerySort instance) =>
    <String, dynamic>{
      'field': _$SortFieldEnumMap[instance.field]!,
      'order': _$SortOrderEnumMap[instance.order]!,
    };

const _$SortFieldEnumMap = {
  SortField.startedAt: 'startedAt',
  SortField.completedAt: 'completedAt',
  SortField.score: 'score',
  SortField.timeSpent: 'timeSpent',
};

const _$SortOrderEnumMap = {
  SortOrder.ascending: 'ascending',
  SortOrder.descending: 'descending',
};

_PerformanceAnalytics _$PerformanceAnalyticsFromJson(
        Map<String, dynamic> json) =>
    _PerformanceAnalytics(
      userId: json['userId'] as String,
      averageScore: (json['averageScore'] as num).toDouble(),
      scoreImprovement: (json['scoreImprovement'] as num).toDouble(),
      subjectPerformance:
          (json['subjectPerformance'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      topicWeaknesses: Map<String, int>.from(json['topicWeaknesses'] as Map),
      strongSubjects: (json['strongSubjects'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      weakSubjects: (json['weakSubjects'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      currentStreak: (json['currentStreak'] as num).toInt(),
      longestStreak: (json['longestStreak'] as num).toInt(),
      lastStudyDate: json['lastStudyDate'] == null
          ? null
          : DateTime.parse(json['lastStudyDate'] as String),
      insights: json['insights'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$PerformanceAnalyticsToJson(
        _PerformanceAnalytics instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'averageScore': instance.averageScore,
      'scoreImprovement': instance.scoreImprovement,
      'subjectPerformance': instance.subjectPerformance,
      'topicWeaknesses': instance.topicWeaknesses,
      'strongSubjects': instance.strongSubjects,
      'weakSubjects': instance.weakSubjects,
      'currentStreak': instance.currentStreak,
      'longestStreak': instance.longestStreak,
      'lastStudyDate': instance.lastStudyDate?.toIso8601String(),
      'insights': instance.insights,
    };

_TimeStatistics _$TimeStatisticsFromJson(Map<String, dynamic> json) =>
    _TimeStatistics(
      totalMinutes: (json['totalMinutes'] as num).toInt(),
      averageMinutesPerSession:
          (json['averageMinutesPerSession'] as num).toDouble(),
      subjectTimeDistribution:
          Map<String, int>.from(json['subjectTimeDistribution'] as Map),
      dailyStudyTime: (json['dailyStudyTime'] as List<dynamic>)
          .map((e) => StudyTimeEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      mostProductiveHour: json['mostProductiveHour'] as String?,
    );

Map<String, dynamic> _$TimeStatisticsToJson(_TimeStatistics instance) =>
    <String, dynamic>{
      'totalMinutes': instance.totalMinutes,
      'averageMinutesPerSession': instance.averageMinutesPerSession,
      'subjectTimeDistribution': instance.subjectTimeDistribution,
      'dailyStudyTime': instance.dailyStudyTime,
      'mostProductiveHour': instance.mostProductiveHour,
    };

_StudyTimeEntry _$StudyTimeEntryFromJson(Map<String, dynamic> json) =>
    _StudyTimeEntry(
      date: DateTime.parse(json['date'] as String),
      minutes: (json['minutes'] as num).toInt(),
      sessionsCount: (json['sessionsCount'] as num).toInt(),
    );

Map<String, dynamic> _$StudyTimeEntryToJson(_StudyTimeEntry instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'minutes': instance.minutes,
      'sessionsCount': instance.sessionsCount,
    };

_ExamNotification _$ExamNotificationFromJson(Map<String, dynamic> json) =>
    _ExamNotification(
      id: json['id'] as String,
      userId: json['userId'] as String,
      type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
      title: json['title'] as String,
      body: json['body'] as String,
      data: json['data'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isRead: json['isRead'] as bool? ?? false,
      scheduledFor: json['scheduledFor'] == null
          ? null
          : DateTime.parse(json['scheduledFor'] as String),
      priority: $enumDecodeNullable(
              _$NotificationPriorityEnumMap, json['priority']) ??
          NotificationPriority.normal,
    );

Map<String, dynamic> _$ExamNotificationToJson(_ExamNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': _$NotificationTypeEnumMap[instance.type]!,
      'title': instance.title,
      'body': instance.body,
      'data': instance.data,
      'createdAt': instance.createdAt.toIso8601String(),
      'isRead': instance.isRead,
      'scheduledFor': instance.scheduledFor?.toIso8601String(),
      'priority': _$NotificationPriorityEnumMap[instance.priority]!,
    };

const _$NotificationTypeEnumMap = {
  NotificationType.sessionReminder: 'sessionReminder',
  NotificationType.sessionExpiring: 'sessionExpiring',
  NotificationType.achievementUnlocked: 'achievementUnlocked',
  NotificationType.leaderboardUpdate: 'leaderboardUpdate',
  NotificationType.streakReminder: 'streakReminder',
  NotificationType.dailyGoal: 'dailyGoal',
  NotificationType.weeklyReport: 'weeklyReport',
  NotificationType.examTip: 'examTip',
  NotificationType.aiInsight: 'aiInsight',
  NotificationType.appUpdate: 'appUpdate',
  NotificationType.settingsChange: 'settingsChange',
  NotificationType.featureAnnouncement: 'featureAnnouncement',
  NotificationType.motivational: 'motivational',
  NotificationType.studyTip: 'studyTip',
  NotificationType.communityUpdate: 'communityUpdate',
  NotificationType.emergencyAlert: 'emergencyAlert',
};

const _$NotificationPriorityEnumMap = {
  NotificationPriority.low: 'low',
  NotificationPriority.normal: 'normal',
  NotificationPriority.high: 'high',
  NotificationPriority.urgent: 'urgent',
};

_NotificationPreferences _$NotificationPreferencesFromJson(
        Map<String, dynamic> json) =>
    _NotificationPreferences(
      sessionReminders: json['sessionReminders'] as bool? ?? true,
      achievementNotifications:
          json['achievementNotifications'] as bool? ?? true,
      leaderboardUpdates: json['leaderboardUpdates'] as bool? ?? true,
      streakReminders: json['streakReminders'] as bool? ?? true,
      dailyGoals: json['dailyGoals'] as bool? ?? false,
      weeklyReports: json['weeklyReports'] as bool? ?? true,
      examTips: json['examTips'] as bool? ?? true,
      aiInsights: json['aiInsights'] as bool? ?? true,
      appUpdates: json['appUpdates'] as bool? ?? true,
      settingsNotifications: json['settingsNotifications'] as bool? ?? true,
      featureAnnouncements: json['featureAnnouncements'] as bool? ?? true,
      motivationalMessages: json['motivationalMessages'] as bool? ?? false,
      studyTips: json['studyTips'] as bool? ?? true,
      communityUpdates: json['communityUpdates'] as bool? ?? true,
      frequency: $enumDecodeNullable(
              _$NotificationFrequencyEnumMap, json['frequency']) ??
          NotificationFrequency.normal,
      quietHours: (json['quietHours'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
    );

Map<String, dynamic> _$NotificationPreferencesToJson(
        _NotificationPreferences instance) =>
    <String, dynamic>{
      'sessionReminders': instance.sessionReminders,
      'achievementNotifications': instance.achievementNotifications,
      'leaderboardUpdates': instance.leaderboardUpdates,
      'streakReminders': instance.streakReminders,
      'dailyGoals': instance.dailyGoals,
      'weeklyReports': instance.weeklyReports,
      'examTips': instance.examTips,
      'aiInsights': instance.aiInsights,
      'appUpdates': instance.appUpdates,
      'settingsNotifications': instance.settingsNotifications,
      'featureAnnouncements': instance.featureAnnouncements,
      'motivationalMessages': instance.motivationalMessages,
      'studyTips': instance.studyTips,
      'communityUpdates': instance.communityUpdates,
      'frequency': _$NotificationFrequencyEnumMap[instance.frequency]!,
      'quietHours': instance.quietHours,
    };

const _$NotificationFrequencyEnumMap = {
  NotificationFrequency.minimal: 'minimal',
  NotificationFrequency.normal: 'normal',
  NotificationFrequency.frequent: 'frequent',
};

_Achievement _$AchievementFromJson(Map<String, dynamic> json) => _Achievement(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: $enumDecode(_$AchievementCategoryEnumMap, json['category']),
      points: (json['points'] as num).toInt(),
      iconUrl: json['iconUrl'] as String?,
      unlockedAt: DateTime.parse(json['unlockedAt'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$AchievementToJson(_Achievement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'category': _$AchievementCategoryEnumMap[instance.category]!,
      'points': instance.points,
      'iconUrl': instance.iconUrl,
      'unlockedAt': instance.unlockedAt.toIso8601String(),
      'metadata': instance.metadata,
    };

const _$AchievementCategoryEnumMap = {
  AchievementCategory.completion: 'completion',
  AchievementCategory.accuracy: 'accuracy',
  AchievementCategory.streak: 'streak',
  AchievementCategory.speed: 'speed',
  AchievementCategory.improvement: 'improvement',
  AchievementCategory.mastery: 'mastery',
  AchievementCategory.consistency: 'consistency',
};

_AchievementProgress _$AchievementProgressFromJson(Map<String, dynamic> json) =>
    _AchievementProgress(
      achievementId: json['achievementId'] as String,
      current: (json['current'] as num).toInt(),
      target: (json['target'] as num).toInt(),
      isUnlocked: json['isUnlocked'] as bool? ?? false,
    );

Map<String, dynamic> _$AchievementProgressToJson(
        _AchievementProgress instance) =>
    <String, dynamic>{
      'achievementId': instance.achievementId,
      'current': instance.current,
      'target': instance.target,
      'isUnlocked': instance.isUnlocked,
    };
