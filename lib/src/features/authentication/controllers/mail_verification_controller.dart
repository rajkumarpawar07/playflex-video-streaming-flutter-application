import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:login_flutter_app/src/repository/authentication_repository/authentication_repository.dart';

class MailVerificationController extends GetxController {
  late Timer _timer;

  // this is the function which is gonna run first on calling class
  @override
  void onInit() {
    super.onInit();
    sendVerificationEmail();
    setTimerForAuthentication();
  }

  // send OR Resend Email verification
  Future<void> sendVerificationEmail() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
    } catch (e) {
      print(e.toString());
      // Helper.errorSnackBar(title: tOhSnap, message: e.toString());
    }
  }

  // set timer to check if verification completed then Redirect
  void setTimerForAuthentication() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user!.emailVerified) {
        timer.cancel();
        AuthenticationRepository.instance.setInitialScreen(user);
      }
    });
  }

// manually check if verification completed then redirect
  void manuallyCheckEmailVerificationStatus() {
    FirebaseAuth.instance.currentUser?.reload();
    final user = FirebaseAuth.instance.currentUser;
    if (user!.emailVerified) {
      AuthenticationRepository.instance.setInitialScreen(user);
    }
  }
}
