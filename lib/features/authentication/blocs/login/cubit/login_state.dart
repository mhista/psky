part of 'login_cubit.dart';

class LoginState extends Equatable {
  final bool rememberMe;
  final bool hidePassword;
  final bool isLoading; // To manage the PFullScreenLoader equivalent

  const LoginState({
    this.rememberMe = false,
    this.hidePassword = true,
    this.isLoading = false,
  });

  // Method to create a new state by copying the old one and changing specific fields
  LoginState copyWith({
    bool? rememberMe,
    bool? hidePassword,
    bool? isLoading,
  }) {
    return LoginState(
      rememberMe: rememberMe ?? this.rememberMe,
      hidePassword: hidePassword ?? this.hidePassword,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [rememberMe, hidePassword, isLoading];
}