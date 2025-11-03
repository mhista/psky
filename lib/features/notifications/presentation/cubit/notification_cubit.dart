import 'package:ahiaa_web/features/notifications/presentation/cubit/notification_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // For kDebugMode
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
// Note: You'll replace Get.offAll with standard Flutter navigation (e.g., Navigator.push or go_router)

// Import the LoginScreen and any other required pages
// import '../../screens/login/login.dart';

// ====================================================================
// CUBIT STATE
// ====================================================================

// ====================================================================
// CUBIT LOGIC
// ====================================================================
@singleton
class NotificationCubit extends Cubit<NotificationState> {
  // PageController is a resource, it should be managed (disposed)
  final PageController pageController = PageController();
  
  // Total number of pages
  final int totalPages = 2; // Adjust this based on your actual number of pages

  // Initialize the cubit with the starting state (index 0)
  NotificationCubit() : super(NotificationState(0));

  /// Disposes the PageController when the Cubit is closed
  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }

  /// Update Current Index when page scrolls
  void updatePageIndicator(int index) {
    // Only emit a new state if the index has actually changed
    if (index != state.currentPageIndex) {
      emit(NotificationState(index));
    }
  }

  /// Navigate to the next page
  void next() {
    final currentIndex = state.currentPageIndex;
    
    // Check if not already on the last page
    if (currentIndex < totalPages - 1) {
      final nextPageIndex = currentIndex + 1;
      
      // Emit the new state to update the indicator
      emit(NotificationState(nextPageIndex));
      
      // Animate to the next page
      pageController.animateToPage(
        nextPageIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Navigate to the previous page
  void previous() {
    final currentIndex = state.currentPageIndex;
    
    // Check if not already on the first page
    if (currentIndex > 0) {
      final previousPageIndex = currentIndex - 1;
      
      // Emit the new state to update the indicator
      emit(NotificationState(previousPageIndex));
      
      // Animate to the previous page
      pageController.animateToPage(
        previousPageIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Update current index & jump to the last page
  void skipPage() {
    final lastPageIndex = totalPages - 1;

    // Emit the new state to update the indicator
    emit(NotificationState(lastPageIndex));

    // Jump to the last page
    pageController.jumpToPage(lastPageIndex);
  }

  /// Check if on first page
  bool get isFirstPage => state.currentPageIndex == 0;

  /// Check if on last page
  bool get isLastPage => state.currentPageIndex == totalPages - 1;
}