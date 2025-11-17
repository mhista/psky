// ============================================================================
// FIREBASE EXAM DATA SOURCE
// ============================================================================

import 'dart:async';
import 'dart:convert';
import 'package:ahiaa_web/core/services/cache_manager.dart';
import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/core/utils/exceptions/exam_data_source_exceptions.dart';
import 'package:ahiaa_web/core/utils/logging/logger.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_models/esam_session.dart';
import 'package:ahiaa_web/features/practice_exam/domain/entities/exam_entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Main data source for Firebase exam operations
@lazySingleton
class FirebaseExamDataSource {
  final FirebaseFirestore _firestore;
  final SharedPreferences _prefs;
  final ExamCacheManager _cacheManager;

  // Collection references
  static const String _usersCollection = 'users';
  static const String _examSessionsCollection = 'exam_sessions';
  static const String _leaderboardCollection = 'leaderboard';
  static const String _lastSyncKey = 'last_firebase_sync';

  FirebaseExamDataSource(
    this._firestore,
    this._prefs,
    this._cacheManager,
  );

  // ============================================================================
  // EXAM SESSION OPERATIONS (FIXED FOR STRING DATES)
  // ============================================================================

  /// Get all exam sessions for a user
  Future<List<ExamSession>> getUserExamSessions({
    required String userId,
    int? limit,
    ExamSessionStatus? status,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      Query query = _firestore
          .collection(_usersCollection)
          .doc(userId)
          .collection(_examSessionsCollection)
          .orderBy('startedAt', descending: true);

      // Apply filters
      if (status != null) {
        query = query.where('status', isEqualTo: status.name);
      }

      if (startDate != null) {
        query = query.where('startedAt', 
            isGreaterThanOrEqualTo: startDate.toIso8601String());
      }

      if (endDate != null) {
        query = query.where('startedAt', 
            isLessThanOrEqualTo: endDate.toIso8601String());
      }

      if (limit != null) {
        query = query.limit(limit);
      }

      final snapshot = await query.get();
      
      if (snapshot.docs.isEmpty) {
        print('No exam sessions found for user: $userId');
        return [];
      }

      print('Found ${snapshot.docs.length} sessions');
      
      final sessions = <ExamSession>[];
      
      for (final doc in snapshot.docs) {
        try {
          final data = doc.data() as Map<String, dynamic>;
          
          // Normalize the data (handle both Timestamp and String dates)
          _normalizeDateFields(data);
          
          // Ensure progress exists with proper structure
          if (data['progress'] == null) {
            data['progress'] = _createDefaultProgress(data['questions']);
          } else {
            // Ensure progress has all required fields
            final progress = data['progress'] as Map<String, dynamic>;
            if (!progress.containsKey('totalQuestions')) {
              progress['totalQuestions'] = (data['questions'] as List?)?.length ?? 0;
            }
            if (!progress.containsKey('answeredQuestions')) {
              progress['answeredQuestions'] = [];
            }
            if (!progress.containsKey('skippedQuestions')) {
              progress['skippedQuestions'] = [];
            }
            if (!progress.containsKey('reviewedQuestions')) {
              progress['reviewedQuestions'] = [];
            }
            if (!progress.containsKey('lastUpdated')) {
              progress['lastUpdated'] = DateTime.now().toIso8601String();
            }
          }
          
          final session = ExamSession.fromJson(data);
          sessions.add(session);
          
          // Update cache
          _cacheManager.cache(session.examSessionId, _generateHash(session));
        } catch (e, stackTrace) {
          print('Error parsing session ${doc.id}: $e');
          print('Stack trace: $stackTrace');
          print('Data: ${doc.data()}');
          // Continue with other sessions
          continue;
        }
      }

      return sessions;
    } catch (e, stackTrace) {
      print('Error in getUserExamSessions: $e');
      print('Stack trace: $stackTrace');
      throw ExamDataSourceException('Failed to get user exam sessions: $e');
    }
  }

