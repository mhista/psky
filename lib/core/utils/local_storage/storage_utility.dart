// ============================================================================
// ENHANCED LOCAL STORAGE SERVICE - HIVE BASED
// ============================================================================
// Add to pubspec.yaml:
// dependencies:
//   hive: ^2.2.3
//   hive_flutter: ^1.1.0
//
// dev_dependencies:
//   hive_generator: ^2.0.1
//   build_runner: ^2.4.6

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

/// Centralized local storage service using Hive
/// Automatically handles user-specific data isolation
@lazySingleton
class LocalStorageService {
  final String _userBoxPrefix = 'user_';
  final String _globalBoxx = 'app_global';

  Box? _currentUserBox;
  Box? _globalBox;
  String? _currentUserId;

  /// Initialize Hive (call once in main.dart)
  Future<void> initialize() async {
    await Hive.initFlutter();
    debugPrint('Hive initialized');
  }

  /// Set current user and open their box
  Future<void> setUser(String userId) async {
    try {
      if (_currentUserId == userId && _currentUserBox != null) {
        debugPrint('User box already open for: $userId');
        return;
      }

      // Close previous user box if open
      if (_currentUserBox != null && _currentUserBox!.isOpen) {
        await _currentUserBox!.close();
      }

      _currentUserId = userId;
      final boxName = '$_userBoxPrefix$userId';

      // Open user-specific box
      _currentUserBox = await Hive.openBox(boxName);
      debugPrint('Opened user box: $boxName');

      // Open global box if not already open
      if (_globalBox == null || !_globalBox!.isOpen) {
        _globalBox = await Hive.openBox(_globalBoxx);
        debugPrint('Opened global box');
      }
    } catch (e) {
      debugPrint('Error setting user: $e');
      rethrow;
    }
  }

  /// Clear current user (on logout)
  Future<void> clearUser() async {
    if (_currentUserBox != null && _currentUserBox!.isOpen) {
      await _currentUserBox!.close();
    }
    _currentUserBox = null;
    _currentUserId = null;
    debugPrint('User box closed');
  }

  // ============================================================================
  // USER-SPECIFIC OPERATIONS
  // ============================================================================

  /// Save user-specific data
  Future<void> saveUserData<T>(String key, T value) async {
    _ensureUserBox();
    try {
      if (value is String ||
          value is int ||
          value is double ||
          value is bool ||
          value is List ||
          value is Map) {
        await _currentUserBox!.put(key, value);
        debugPrint('Saved user data: $key');
      } else {
        // For complex objects, convert to JSON
        final jsonString = jsonEncode(value);
        await _currentUserBox!.put(key, jsonString);
        debugPrint('Saved user data (JSON): $key');
      }
    } catch (e) {
      debugPrint('Error saving user data: $e');
      rethrow;
    }
  }

  /// Get user-specific data
  T? getUserData<T>(String key, {T? defaultValue}) {
    _ensureUserBox();
    try {
      final value = _currentUserBox!.get(key, defaultValue: defaultValue);
      if (value == null) return defaultValue;
      return value as T;
    } catch (e) {
      debugPrint('Error getting user data: $e');
      return defaultValue;
    }
  }

  /// Save user data as JSON string
  Future<void> saveUserJson(String key, Map<String, dynamic> json) async {
    await saveUserData(key, jsonEncode(json));
  }

  /// Get user data as JSON
  Map<String, dynamic>? getUserJson(String key) {
    final jsonString = getUserData<String>(key);
    if (jsonString == null) return null;
    try {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      debugPrint('Error decoding JSON: $e');
      return null;
    }
  }

  /// Save list of JSON objects
  Future<void> saveUserJsonList(
      String key, List<Map<String, dynamic>> list) async {
    await saveUserData(key, jsonEncode(list));
  }

  /// Get list of JSON objects
  List<Map<String, dynamic>>? getUserJsonList(String key) {
    final jsonString = getUserData<String>(key);
    if (jsonString == null) return null;
    try {
      final decoded = jsonDecode(jsonString) as List;
      return decoded.cast<Map<String, dynamic>>();
    } catch (e) {
      debugPrint('Error decoding JSON list: $e');
      return null;
    }
  }

  /// Remove user-specific data
  Future<void> removeUserData(String key) async {
    _ensureUserBox();
    await _currentUserBox!.delete(key);
    debugPrint('Removed user data: $key');
  }

  /// Check if user data exists
  bool hasUserData(String key) {
    _ensureUserBox();
    return _currentUserBox!.containsKey(key);
  }

  /// Clear all user data (use with caution)
  Future<void> clearUserData() async {
    _ensureUserBox();
    await _currentUserBox!.clear();
    debugPrint('Cleared all user data for: $_currentUserId');
  }

