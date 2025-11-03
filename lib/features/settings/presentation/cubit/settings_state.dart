part of 'settings_cubit.dart';

 class SettingsState extends Equatable {
   final int pageIndex;
  final bool canMove;
  const SettingsState(
    {
     this.pageIndex =0,  this.canMove = false,

    }
  );

  @override
  List<Object> get props => [];

  
  SettingsState copyWith({
    int? pageIndex,
    bool? canMove,
  }) {
    return SettingsState(
      
       pageIndex: pageIndex ?? this.pageIndex,
     canMove: canMove ?? this.canMove,
      
    );
  }
}

