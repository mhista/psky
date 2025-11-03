
// The state will hold the current page index
import 'package:equatable/equatable.dart';

class NotificationState extends Equatable {
  final int currentPageIndex;

  const NotificationState(this.currentPageIndex);

  @override
  List<Object> get props => [currentPageIndex];
}