  /// Get all user data keys
  List<String> getUserDataKeys() {
    _ensureUserBox();
    return _currentUserBox!.keys.cast<String>().toList();
  }

  // ============================================================================
  // GLOBAL APP OPERATIONS (not user-specific)
  // ============================================================================

  /// Save global app data
  Future<void> saveGlobalData<T>(String key, T value) async {
    _ensureGlobalBox();
    await _globalBox!.put(key, value);
    debugPrint('Saved global data: $key');
  }

  /// Get global app data
  T? getGlobalData<T>(String key, {T? defaultValue}) {
    _ensureGlobalBox();
    return _globalBox!.get(key, defaultValue: defaultValue) as T?;
  }

  /// Remove global data
  Future<void> removeGlobalData(String key) async {
    _ensureGlobalBox();
    await _globalBox!.delete(key);
  }

  /// Check if global data exists
  bool hasGlobalData(String key) {
    _ensureGlobalBox();
    return _globalBox!.containsKey(key);
  }

  // ============================================================================
  // BATCH OPERATIONS
  // ============================================================================

  /// Save multiple user data entries at once
  Future<void> saveUserDataBatch(Map<String, dynamic> data) async {
    _ensureUserBox();
    await _currentUserBox!.putAll(data);
    debugPrint('Saved batch user data: ${data.keys.length} items');
  }

  /// Get multiple user data entries at once
  Map<String, dynamic> getUserDataBatch(List<String> keys) {
    _ensureUserBox();
    final result = <String, dynamic>{};
    for (final key in keys) {
      final value = _currentUserBox!.get(key);
      if (value != null) {
        result[key] = value;
      }
    }
    return result;
  }

  // ============================================================================
  // UTILITY METHODS
  // ============================================================================

  /// Get current user ID
  String? get currentUserId => _currentUserId;

  /// Check if user box is open
  bool get isUserBoxOpen => _currentUserBox != null && _currentUserBox!.isOpen;

  /// Get storage size for current user (approximate)
  int getUserStorageSize() {
    _ensureUserBox();
    return _currentUserBox!.length;
  }

  /// Export user data (for backup/migration)
  Map<String, dynamic> exportUserData() {
    _ensureUserBox();
    return Map<String, dynamic>.from(_currentUserBox!.toMap());
  }

  /// Import user data (for backup/migration)
  Future<void> importUserData(Map<String, dynamic> data) async {
    _ensureUserBox();
    await _currentUserBox!.putAll(data);
    debugPrint('Imported user data: ${data.keys.length} items');
  }

  // ============================================================================
  // ADMIN OPERATIONS (use with caution)
  // ============================================================================

  /// Delete all data for a specific user (admin only)
  Future<void> deleteUserBox(String userId) async {
    final boxName = '$_userBoxPrefix$userId';
    if (await Hive.boxExists(boxName)) {
      await Hive.deleteBoxFromDisk(boxName);
      debugPrint('Deleted user box: $boxName');
    }
  }

  /// List all user boxes
  //  Future<List<String>> listAllUsers() async {
  //   // This is a simplified version - in production, you'd track this separately
  //   final boxes = Hive.;
  //   debugPrint('Available boxes: $boxes');
  //   return [];
  // }

  // ============================================================================
  // PRIVATE HELPERS
  // ============================================================================

  void _ensureUserBox() {
    if (_currentUserBox == null || !_currentUserBox!.isOpen) {
      throw Exception('User box not initialized. Call setUser() first.');
    }
  }

  void _ensureGlobalBox() {
    if (_globalBox == null || !_globalBox!.isOpen) {
      throw Exception('Global box not initialized.');
    }
  }

  /// Dispose (call on app shutdown)
  Future<void> dispose() async {
    if (_currentUserBox != null && _currentUserBox!.isOpen) {
      await _currentUserBox!.close();
    }
    if (_globalBox != null && _globalBox!.isOpen) {
      await _globalBox!.close();
    }
    debugPrint('LocalStorageService disposed');
  }
}

// ============================================================================
// STORAGE KEYS CONSTANTS (organize all your storage keys here)
// ============================================================================

class StorageKeys {
  // User-specific keys
  static const String examSessions = 'exam_sessions';
  static const String streakData = 'streak_data';
  static const String userPreferences = 'user_preferences';
  static const String lastSync = 'last_firebase_sync';
  static const String offlineQueue = 'offline_queue';

  // Global app keys
  static const String isFirstTimer = 'is_first_timer';
  static const String hasSeenLanding = 'has_seen_landing';
  static const String appVersion = 'app_version';
  static const String theme = 'theme_mode';
}
