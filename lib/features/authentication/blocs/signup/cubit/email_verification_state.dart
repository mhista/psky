part of 'email_verification_cubit.dart';

// We use Equatable for proper state comparison, but the state holds no data.
// If you wanted to show 'Loading' or 'Error' status on the screen, 
// you'd define sub-classes here (e.g., EmailVerificationLoading, EmailVerificationError).
class EmailVerificationState extends Equatable {
  const EmailVerificationState();

  @override
  List<Object> get props => [];
}