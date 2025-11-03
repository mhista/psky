import 'dart:async';

import 'package:ahiaa_web/core/common/loaders/loaders.dart';
import 'package:ahiaa_web/features/authentication/repository/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart'; // Required for navigation
// import 'package:pickafrika/common/loaders/loaders.dart';
// import 'package:pickafrika/common/widgets/success_screen/success_screen1.dart';
// import 'package:pickafrika/data/repositories/authentication_repository/authentication_repository.dart';
// import 'package:pickafrika/utils/constants/image_strings.dart';
// import 'package:pickafrika/utils/constants/text_strings.dart';
part 'email_verification_state.dart';



// ------------------------------

// ====================================================================
// CUBIT STATE
// ====================================================================


// ====================================================================
// CUBIT LOGIC
// ====================================================================
class EmailVerificationCubit extends Cubit<EmailVerificationState> {
  // Use a Timer? to hold the reference to the auto-redirect timer
  Timer? _timer;

  // SEND EMAIL VERIFICATION WHENEVER CUBIT IS CREATED
  EmailVerificationCubit() : super(const EmailVerificationState()) {
    // The equivalent of GetX's onInit()
    verifyUserEmail();
    autoRedirectTimer();
  }

  // SEND EMAIL VERIFICATION LINK
  Future<void> verifyUserEmail() async {
    try {
      await AuthenticationRepository.instance.verifyUserEmail();
      PLoaders.successSnackBar(
          title: 'Account created successfully',
          message:
              'Verification email has been sent to ${FirebaseAuth.instance.currentUser?.email}');
    } catch (e) {
      PLoaders.errorSnackBar(title: 'Oops!', message: e.toString());
    }
  }

  // TIMER TO AUTOMATE REDIRECT ON EMAIL VERIFICATION
  void autoRedirectTimer() {
    // Store the timer reference
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      
      if (user?.emailVerified ?? false) {
        // 1. Cancel the timer
        timer.cancel();
        
        // 2. Navigation (Requires BuildContext, but we'll leave it out of the Cubit 
        //    for clean architecture. The UI will call checkEmailVerificationStatus instead.)
        //    Since GetX allows navigation from the controller, we'll keep the logic 
        //    here but note that passing a BuildContext from the UI to the Cubit is a common
        //    BLoC pattern for navigation.
        //    We will call the manual check which handles navigation.
        checkEmailVerificationStatus();
      }
    });
  }

  // MANUALLY CHECK IF EMAIL IS VERIFIED AND NAVIGATE
  void checkEmailVerificationStatus({BuildContext? context}) {
    final currentUser = FirebaseAuth.instance.currentUser;
    
    // Note: In BLoC, navigation should ideally happen in the UI (via a BlocListener)
    // or by passing the BuildContext here. Since the original used Get.off(), 
    // we'll keep the navigation logic coupled here for a direct conversion.
    if (currentUser != null && currentUser.emailVerified) {
      // Clean up the timer when verification is confirmed
      _timer?.cancel();
      
      // Replace Get.off() with your chosen navigation (e.g., Navigator.pushReplacement or go_router)
      // If using Navigator, you MUST pass a BuildContext to this method from the UI.
      // e.g., Navigator.of(context!).pushReplacement(...)
      
      // Using Get.off() equivalent for direct conversion:
      // Since GetX is removed, we'll assume a global navigation mechanism 
      // or rely on a wrapper that provides the context for now.
      // For this direct conversion, we will just call the screen redirect.
      // AuthenticationRepository.instance.screenRedirect(); 

      // If you are using standard Flutter/GoRouter:
      // Navigator.of(context!).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (_) => SuccessScreen1(
      //       image: PImages.successAnimation,
      //       title: PTexts.accountCreatedTitle,
      //       subtitle: PTexts.accountCreatedSubtitle,
      //       onPressed: () => AuthenticationRepository.instance.screenRedirect(),
      //     ),
      //   ),
      // );
    }
  }
  
  // Dispose of the timer when the Cubit is closed
  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}