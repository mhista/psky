part of 'auth_page_controller_cubit.dart';

class AuthPageControllerState extends Equatable {
  final int pageIndex;
  final bool canMove;
  const AuthPageControllerState( {
     this.pageIndex =0,  this.canMove = false,
  });

  @override
  List<Object> get props => [];

  AuthPageControllerState copyWith({
    int? pageIndex,
    bool? canMove,
  }) {
    return AuthPageControllerState(
      
       pageIndex: pageIndex ?? this.pageIndex,
     canMove: canMove ?? this.canMove,
      
    );
  }
}

