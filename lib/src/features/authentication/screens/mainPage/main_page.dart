// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:login_flutter_app/src/features/core/screens/dashboard/dashboard.dart';
//
// import '../welcome/welcome_screen.dart';
//
// class mainPage extends StatelessWidget {
//   const mainPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return DashBoard();
//         } else {
//           return WelcomeScreen();
//         }
//       },
//     ));
//   }
// }
