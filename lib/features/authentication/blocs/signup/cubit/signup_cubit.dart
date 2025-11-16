import 'package:ahiaa_web/core/common/loaders/loaders.dart';
import 'package:ahiaa_web/data/repositories/user/user_repository.dart';
import 'package:ahiaa_web/features/authentication/data/models/user_model.dart';
import 'package:ahiaa_web/core/utils/constants/image_strings.dart';
import 'package:ahiaa_web/core/utils/helpers/network_manager.dart';
import 'package:ahiaa_web/core/utils/popups/fullscreen_loader.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart'; // For BuildContext and GlobalKey (passed into signup)

// --- Placeholder for Imports (Replace with your actual paths) ---
// import 'package:pickafrika/common/loaders/loaders.dart';
// import 'package:pickafrika/data/repositories/authentication_repository/authentication_repository.dart';
// import 'package:pickafrika/features/authentication/models/user_model.dart';
// import 'package:pickafrika/features/authentication/screens/signup/verify_email.dart';
// import 'package:pickafrika/utils/constants/image_strings.dart';
// import 'package:pickafrika/utils/popups/fullscreen_loader.dart';
// import '../../../../data/repositories/user/user_repository.dart';
// import '../../../../utils/helpers/network_manager.dart';
part 'signup_state.dart';

@injectable
class SignupCubit extends Cubit<SignupState> {
  final UserRepository userRepository = UserRepository(); // Direct instance or injected

  SignupCubit() : super(const SignupState());

  // Toggles the visibility of the password
  void togglePasswordVisibility() {
    emit(state.copyWith(hidePassword: !state.hidePassword));
  }

  // Toggles the acceptance of the privacy policy
  void togglePrivacyPolicy(bool? value) {
    if (value != null) {
      emit(state.copyWith(privacyPolicyAccepted: value));
    }
  }

  // SIGNUP FUNCTION
  Future<void> signup({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController email,
    required TextEditingController password,
    required TextEditingController firstName,
    required TextEditingController lastName,
    required TextEditingController username,
    required TextEditingController phoneNumber,
  }) async {
    try {
      // 1. START LOADING and emit loading state
      emit(state.copyWith(isLoading: true));
      PFullScreenLoader.openLoadingDialog('Information being processed', PImages.loading);
      
      // 2. CHECK INTERNET CONNECTIVITY
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        PFullScreenLoader.stopLoading();
        emit(state.copyWith(isLoading: false));
        return;
      }

      // 3. FORM VALIDATION
      if (!formKey.currentState!.validate()) {
        PFullScreenLoader.stopLoading();
        emit(state.copyWith(isLoading: false));
        return;
      }

      // 4. PRIVACY POLICY CHECK (using the state value)
      if (!state.privacyPolicyAccepted) {
        PLoaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message:
                'To create an account, you must have to read and accept the Privacy Policy & Terms of Use');
        PFullScreenLoader.stopLoading();
        emit(state.copyWith(isLoading: false));
        return;
      }

      // 5. REGISTER USER IN FIREBASE AUTHENTICATION
      // final userCredential = await AuthenticationRepository.instance
      //     .registerWithEmailAndPassword(
      //         email.text.trim(), password.text.trim());

      // 6. SAVE AUTHENTICATED USER DATA IN FIRESTORE
      // final newUser = UserModel(
      //     id: userCredential.user!.uid,
      //     firstName: firstName.text.trim(),
      //     lastName: lastName.text.trim(),
      //     username: username.text.trim(),
      //     email: email.text.trim(),
      //     phoneNumber: phoneNumber.text.trim(),
      //     profilePicture: '', createdAt: null);
      
      // await userRepository.saveUser(newUser);
      
      // // 7. REMOVE LOADER and emit final state
      // PFullScreenLoader.stopLoading();
      // emit(state.copyWith(isLoading: false));

      // 8. SHOW SUCCESS MESSAGE
      PLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your account has been created! verify email to continue');

      // 9. NAVIGATION (Done using standard Navigator/GoRouter via BuildContext)
      // Replace Get.to with standard Flutter navigation
      // Note: Navigation should ideally be handled by a BlocListener in the UI,
      // but this direct conversion uses context for simplicity.
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (_) => VerifyEmailScreen(email: email.text.trim()),
      //   ),
      // );

    } catch (e) {
      // HANDLE ERROR
      PFullScreenLoader.stopLoading();
      emit(state.copyWith(isLoading: false));
      PLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}