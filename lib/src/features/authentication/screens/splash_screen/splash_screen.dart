import 'package:flutter/material.dart';
import 'package:login_flutter_app/src/features/authentication/screens/mail_verification/mail_verification.dart';
import 'package:login_flutter_app/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:lottie/lottie.dart';
import '../../../../../main_page.dart';
import '../../../../constants/image_strings.dart';
import '../on_boarding/on_boarding_screen.dart';

class splashScreen extends StatefulWidget {
  final int screen;
  const splashScreen({Key? key, required this.screen}) : super(key: key);

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  bool animate = false;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: (3)), () {
      if (widget.screen == 1) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const OnBoardingScreen()));
      } else if (widget.screen == 2) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const MainPage()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MailVerification()));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Lottie.asset(splashScreenLattie)),
            ]),
      ),
    );
  }
}
