import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repository/authentication_repository/authentication_repository.dart';
import '../../../repository/user_repository/user_repository.dart';
import '../models/user_model.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  /// TextField Controllers to get data from TextFields
  final showPassword = false.obs;
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserRepository());

  //Loader
  final isLoading = false.obs;
  final isGoogleLoading = false.obs;
  final isFacebookLoading = false.obs;

  /// TextField Validation

  /// [Call_this_Function_from_Design_&_it_will_do_the_rest]
  Future<void> login() async {
    try {
      isLoading.value = true;
      if (!loginFormKey.currentState!.validate()) {
        isLoading.value = false;
        return;
      }
      final auth = AuthenticationRepository.instance;
      await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());
      auth.setInitialScreen(auth.firebaseUser);
    } catch (e) {
      isLoading.value = false;
      // Helper.errorSnackBar(title: tOhSnap, message : e.toString());
      Get.snackbar("message", e.toString());
    }
  }

  /// [GoogleSignInAuthentication]
  Future<void> googleSignIn() async {
    try {
      isGoogleLoading.value = true;
      final auth = AuthenticationRepository.instance;
      final userCredentials = await auth.signInWithGoogle();
      final _db = FirebaseFirestore.instance;

      UserModel user = UserModel(
        fullName: userCredentials.user!.displayName ?? "",
        email: userCredentials.user!.email ?? "",
        phoneNo: userCredentials.user!.phoneNumber ?? "",
        password: "",
      );
      final snapshot = await _db
          .collection("Users")
          .where("Email", isEqualTo: userCredentials.user!.email)
          .get();

      if (snapshot.docs.isEmpty) {
        print('email does not exists');
        await userController.createUser(user);
      }
      isGoogleLoading.value = false;
      auth.setInitialScreen(auth.firebaseUser);
    } catch (e) {
      isGoogleLoading.value = false;
      // Helper.errorSnackBar (title: tohSnap, message: e.toString());
      Get.snackbar("Success", e.toString());
    }
  }

  /// [FacebookSignInAuthentication] Future<void> facebookSignIn() async {...}
}
