part of 'onboarding_cubit.dart';

// The state will hold the current page index
class OnBoardingState extends Equatable {
  final int currentPageIndex;

  const OnBoardingState(this.currentPageIndex);

  @override
  List<Object> get props => [currentPageIndex];
}