  /// Get incomplete sessions (FIXED)
  Future<List<ExamSession>> getIncompleteSessions({
    required String userId,
  }) async {
    try {
      final sessions = <ExamSession>[];
      
      // Query for in-progress sessions
      try {
        final inProgressSnapshot = await _firestore
            .collection(_usersCollection)
            .doc(userId)
            .collection(_examSessionsCollection)
            .where('status', isEqualTo: ExamSessionStatus.inProgress.name)
            .get();

        print('Found ${inProgressSnapshot.docs.length} in-progress sessions');

        for (final doc in inProgressSnapshot.docs) {
          try {
            final data = doc.data();
            _normalizeDateFields(data);
            
            if (data['progress'] == null) {
              data['progress'] = _createDefaultProgress(data['questions']);
            }
            
            sessions.add(ExamSession.fromJson(data));
          } catch (e) {
            print('Error parsing in-progress session ${doc.id}: $e');
          }
        }
      } catch (e) {
        print('Error fetching in-progress sessions: $e');
      }

      // Query for paused sessions
      try {
        final pausedSnapshot = await _firestore
            .collection(_usersCollection)
            .doc(userId)
            .collection(_examSessionsCollection)
            .where('status', isEqualTo: ExamSessionStatus.paused.name)
            .get();

        print('Found ${pausedSnapshot.docs.length} paused sessions');

        for (final doc in pausedSnapshot.docs) {
          try {
            final data = doc.data();
            _normalizeDateFields(data);
            
            if (data['progress'] == null) {
              data['progress'] = _createDefaultProgress(data['questions']);
            }
            
            sessions.add(ExamSession.fromJson(data));
          } catch (e) {
            print('Error parsing paused session ${doc.id}: $e');
          }
        }
      } catch (e) {
        print('Error fetching paused sessions: $e');
      }

      // Sort by startedAt
      if (sessions.isNotEmpty) {
        sessions.sort((a, b) => 
          (b.startedAt ?? DateTime.now()).compareTo(a.startedAt ?? DateTime.now())
        );
      }

      print('Found ${sessions.length} incomplete sessions total');
      return sessions;
    } catch (e, stackTrace) {
      print('Error in getIncompleteSessions: $e');
      print('Stack trace: $stackTrace');
      // Return empty list instead of throwing
      return [];
    }
  }

  /// Save exam session
  Future<void> saveExamSession({
    required String userId,
    required ExamSession session,
    bool merge = true,
  }) async {
    try {
      if (_cacheManager.isCached(session.examSessionId)) {
        final cachedHash = _cacheManager.getHash(session.examSessionId);
        final currentHash = _generateHash(session);
        
        if (cachedHash == currentHash) {
          print('Session ${session.examSessionId} unchanged, skipping write');
          return;
        }
      }

      final data = session.toJson();

      await _firestore
          .collection(_usersCollection)
          .doc(userId)
          .collection(_examSessionsCollection)
          .doc(session.examSessionId)
          .set(data, SetOptions(merge: merge));

      _cacheManager.cache(session.examSessionId, _generateHash(session));
      await _updateLastSyncTime();

      print('Successfully saved session: ${session.examSessionId}');
    } catch (e) {
      print('Error saving session: $e');
      throw ExamDataSourceException('Failed to save exam session: $e');
    }
  }

  /// Batch save
  Future<void> batchSaveExamSessions({
    required String userId,
    required List<ExamSession> sessions,
  }) async {
    try {
      if (sessions.isEmpty) return;

      final batch = _firestore.batch();
      int batchCount = 0;
      const maxBatchSize = 500;

      for (final session in sessions) {
        if (_cacheManager.isCached(session.examSessionId)) {
          final cachedHash = _cacheManager.getHash(session.examSessionId);
          final currentHash = _generateHash(session);
          
          if (cachedHash == currentHash) continue;
        }

        final docRef = _firestore
            .collection(_usersCollection)
            .doc(userId)
            .collection(_examSessionsCollection)
            .doc(session.examSessionId);

        final data = session.toJson();

        batch.set(docRef, data, SetOptions(merge: true));
        batchCount++;

        _cacheManager.cache(session.examSessionId, _generateHash(session));

        if (batchCount >= maxBatchSize) {
          await batch.commit();
          batchCount = 0;
        }
      }

      if (batchCount > 0) {
        await batch.commit();
      }

      await _updateLastSyncTime();
      print('Batch saved ${sessions.length} sessions');
    } catch (e) {
      print('Error in batch save: $e');
      throw ExamDataSourceException('Failed to batch save sessions: $e');
    }
  }

  /// Get a single exam session
  Future<ExamSession?> getExamSession({
    required String userId,
    required String sessionId,
  }) async {
    try {
      final doc = await _firestore
          .collection(_usersCollection)
          .doc(userId)
          .collection(_examSessionsCollection)
          .doc(sessionId)
          .get();

      if (!doc.exists) return null;

      final data = doc.data()!;
      _normalizeDateFields(data);
      
      if (data['progress'] == null) {
        data['progress'] = _createDefaultProgress(data['questions']);
      }

      final session = ExamSession.fromJson(data);
      _cacheManager.cache(session.examSessionId, _generateHash(session));

      return session;
    } catch (e) {
      print('Error getting session: $e');
      throw ExamDataSourceException('Failed to get exam session: $e');
    }
  }

