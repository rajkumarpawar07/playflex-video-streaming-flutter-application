import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_flutter_app/src/features/authentication/models/user_model.dart';
import 'package:login_flutter_app/src/repository/user_repository/user_repository.dart';

import '../../../repository/authentication_repository/authentication_repository.dart';
import '../screens/forget_password/forget_password_otp/otp_screen.dart';

class SignUpController extends GetxController {
  // inistializing instance
  static SignUpController get instance => Get.find();

  //TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  final showPassword = false.obs;
  final isLoading = false.obs;
  final isGoogleLoading = false.obs;
  final isFacebookLoading = false.obs;

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  final userRepo = Get.put(UserRepository());

  /// This func will be used to register user with [EMAIL] & [Password]
  void registerUser(String email, String password) {
    String? error = AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, password) as String?;
    if (error != null) {
      Get.showSnackbar(GetSnackBar(message: error.toString()));
    }
  }

  //Get phoneNo from user (Screen) and pass it to Auth Repository for Firebase Authentication
  Future<void> createUser() async {
    try {
      print("usercreate() function");
      isLoading.value = true;
      print("isloading done?");
      if (!signupFormKey.currentState!.validate()) {
        print("inside if");
        isLoading.value = false;
        return;
      }
      print("if done?");

      /// For Phone Authentication
// SignUpController.instance.phoneAuthentication (controller.phoneNo.text.trim());
// Get.to(() => const OTPScreen());

// Get User and Pass it to Controller
      final user = UserModel(
        fullName: fullName.text.trim(),
        email: email.text.trim(),
        phoneNo: phoneNo.text.trim(),
        password: password.text.trim(),
      );

      print("usser model done");
// Authenticate User first
      final auth = AuthenticationRepository.instance;
      await auth.createUserWithEmailAndPassword(user.email, user.password);
      await UserRepository.instance.createUser(user);
      auth.setInitialScreen(auth.firebaseUser);
    } catch (e) {
      print("catch");
      isLoading.value = false;
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5));
    }
    // first show or store the data
    // await userRepo.createUser(user);
    // then call phone authetication
//     phoneAuthentication(user.phoneNo);
// go to OTp screen
//     Get.to(() => const OTPScreen());
  }

  // [PhoneNo Authentication]
  Future<void> phoneAuthentication(String phoneNo) async {
    try {
      await AuthenticationRepository.instance.phoneAuthentication(phoneNo);
    } catch (e) {
      throw e.toString();
    }
  }
}
