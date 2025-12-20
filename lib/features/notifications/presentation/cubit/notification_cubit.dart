
import 'dart:async';
import 'package:ahiaa_web/core/utils/enums/notification_enums.dart';
import 'package:ahiaa_web/core/utils/logging/logger.dart';
import 'package:ahiaa_web/features/notifications/domain/repositoy/notification_repo.dart';
import 'package:ahiaa_web/features/practice_exam/domain/entities/exam_entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_state.dart';
part 'notification_cubit.freezed.dart';



@lazySingleton
class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepository _repository;

  String? _currentUserId;
  StreamSubscription<List<ExamNotification>>? _notificationSubscription;
  DocumentSnapshot? _lastDocument;
  static const int _pageSize = 20;

  // Filtering state
  List<ExamNotification> _allNotifications = [];
  NotificationCategory _selectedCategory = NotificationCategory.all;
  NotificationType? _selectedType;
  bool _showUnreadOnly = false;
  String _searchQuery = '';

  NotificationCubit(this._repository) : super(const NotificationState.initial());

  // ============================================================================
  // INITIALIZATION
  // ============================================================================

  void initialize(String userId) {
    _currentUserId = userId;
    _startListening();
    loadNotifications();
  }

  void _startListening() {
    if (_currentUserId == null) return;

    _notificationSubscription?.cancel();
    _notificationSubscription = _repository
        .watchNotifications(_currentUserId!)
        .listen(
          (notifications) {
            _allNotifications = notifications;
            _applyFiltersAndEmit();
          },
          onError: (error) {
            pskyLog('Error in notification stream: $error');
          },
        );
  }

  // ============================================================================
  // FILTERING METHODS
  // ============================================================================

  /// Filter by notification category
  void filterByCategory(NotificationCategory category) {
    _selectedCategory = category;
    _selectedType = null; // Reset type filter when category changes
    _applyFiltersAndEmit();
    pskyLog('Filtered by category: ${category.displayName}');
  }

  /// Filter by specific notification type
  void filterByType(NotificationType? type) {
    _selectedType = type;
    if (type != null) {
      _selectedCategory = type.category;
    }
    _applyFiltersAndEmit();
    pskyLog('Filtered by type: ${type?.displayName ?? "All"}');
  }

  /// Toggle show unread only
  void toggleUnreadOnly() {
    _showUnreadOnly = !_showUnreadOnly;
    _applyFiltersAndEmit();
    pskyLog('Show unread only: $_showUnreadOnly');
  }

  /// Search notifications by title or body
  void searchNotifications(String query) {
    _searchQuery = query.toLowerCase().trim();
    _applyFiltersAndEmit();
    pskyLog('Searching: $_searchQuery');
  }

  /// Clear all filters
  void clearFilters() {
    _selectedCategory = NotificationCategory.all;
    _selectedType = null;
    _showUnreadOnly = false;
    _searchQuery = '';
    _applyFiltersAndEmit();
    pskyLog('All filters cleared');
  }

  /// Apply all active filters and emit new state
  void _applyFiltersAndEmit() {
    var filtered = List<ExamNotification>.from(_allNotifications);

    // Apply category filter
    if (_selectedCategory != NotificationCategory.all) {
      final categoryTypes = _selectedCategory.types;
      filtered = filtered.where((n) => categoryTypes.contains(n.type)).toList();
    }

    // Apply type filter
    if (_selectedType != null) {
      filtered = filtered.where((n) => n.type == _selectedType).toList();
    }

    // Apply unread filter
    if (_showUnreadOnly) {
      filtered = filtered.where((n) => !n.isRead).toList();
    }

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((n) {
        return n.title.toLowerCase().contains(_searchQuery) ||
            n.body.toLowerCase().contains(_searchQuery);
      }).toList();
    }

    // Sort by priority then by date
    filtered.sort((a, b) {
      // First sort by priority
      final priorityCompare = b.type.priorityLevel.compareTo(a.type.priorityLevel);
      if (priorityCompare != 0) return priorityCompare;
      
      // Then by date (newest first)
      return b.createdAt.compareTo(a.createdAt);
    });

    final unreadCount = _allNotifications.where((n) => !n.isRead).length;

    emit(NotificationState.loaded(
      notifications: filtered,
      unreadCount: unreadCount,
      hasMore: false, // Filtering is client-side, no pagination
    ));
  }

  // ============================================================================
  // GETTERS FOR CURRENT FILTER STATE
  // ============================================================================

  NotificationCategory get currentCategory => _selectedCategory;
  NotificationType? get currentType => _selectedType;
  bool get isShowingUnreadOnly => _showUnreadOnly;
  String get currentSearchQuery => _searchQuery;
  bool get hasActiveFilters =>
      _selectedCategory != NotificationCategory.all ||
      _selectedType != null ||
      _showUnreadOnly ||
      _searchQuery.isNotEmpty;

  // ============================================================================
  // STATISTICS & ANALYTICS
  // ============================================================================

  /// Get notification count by type
  Map<NotificationType, int> getNotificationCountByType() {
    final counts = <NotificationType, int>{};
    for (final notification in _allNotifications) {
      counts[notification.type] = (counts[notification.type] ?? 0) + 1;
    }
    return counts;
  }

  /// Get notification count by category
  Map<NotificationCategory, int> getNotificationCountByCategory() {
    final counts = <NotificationCategory, int>{};
    for (final notification in _allNotifications) {
      final category = notification.type.category;
      counts[category] = (counts[category] ?? 0) + 1;
    }
    return counts;
  }

  /// Get unread count by category
  Map<NotificationCategory, int> getUnreadCountByCategory() {
    final counts = <NotificationCategory, int>{};
    for (final notification in _allNotifications.where((n) => !n.isRead)) {
      final category = notification.type.category;
      counts[category] = (counts[category] ?? 0) + 1;
    }
    return counts;
  }

  /// Get notifications from today
  List<ExamNotification> getTodayNotifications() {
    final today = DateTime.now();
    return _allNotifications.where((n) {
      return n.createdAt.year == today.year &&
          n.createdAt.month == today.month &&
          n.createdAt.day == today.day;
    }).toList();
  }

  /// Get notifications from this week
  List<ExamNotification> getThisWeekNotifications() {
    final now = DateTime.now();
    final weekAgo = now.subtract(const Duration(days: 7));
    return _allNotifications.where((n) {
      return n.createdAt.isAfter(weekAgo);
    }).toList();
  }

  /// Get most recent notification by type
  ExamNotification? getMostRecentByType(NotificationType type) {
    final filtered = _allNotifications.where((n) => n.type == type).toList();
    if (filtered.isEmpty) return null;
    filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return filtered.first;
  }

  // ============================================================================
  // LOAD NOTIFICATIONS (EXISTING METHODS)
  // ============================================================================

  Future<void> loadNotifications({bool refresh = false}) async {
    if (_currentUserId == null) {
      emit(const NotificationState.error(message: 'User not initialized'));
      return;
    }

    try {
      if (refresh) {
        emit(const NotificationState.loading());
        _lastDocument = null;
      }

      final notifications = await _repository.getNotifications(
        userId: _currentUserId!,
        limit: 100, // Load more for client-side filtering
      );

      _allNotifications = notifications;
      _applyFiltersAndEmit();

      pskyLog('Loaded ${notifications.length} notifications');
    } catch (e) {
      pskyLog('Error loading notifications: $e');
      emit(NotificationState.error(message: 'Failed to load notifications: $e'));
    }
  }

  // ============================================================================
  // MARK AS READ (EXISTING METHODS WITH FILTER PRESERVATION)
  // ============================================================================

  Future<void> markAsRead(String notificationId) async {
    if (_currentUserId == null) return;

    try {
      await _repository.markAsRead(_currentUserId!, notificationId);

      // Update local list
      _allNotifications = _allNotifications.map((n) {
        if (n.id == notificationId) {
          return n.copyWith(isRead: true);
        }
        return n;
      }).toList();

      _applyFiltersAndEmit();
      pskyLog('Marked notification as read: $notificationId');
    } catch (e) {
      pskyLog('Error marking as read: $e');
    }
  }

  Future<void> markAllAsRead() async {
    if (_currentUserId == null) return;

    try {
       _repository.markAllAsRead(_currentUserId!);

      // Update local list
      _allNotifications = _allNotifications
          .map((n) => n.copyWith(isRead: true))
          .toList();

      _applyFiltersAndEmit();
      pskyLog('Marked all notifications as read');
    } catch (e) {
      pskyLog('Error marking all as read: $e');
    }
  }

  // ============================================================================
  // DELETE NOTIFICATIONS (WITH FILTER PRESERVATION)
  // ============================================================================

  Future<void> deleteNotification(String notificationId) async {
    if (_currentUserId == null) return;

    try {
      await _repository.deleteNotification(_currentUserId!, notificationId);

      // Remove from local list
      _allNotifications = _allNotifications
          .where((n) => n.id != notificationId)
          .toList();

      _applyFiltersAndEmit();
      pskyLog('Deleted notification: $notificationId');
    } catch (e) {
      pskyLog('Error deleting notification: $e');
    }
  }

  Future<void> deleteAllNotifications() async {
    if (_currentUserId == null) return;

    try {
      await _repository.deleteAllNotifications(_currentUserId!);

      _allNotifications = [];
      _applyFiltersAndEmit();
      pskyLog('Deleted all notifications');
    } catch (e) {
      pskyLog('Error deleting all notifications: $e');
    }
  }

  // ============================================================================
  // BULK OPERATIONS
  // ============================================================================

  /// Mark all filtered notifications as read
  Future<void> markFilteredAsRead() async {
    final currentState = state;
    if (currentState is! _Loaded) return;

    final filteredIds = currentState.notifications.map((n) => n.id).toList();
    
    for (final id in filteredIds) {
      await markAsRead(id);
    }
    
    pskyLog('Marked ${filteredIds.length} filtered notifications as read');
  }

  /// Delete all filtered notifications
  Future<void> deleteFiltered() async {
    final currentState = state;
    if (currentState is! _Loaded) return;

    final filteredIds = currentState.notifications.map((n) => n.id).toList();
    
    for (final id in filteredIds) {
      await deleteNotification(id);
    }
    
    pskyLog('Deleted ${filteredIds.length} filtered notifications');
  }

  // ============================================================================
  // EXISTING GETTERS
  // ============================================================================

  int get unreadCount {
    return _allNotifications.where((n) => !n.isRead).length;
  }

  List<ExamNotification> get notifications {
    final currentState = state;
    if (currentState is _Loaded) {
      return currentState.notifications;
    }
    return [];
  }

  bool get hasUnread => unreadCount > 0;

  List<ExamNotification> getNotificationsByType(NotificationType type) {
    return _allNotifications.where((n) => n.type == type).toList();
  }

  List<ExamNotification> get unreadNotifications {
    return _allNotifications.where((n) => !n.isRead).toList();
  }

  // ============================================================================
  // CLEANUP
  // ============================================================================

  @override
  Future<void> close() {
    _notificationSubscription?.cancel();
    return super.close();
  }
}