  /// Delete an exam session
  Future<void> deleteExamSession({
    required String userId,
    required String sessionId,
  }) async {
    try {
      await _firestore
          .collection(_usersCollection)
          .doc(userId)
          .collection(_examSessionsCollection)
          .doc(sessionId)
          .delete();

      _cacheManager.remove(sessionId);
      print('Deleted session: $sessionId');
    } catch (e) {
      throw ExamDataSourceException('Failed to delete exam session: $e');
    }
  }

  /// Get sessions by subject
  Future<List<ExamSession>> getSessionsBySubject({
    required String userId,
    required String subjectId,
    int? limit,
  }) async {
    try {
      Query query = _firestore
          .collection(_usersCollection)
          .doc(userId)
          .collection(_examSessionsCollection)
          .where('subjectId', isEqualTo: subjectId)
          .orderBy('startedAt', descending: true);

      if (limit != null) {
        query = query.limit(limit);
      }

      final snapshot = await query.get();
      
      final sessions = <ExamSession>[];
      for (final doc in snapshot.docs) {
        try {
          final data = doc.data() as Map<String, dynamic>;
          _normalizeDateFields(data);
          
          if (data['progress'] == null) {
            data['progress'] = _createDefaultProgress(data['questions']);
          }
          
          sessions.add(ExamSession.fromJson(data));
        } catch (e) {
          print('Error parsing session ${doc.id}: $e');
          continue;
        }
      }
      
      return sessions;
    } catch (e) {
      throw ExamDataSourceException('Failed to get sessions by subject: $e');
    }
  }

  // ============================================================================
  // HELPER METHODS
  // ============================================================================

  /// Normalize date fields (handle both Timestamp and String)
  void _normalizeDateFields(Map<String, dynamic> data) {
    // Handle startedAt
    if (data['startedAt'] != null) {
      if (data['startedAt'] is Timestamp) {
        data['startedAt'] = (data['startedAt'] as Timestamp).toDate().toIso8601String();
      } else if (data['startedAt'] is! String) {
        data['startedAt'] = DateTime.now().toIso8601String();
      }
    }

    // Handle completedAt
    if (data['completedAt'] != null) {
      if (data['completedAt'] is Timestamp) {
        data['completedAt'] = (data['completedAt'] as Timestamp).toDate().toIso8601String();
      } else if (data['completedAt'] is! String) {
        data['completedAt'] = null;
      }
    }

    // Handle progress.lastUpdated
    if (data['progress'] != null && data['progress'] is Map) {
      final progress = data['progress'] as Map<String, dynamic>;
      if (progress['lastUpdated'] != null) {
        if (progress['lastUpdated'] is Timestamp) {
          progress['lastUpdated'] = (progress['lastUpdated'] as Timestamp).toDate().toIso8601String();
        } else if (progress['lastUpdated'] is! String) {
          progress['lastUpdated'] = DateTime.now().toIso8601String();
        }
      }
    }

    // Handle question createdAt fields
    if (data['questions'] != null && data['questions'] is List) {
      for (final question in data['questions']) {
        if (question is Map<String, dynamic> && question['createdAt'] != null) {
          if (question['createdAt'] is Timestamp) {
            question['createdAt'] = (question['createdAt'] as Timestamp).toDate().toIso8601String();
          } else if (question['createdAt'] is! String) {
            question['createdAt'] = DateTime.now().toIso8601String();
          }
        }
      }
    }
  }

  /// Create default progress object
  Map<String, dynamic> _createDefaultProgress(dynamic questions) {
    final questionCount = (questions is List) ? questions.length : 0;
    return {
      'totalQuestions': questionCount,
      'currentQuestionIndex': 0,
      'answeredCount': 0,
      'skippedCount': 0,
      'unansweredCount': questionCount,
      'answeredQuestions': [],
      'skippedQuestions': [],
      'reviewedQuestions': [],
      'timeElapsedMinutes': 0,
      'lastUpdated': DateTime.now().toIso8601String(),
    };
  }
  // ============================================================================
  // LEADERBOARD OPERATIONS
  // ============================================================================

