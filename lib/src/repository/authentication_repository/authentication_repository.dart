import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_flutter_app/src/features/authentication/screens/mail_verification/mail_verification.dart';
import 'package:login_flutter_app/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:login_flutter_app/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:login_flutter_app/src/features/core/screens/dashboard/dashboard.dart';
import 'package:login_flutter_app/src/repository/authentication_repository/exceptions/t_exceptions.dart';
// import 'exceptions/login_with_email_and_pssword_failure.dart';
import '../../../main.dart';
import '../../../main_page.dart';
import '../../features/authentication/screens/login/login_screen.dart';
import '../../features/authentication/screens/splash_screen/splashScreenDashBoard.dart';
import '../../features/core/screens/dashboard/profile/profile_screen.dart';
import 'exceptions/login_email_failure.dart';
import 'exceptions/signup_email_failure.dart';
// import 'exceptions/signup_email_password_failure.dart';

class AuthenticationRepository extends GetxController {
  // instance for AuthenticationRepository
  static AuthenticationRepository get instance => Get.find();

  //Variables
  // instance for firebase
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> _firebaseUser;
  var verificationId = ''.obs;
  late final GoogleSignInAccount _googleUser;

  //Getters
  User? get firebaseUser => _firebaseUser.value;

  String get getUserID => firebaseUser?.uid ?? "";

  String get getUserEmail => firebaseUser?.email ?? "";

  //Will be load when app launches this func will be called and set the firebaseUser state
  @override
  void onReady() {
    _firebaseUser = Rx<User?>(_auth.currentUser);
    _firebaseUser.bindStream(_auth.userChanges());
    // on going to execute when app launch first time
    setInitialScreen(_firebaseUser.value);
    // ever(_firebaseUser, _setInitialScreen);
  }

  /// If we are setting initial screen from here
  /// then in the main.dart => App() add CircularProgressIndicator()
  setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const splashScreen())
        : user.emailVerified
            ? Get.offAll(() => const MainPage())
            : Get.offAll(() => const MailVerification());
  }

  // google sign in
  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      final ex = TExceptions.fromCode(e.code);
      throw ex.message;
    } catch (_) {
      const ex = TExceptions();
      throw ex.message;
    }
  }

  // phone authentication
  Future<void> loginWithPhoneNo(String phoneNo) async {
    try {
      await _auth.signInWithPhoneNumber(phoneNo);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-phone-number') {
        Get.snackbar("Error", "Invalid Phone No");
      }
    } catch (_) {
      Get.snackbar("Error", "Something went wrong");
    }
  }

  // phone authentication
  Future<void> phoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (credential) async {
          await _auth.signInWithCredential(credential);
        },
        codeSent: (verificationId, resendToken) {
          this.verificationId.value = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) {
          this.verificationId.value = verificationId;
        },
        verificationFailed: (e) {
          if (e.code == 'invalid-phone-number') {
            Get.snackbar('Error', 'The provided phone number is not valid');
          } else {
            Get.snackbar("Error", "Something went wrong try again");
          }
        });
  }

  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: this.verificationId.value, smsCode: otp));

    return credentials.user != null ? true : false;
  }

  // email authentication for SIGNUP
  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _firebaseUser.value != null
          ? Get.offAll(() => const ProfileScreen())
          : Get.to(() => const splashScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      throw ex.message;
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      throw ex.message;
    }
  }

  // email authentication for LOGIN
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final ex = LogInWithEmailAndPasswordFailure.fromCode(e.code);
      throw ex.message;
    } catch (_) {
      const ex = LogInWithEmailAndPasswordFailure();
      throw ex.message;
    }
  }

  // enail verification - VERIFICATION
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      final ex = TExceptions.fromCode(e.code);
      throw ex.message;
    } catch (_) {
      const ex = TExceptions();
      throw ex.message;
    }
  }

  // LOGOUT
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      // await FacebookAuth.instance.logout();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const WelcomeScreen());
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    } on FormatException catch (e) {
      throw e.message;
    } catch (e) {
      throw 'Unable to logout. Try again.';
    }
  }
}
