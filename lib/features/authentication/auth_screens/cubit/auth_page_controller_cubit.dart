import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'auth_page_controller_state.dart';
@injectable
class AuthPageControllerCubit extends Cubit<AuthPageControllerState> {
  AuthPageControllerCubit() : super(const AuthPageControllerState());
  final PageController pageController = PageController();

  /// Disposes the PageController when the Cubit is closed
  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }


   /// Update current index & jump to next page
  void nextPage(int page) {
    
// Animate the page view
      pageController.animateToPage(
        page, 
        duration: const Duration(milliseconds: 300), 
        curve: Curves.easeIn,
      );
    emit(state.copyWith(pageIndex: page));

  }

   /// Update current index & jump to next page
  void changePage(int page) {
    emit(state.copyWith(pageIndex: page));

  }


   void canSwipe(DragEndDetails details) {
    // final canProceed = checkEnability(state.pageIndex);
    if (details.primaryVelocity! < 0 ) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    } else if (details.primaryVelocity! > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    }
  }
}
