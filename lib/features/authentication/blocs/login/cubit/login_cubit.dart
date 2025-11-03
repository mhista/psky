import 'package:ahiaa_web/core/common/loaders/loaders.dart';
import 'package:ahiaa_web/features/authentication/repository/auth_repo.dart';
import 'package:ahiaa_web/features/authentication/blocs/signup/cubit/email_verification_cubit.dart' hide PImages;
import 'package:ahiaa_web/features/personalization/controllers/user_controller.dart';
import 'package:ahiaa_web/core/utils/enums/enums.dart';
import 'package:ahiaa_web/core/utils/constants/image_strings.dart';
import 'package:ahiaa_web/core/utils/helpers/network_manager.dart';
import 'package:ahiaa_web/core/utils/popups/fullscreen_loader.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart'; // For BuildContext and GlobalKey
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
part 'login_state.dart';

// import 'package:ahiaa_web/features/personalization/controllers/user_controller.dart'; 
// Note: UserController should also be converted to a Cubit/Bloc

// --- Placeholder/Mock Implementations (REPLACE WITH YOUR ACTUAL IMPORTS) ---
// Since the original code was commented out, I'm providing placeholders 
// for the external dependencies. You must uncomment and import your real files.

@injectable
class LoginCubit extends Cubit<LoginState> {
  final GetStorage localStorage = GetStorage();
  final UserController userController = UserController.instance; 
  
  // Text controllers are usually managed by the UI, but we'll manage 
  // their initial values here based on 'remember me' storage.
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  LoginCubit() : super(const LoginState()) {
    // Equivalent of GetX's onInit() to load remembered credentials
    _loadRememberedCredentials();
  }

  void _loadRememberedCredentials() {
    email.text = localStorage.read('remember_me_email') ?? '';
    password.text = localStorage.read('remember_me_password') ?? '';
    // Also check if any credentials were loaded to set 'rememberMe' state
    final hasRemembered = email.text.isNotEmpty && password.text.isNotEmpty;
    if (hasRemembered) {
      emit(state.copyWith(rememberMe: true));
    }
  }

  @override
  Future<void> close() {
    // Dispose resources managed by the Cubit
    email.dispose();
    password.dispose();
    return super.close();
  }

  // --- State Modifiers ---

  void toggleRememberMe(bool? value) {
    if (value != null) {
      emit(state.copyWith(rememberMe: value));
    }
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(hidePassword: !state.hidePassword));
  }
  
  // --- Business Logic ---

  Future<void> emailAndPassworSignIn({
    required GlobalKey<FormState> loginFormKey,
    required BuildContext context,
  }) async {
    try {
      // 1. START LOADING
      emit(state.copyWith(isLoading: true));
      PFullScreenLoader.openLoadingDialog('Logging in.... ', PImages.loading);
      
      // 2. CHECK INTERNET CONNECTIVITY
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        PFullScreenLoader.stopLoading();
        emit(state.copyWith(isLoading: false));
        return;
      }

      // 3. FORM VALIDATION
      if (!loginFormKey.currentState!.validate()) {
        PFullScreenLoader.stopLoading();
        emit(state.copyWith(isLoading: false));
        return;
      }
      
      // 4. STORE REMEMBER ME
      if (state.rememberMe) {
        // You only want to write if the user *checked* the box
        localStorage.write('remember_me_email', email.text.trim());
        localStorage.write('remember_me_password', password.text.trim());
      } else {
        // If unchecked, clear the storage
        localStorage.remove('remember_me_email');
        localStorage.remove('remember_me_password');
      }
      
      // 5. LOGIN USER
      // await AuthenticationRepository.instance
      //     .loginWitheEmailAndPassword(email.text.trim(), password.text.trim());

      // 6. FETCH USER DETAILS AND ASSIGN USERCONTROLLER
      final user = await userController.fetchUserRecord();
      
      // 7. REMOVE LOADER
      PFullScreenLoader.stopLoading();
      emit(state.copyWith(isLoading: false));

      // 8. CHECK USER ROLE AND REDIRECT
      if (user.role != AppRole.admin.name) {
        // await AuthenticationRepository.instance.logout();
        // PLoaders.errorSnackBar(
        //     title: 'Not Authorized',
        //     message:
        //         'You are not authorized. Please contact the administrator');
      } else {
        // REDIRECT TO HOME (Handled by the repository's screenRedirect or via context)
        // AuthenticationRepository.instance.screenRedirect();
      }
    } catch (e) {
      PFullScreenLoader.stopLoading();
      emit(state.copyWith(isLoading: false));
      // PLoaders.errorSnackBar(title: "Ooops!", message: e.toString());
    }
  }

  Future<void> registerAdmin() async {
    try {
      // 1. START LOADING
      emit(state.copyWith(isLoading: true));
      PFullScreenLoader.openLoadingDialog('Registering.... ', PImages.loading);
      
      // 2. CHECK INTERNET CONNECTIVITY
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        PFullScreenLoader.stopLoading();
        emit(state.copyWith(isLoading: false));
        return;
      }
      
      // 3. REGISTER ADMIN (assuming the credentials are in the TextControllers)
      // final userCredentials = await AuthenticationRepository.instance
      //     .loginWitheEmailAndPassword(email.text.trim(), password.text.trim());

      // // 4. CREATE ADMIN RECORD IN THE FIRESTORE
      // await userController.saveUserRecord(userCredentials);
      
      // // 5. FETCH USER DETAILS AND ASSIGN USERCONTROLLER
      // await userController.fetchUserRecord();

      // 6. REMOVE LOADER
      PFullScreenLoader.stopLoading();
      emit(state.copyWith(isLoading: false));

      // 7. REDIRECT TO HOME
      // AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      PFullScreenLoader.stopLoading();
      emit(state.copyWith(isLoading: false));
      // PLoaders.errorSnackBar(title: "Ooops!", message: e.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      // 1. START LOADING
      emit(state.copyWith(isLoading: true));
      PFullScreenLoader.openLoadingDialog('Logging in.... ', PImages.loading);
      
      // 2. CHECK INTERNET CONNECTIVITY
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        PFullScreenLoader.stopLoading();
        emit(state.copyWith(isLoading: false));
        return;
      }

      // 3. SIGN IN WITH GOOGLE
      // final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();
      
      // 4. SAVE USER RECORD
      // await userController.saveUserRecord(userCredentials);
      
      // 5. REMOVE LOADER
      PFullScreenLoader.stopLoading();
      emit(state.copyWith(isLoading: false));

      // 6. REDIRECT
      // PLoaders.successSnackBar(title: 'Welcome back!');
      // AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      PFullScreenLoader.stopLoading();
      emit(state.copyWith(isLoading: false));
      // PLoaders.errorSnackBar(title: "Ooops!", message: e.toString());
    }
  }
}