  /// Update user's leaderboard entry
  Future<void> updateLeaderboardEntry({
    required String userId,
    required LeaderboardEntry entry,
  }) async {
    try {
      await _firestore
          .collection(_leaderboardCollection)
          .doc(userId)
          .set(
            entry.toJson(),
            SetOptions(merge: true),
          );

      print('Updated leaderboard for user: $userId');
    } catch (e) {
      throw ExamDataSourceException('Failed to update leaderboard: $e');
    }
  }

  /// Get global leaderboard
  Future<List<LeaderboardEntry>> getGlobalLeaderboard({
    int limit = 100,
    LeaderboardType type = LeaderboardType.overall,
    String? subjectId,
  }) async {
    try {
      Query query = _firestore.collection(_leaderboardCollection);

      // Apply filters based on type
      switch (type) {
        case LeaderboardType.overall:
          query = query.orderBy('overallScore', descending: true);
          break;
        case LeaderboardType.subject:
          if (subjectId == null) {
            throw ExamDataSourceException('Subject ID required for subject leaderboard');
          }
          query = query
              .where('subjectScores.$subjectId', isNull: false)
              .orderBy('subjectScores.$subjectId', descending: true);
          break;
        case LeaderboardType.weekly:
          final weekAgo = DateTime.now().subtract(const Duration(days: 7));
          query = query
              .where('lastUpdated', isGreaterThanOrEqualTo: weekAgo)
              .orderBy('lastUpdated', descending: true)
              .orderBy('overallScore', descending: true);
          break;
        case LeaderboardType.monthly:
          final monthAgo = DateTime.now().subtract(const Duration(days: 30));
          query = query
              .where('lastUpdated', isGreaterThanOrEqualTo: monthAgo)
              .orderBy('lastUpdated', descending: true)
              .orderBy('overallScore', descending: true);
          break;
      }

      query = query.limit(limit);

      final snapshot = await query.get();
      
      return snapshot.docs
          .map((doc) => LeaderboardEntry.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ExamDataSourceException('Failed to get leaderboard: $e');
    }
  }

  /// Get user's rank on leaderboard
  Future<LeaderboardRank> getUserRank({
    required String userId,
    LeaderboardType type = LeaderboardType.overall,
    String? subjectId,
  }) async {
    try {
      // Get user's entry
      final userDoc = await _firestore
          .collection(_leaderboardCollection)
          .doc(userId)
          .get();

      if (!userDoc.exists) {
        return LeaderboardRank(rank: 0, totalUsers: 0, percentile: 0);
      }

      final userEntry = LeaderboardEntry.fromJson(userDoc.data()!);
      final userScore = type == LeaderboardType.subject && subjectId != null
          ? userEntry.subjectScores[subjectId] ?? 0
          : userEntry.overallScore;

      // Count users with higher scores
      Query query = _firestore.collection(_leaderboardCollection);

      if (type == LeaderboardType.subject && subjectId != null) {
        query = query.where('subjectScores.$subjectId', isGreaterThan: userScore);
      } else {
        query = query.where('overallScore', isGreaterThan: userScore);
      }

      final higherScoreSnapshot = await query.count().get();
      final usersAbove = higherScoreSnapshot.count ?? 0;

      // Get total users
      final totalSnapshot = await _firestore
          .collection(_leaderboardCollection)
          .count()
          .get();
      final totalUsers = totalSnapshot.count ?? 0;

      final rank = usersAbove + 1;
      final percentile = totalUsers > 0 
          ? ((totalUsers - rank) / totalUsers * 100)
          : 0.0;

      return LeaderboardRank(
        rank: rank,
        totalUsers: totalUsers,
        percentile: percentile,
      );
    } catch (e) {
      throw ExamDataSourceException('Failed to get user rank: $e');
    }
  }

  // ============================================================================
  // BATCH OPERATIONS FOR ALL USERS (ADMIN/ANALYTICS)
  // ============================================================================

  /// Get all users' exam statistics (for admin dashboard)
  Future<List<UserExamStatistics>> getAllUsersStatistics({
    int? limit,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      // Get all users with leaderboard entries
      Query query = _firestore.collection(_leaderboardCollection);

      if (limit != null) {
        query = query.limit(limit);
      }

      final snapshot = await query.get();
      
      final statistics = <UserExamStatistics>[];
      
      for (final doc in snapshot.docs) {
        final userId = doc.id;
        
        // Get user's sessions
        final sessions = await getUserExamSessions(
          userId: userId,
          startDate: startDate,
          endDate: endDate,
        );

        statistics.add(
          UserExamStatistics(
            userId: userId,
            totalSessions: sessions.length,
            completedSessions: sessions
                .where((s) => s.status == ExamSessionStatus.completed)
                .length,
            averageScore: _calculateAverageScore(sessions),
            totalTimeSpentMinutes: _calculateTotalTime(sessions),
            lastActive: sessions.isNotEmpty ? sessions.first.startedAt : null,
          ),
        );
      }

      return statistics;
    } catch (e) {
      throw ExamDataSourceException('Failed to get all users statistics: $e');
    }
  }

  /// Stream leaderboard updates in real-time
  Stream<List<LeaderboardEntry>> streamLeaderboard({
    int limit = 50,
    LeaderboardType type = LeaderboardType.overall,
  }) {
    try {
      Query query = _firestore
          .collection(_leaderboardCollection)
          .orderBy('overallScore', descending: true)
          .limit(limit);

      return query.snapshots().map((snapshot) {
        return snapshot.docs
            .map((doc) => LeaderboardEntry.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
      });
    } catch (e) {
      throw ExamDataSourceException('Failed to stream leaderboard: $e');
    }
  }

  // ============================================================================
  // SYNC UTILITIES
  // ============================================================================

  /// Check if data needs syncing
  Future<bool> needsSync() async {
    final lastSync = await getLastSyncTime();
    if (lastSync == null) return true;

    final now = DateTime.now();
    final difference = now.difference(lastSync);

    // Sync if more than 1 hour has passed
    return difference.inHours >= 1;
  }

  /// Get last sync time
  Future<DateTime?> getLastSyncTime() async {
    final timestamp = _prefs.getInt(_lastSyncKey);
    if (timestamp == null) return null;

    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  /// Update last sync time
  Future<void> _updateLastSyncTime() async {
    await _prefs.setInt(_lastSyncKey, DateTime.now().millisecondsSinceEpoch);
  }

  /// Clear sync cache
  Future<void> clearSyncCache() async {
    _cacheManager.clearAll();
    await _prefs.remove(_lastSyncKey);
  }

  // ============================================================================
  // PRIVATE HELPERS
  // ============================================================================

  String _generateHash(ExamSession session) {
    return session.toJson().toString().hashCode.toString();
  }

  double _calculateAverageScore(List<ExamSession> sessions) {
    final completedSessions = sessions
        .where((s) => s.status == ExamSessionStatus.completed)
        .toList();

    if (completedSessions.isEmpty) return 0.0;

    final totalScore = completedSessions.fold<double>(
      0.0,
      (sum, session) {
        // Calculate score based on correct answers
        final correctAnswers = session.questions.where((q) {
          if (q.questionType == QuestionType.objective) {
            return q.selectedAnswer == q.correctAnswer;
          }
          return false; // Essay questions need manual grading
        }).length;

        return sum + (correctAnswers / session.questions.length * 100);
      },
    );

    return totalScore / completedSessions.length;
  }

  int _calculateTotalTime(List<ExamSession> sessions) {
    return sessions.fold<int>(
      0,
      (sum, session) => sum + (session.progress?.timeElapsedMinutes ?? 0),
    );
  }

  // ============================================================================
// 1. ADD TO FIREBASE_EXAM_DATA_SOURCE (firebase_exam_satasource.dart)
// ============================================================================

// Add cache management for leaderboard
Map<String, CachedLeaderboard> _leaderboardCache = {};
static const Duration _leaderboardCacheDuration = Duration(minutes: 5);

/// Get leaderboard as Future (non-streaming) with caching
Future<List<LeaderboardEntry>> getLeaderboardList({
  int limit = 100,
  LeaderboardType type = LeaderboardType.overall,
  String? subjectId,
  bool forceRefresh = false,
}) async {
  try {
    // Generate cache key
    final cacheKey = _generateLeaderboardCacheKey(type, subjectId, limit);
    
    // Check cache first (unless force refresh)
    if (!forceRefresh && _leaderboardCache.containsKey(cacheKey)) {
      final cached = _leaderboardCache[cacheKey]!;
      if (cached.isValid) {
        pskyLog('Using cached leaderboard (${cached.entries.length} entries)');
        return cached.entries;
      }
    }

    pskyLog('Fetching fresh leaderboard from Firestore');
    
    Query query = _firestore.collection(_leaderboardCollection);

    // Apply filters based on type
    switch (type) {
      case LeaderboardType.overall:
        query = query.orderBy('overallScore', descending: true);
        break;
      case LeaderboardType.subject:
        if (subjectId == null) {
          throw ExamDataSourceException('Subject ID required for subject leaderboard');
        }
        query = query
            .where('subjectScores.$subjectId', isNull: false)
            .orderBy('subjectScores.$subjectId', descending: true);
        break;
      case LeaderboardType.weekly:
        final weekAgo = DateTime.now().subtract(const Duration(days: 7));
        query = query
            .where('lastUpdated', isGreaterThanOrEqualTo: weekAgo)
            .orderBy('lastUpdated', descending: true)
            .orderBy('overallScore', descending: true);
        break;
      case LeaderboardType.monthly:
        final monthAgo = DateTime.now().subtract(const Duration(days: 30));
        query = query
            .where('lastUpdated', isGreaterThanOrEqualTo: monthAgo)
            .orderBy('lastUpdated', descending: true)
            .orderBy('overallScore', descending: true);
        break;
    }

    query = query.limit(limit);

    final snapshot = await query.get();
    
    final entries = snapshot.docs
        .map((doc) {
          try {
            return LeaderboardEntry.fromJson(doc.data() as Map<String, dynamic>);
          } catch (e) {
            pskyLog('Error parsing leaderboard entry ${doc.id}: $e');
            return null;
          }
        })
        .whereType<LeaderboardEntry>()
        .toList();

    // Cache the results
    _leaderboardCache[cacheKey] = CachedLeaderboard(
      entries: entries,
      cachedAt: DateTime.now(),
      cacheKey: cacheKey,
    );

    pskyLog('Fetched and cached ${entries.length} leaderboard entries');
    return entries;
  } catch (e) {
    pskyLog('Error fetching leaderboard list: $e');
    throw ExamDataSourceException('Failed to get leaderboard list: $e');
  }
}

/// Get leaderboard count with caching
int? _cachedLeaderboardCount;
DateTime? _countCachedAt;
static const Duration _countCacheDuration = Duration(minutes: 10);

Future<int> getLeaderboardCount({bool forceRefresh = false}) async {
  try {
    // Check cache
    if (!forceRefresh && 
        _cachedLeaderboardCount != null && 
        _countCachedAt != null) {
      final age = DateTime.now().difference(_countCachedAt!);
      if (age < _countCacheDuration) {
        pskyLog('Using cached leaderboard count: $_cachedLeaderboardCount');
        return _cachedLeaderboardCount!;
      }
    }

    pskyLog('Fetching fresh leaderboard count from Firestore');
    
    final snapshot = await _firestore
        .collection(_leaderboardCollection)
        .count()
        .get();
    
    final count = snapshot.count ?? 0;
    
    // Cache the count
    _cachedLeaderboardCount = count;
    _countCachedAt = DateTime.now();
    
    pskyLog('Leaderboard count: $count (cached)');
    return count;
  } catch (e) {
    pskyLog('Error getting leaderboard count: $e');
    return _cachedLeaderboardCount ?? 0;
  }
}

/// Clear leaderboard cache (call when user updates their score)
void clearLeaderboardCache() {
  _leaderboardCache.clear();
  _cachedLeaderboardCount = null;
  _countCachedAt = null;
  pskyLog('Leaderboard cache cleared');
}

/// Clear specific cache entry
void clearLeaderboardCacheEntry(LeaderboardType type, String? subjectId) {
  final keysToRemove = _leaderboardCache.keys.where((key) {
    return key.contains(type.name) && 
           (subjectId == null || key.contains(subjectId));
  }).toList();
  
  for (final key in keysToRemove) {
    _leaderboardCache.remove(key);
  }
  
  pskyLog('Cleared ${keysToRemove.length} cache entries');
}

/// Generate cache key for leaderboard
String _generateLeaderboardCacheKey(
  LeaderboardType type, 
  String? subjectId, 
  int limit,
) {
  return 'leaderboard_${type.name}_${subjectId ?? 'all'}_$limit';
}
}



/// Cache data class (place OUTSIDE the FirebaseExamDataSource class)
class CachedLeaderboard {
  final List<LeaderboardEntry> entries;
  final DateTime cachedAt;
  final String cacheKey;
  
  // Cache duration constant
  static const Duration cacheDuration = Duration(minutes: 5);

  CachedLeaderboard({
    required this.entries,
    required this.cachedAt,
    required this.cacheKey,
  });

  bool get isValid {
    final age = DateTime.now().difference(cachedAt);
    return age < cacheDuration;
  }

  Duration get age => DateTime.now().difference(cachedAt);
}
