
// The state will hold the current page index
import 'package:equatable/equatable.dart';

class NotificationPageState extends Equatable {
  final int currentPageIndex;

  const NotificationPageState(this.currentPageIndex);

  @override
  List<Object> get props => [currentPageIndex];
}