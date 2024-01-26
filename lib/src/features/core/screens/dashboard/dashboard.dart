import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:login_flutter_app/src/constants/sizes.dart';
import 'package:login_flutter_app/src/features/core/screens/dashboard/profile/profile_screen.dart';

import '../../../../repository/authentication_repository/authentication_repository.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        // titleTextStyle: Text("DashBoard"),
      ),
      // body: Container(
      //   padding: EdgeInsets.all(tDefaultSize),
      //   child: Center(
      //     child: Column(
      //       children: [
      //         SizedBox(
      //           width: double.infinity,
      //           child: Center(
      //             child: SizedBox(
      //               width: double.infinity,
      //               child: ElevatedButton(
      //                 // onPressed: () {
      //                 //   AuthenticationRepository.instance.logout();
      //                 onPressed: () => Get.to(() => const ProfileScreen()),
      //                 child: Text("Profile Page"),
      //               ),
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
