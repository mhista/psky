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
part 'onboarding_state.dart';


// ====================================================================
// CUBIT LOGIC
// ====================================================================
@injectable
class OnBoardingCubit extends Cubit<OnBoardingState> {
  // PageController is a resource, it should be managed (disposed)
  final PageController pageController = PageController();

  // Initialize the cubit with the starting state (index 0)
  OnBoardingCubit() : super(const OnBoardingState(0));

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
      emit(OnBoardingState(index));
    }
  }

  /// Jump to specific dot selected page
  void dotNavigationClick(int index) {
    // The state is updated first (emit), then the UI controller is manipulated
    emit(OnBoardingState(index));
    pageController.jumpToPage(index);
  }

  /// Update current index & jump to next page
  void nextPage(BuildContext context) {
    final storage = GetStorage();
    final currentIndex = state.currentPageIndex;

    if (currentIndex == 2) {
      // 1. Logic for the Last Page (The 'Done' button press)
      storage.write('isFirstTime', false);
      
      if (kDebugMode) {
        print('---------------------------- GET STORAGE NEXT BUTTON ----------------------------');
        print(storage.read('isFirstTime'));
      }
      
      // 2. Navigation
      // Replace Get.offAll with standard Flutter navigation (or your preferred router)
      // Example using Navigator:
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const Placeholder()), // Replace Placeholder() with const LoginScreen()
      );
      
    } else {
      // Logic for moving to the next page
      int nextPageIndex = currentIndex + 1;
      
      // Emit the new state to update the indicator
      emit(OnBoardingState(nextPageIndex));
      
      // Animate the page view
      pageController.animateToPage(
        nextPageIndex, 
        duration: const Duration(milliseconds: 300), 
        curve: Curves.easeIn,
      );
    }
  }

  /// Update current index & jump to the last page
  void skipPage() {
    const lastPageIndex = 2;
    
    // Emit the new state to update the indicator
    emit(const OnBoardingState(lastPageIndex));
    
    // Jump to the last page
    pageController.jumpToPage(lastPageIndex);
  }
}