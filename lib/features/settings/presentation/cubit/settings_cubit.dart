import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'settings_state.dart';

@injectable
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());
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
    pageController.jumpToPage(
      page,
    );
    emit(state.copyWith(pageIndex: page));
  }

  /// Update current index & jump to next page
  void changePage(int page) {
    debugPrint(page.toString());
    emit(state.copyWith(pageIndex: page));
  }

  void canSwipe(DragEndDetails details) {
    // final canProceed = checkEnability(state.pageIndex);
    if (details.primaryVelocity! < 0) {
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
