import 'package:ahiaa_web/features/authentication/domain/entities/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'user_state.dart';
part 'user_cubit.freezed.dart';

@lazySingleton
class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserState.initial());

  void loggedIn(UserEntity user){
      emit(UserState.hasUser(user));
  }
  void loggedOut(){
    emit(const UserState.initial());
  }

  UserEntity? get user => state.maybeWhen(
    hasUser: (user) => user,
    orElse: () => null,
  );

  // bool isLoggedIn()=> state.when(initial: initial, hasUser: hasUser)
}
