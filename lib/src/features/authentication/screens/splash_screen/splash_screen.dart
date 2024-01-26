import 'package:flutter/material.dart';
import 'package:login_flutter_app/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:lottie/lottie.dart';
import '../../../../constants/image_strings.dart';
import '../on_boarding/on_boarding_screen.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  bool animate = false;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: (1)), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const OnBoardingScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.centerLeft,
        child: Lottie.asset(splashScreenLattie),
      ),
    );
  }
}
