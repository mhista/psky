part of 'signup_cubit.dart';

class SignupState extends Equatable {
  final bool hidePassword;
  final bool privacyPolicyAccepted;
  final bool isLoading; // New state to manage the full-screen loader

  const SignupState({
    this.hidePassword = true,
    this.privacyPolicyAccepted = false,
    this.isLoading = false,
  });

  // Method to create a new state by copying the old one and changing specific fields
  SignupState copyWith({
    bool? hidePassword,
    bool? privacyPolicyAccepted,
    bool? isLoading,
  }) {
    return SignupState(
      hidePassword: hidePassword ?? this.hidePassword,
      privacyPolicyAccepted: privacyPolicyAccepted ?? this.privacyPolicyAccepted,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [hidePassword, privacyPolicyAccepted, isLoading];
}