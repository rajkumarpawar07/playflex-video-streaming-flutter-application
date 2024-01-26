import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:login_flutter_app/src/features/core/screens/dashboard/profile/profile_menu.dart';
import 'package:login_flutter_app/src/features/core/screens/dashboard/profile/update_profile_screen.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/image_strings.dart';
import '../../../../../constants/sizes.dart';
import '../../../../../constants/text_strings.dart';
import '../../../../../repository/authentication_repository/authentication_repository.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //     onPressed: () => Get.back(),
        //     icon: const Icon(LineAwesomeIcons.angle_left)),
        backgroundColor: Colors.transparent,
        toolbarHeight: 60,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.purple, Colors.red],
                  begin: Alignment.bottomRight,
                  end: Alignment.bottomLeft),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
        ),
        title: Text(
          tProfile,
          style: GoogleFonts.poppins(
              fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.defaultDialog(
                title: "LOGOUT",
                confirmTextColor: Colors.black,
                titleStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                content: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Are you sure, you want to Logout?",
                    style: GoogleFonts.poppins(
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                  ),
                ),
                confirm: Expanded(
                  child: ElevatedButton(
                    onPressed: () => AuthenticationRepository.instance.logout(),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        side: BorderSide.none),
                    child: const Text("Yes"),
                  ),
                ),
                cancel: OutlinedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black, side: BorderSide.none),
                    onPressed: () => Get.back(),
                    child: const Text(
                      "No",
                      style: TextStyle(color: Colors.white),
                    )),
              );
            },
            icon: Icon(LineAwesomeIcons.alternate_sign_out),
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(tDefaultSize),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// -- IMAGE
            Stack(
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Image(image: AssetImage(tProfileImage))),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: tPrimaryColor),
                    child: const Icon(
                      LineAwesomeIcons.alternate_pencil,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(tProfileHeading, style: Theme.of(context).textTheme.headline4),
            Text(tProfileSubHeading,
                style: Theme.of(context).textTheme.bodyText2),
            const SizedBox(height: 20),

            /// -- BUTTON
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () => Get.to(() => const UpdateProfileScreen()),
                style: ElevatedButton.styleFrom(
                    backgroundColor: tPrimaryColor,
                    side: BorderSide.none,
                    shape: const StadiumBorder()),
                child: const Text(tEditProfile,
                    style: TextStyle(color: tDarkColor)),
              ),
            ),
            // const SizedBox(height: 30),
            // const Divider(),
            const SizedBox(height: 10),

            /// -- MENU
            // ProfileMenuWidget(
            //     title: "Settings",
            //     icon: LineAwesomeIcons.cog,
            //     onPress: () {}),
            // ProfileMenuWidget(
            //     title: "Billing Details",
            //     icon: LineAwesomeIcons.wallet,
            //     onPress: () {}),
            // ProfileMenuWidget(
            //     title: "User Management",
            //     icon: LineAwesomeIcons.user_check,
            //     onPress: () {}),
            // const Divider(),
            const SizedBox(height: 10),
            // ProfileMenuWidget(
            //     title: "Information",
            //     icon: LineAwesomeIcons.info,
            //     onPress: () {}),
            // ProfileMenuWidget(
            //     title: "Logout",
            //     icon: LineAwesomeIcons.alternate_sign_out,
            //     textColor: Colors.red,
            //     endIcon: false,
            //     onPress: () {
            //       Get.defaultDialog(
            //         title: "LOGOUT",
            //         confirmTextColor: Colors.black,
            //         titleStyle: TextStyle(
            //           fontSize: 20,
            //           color: Colors.black,
            //         ),
            //         content: Padding(
            //           padding: EdgeInsets.all(10.0),
            //           child: Text(
            //             "Are you sure, you want to Logout?",
            //             style: GoogleFonts.poppins(
            //                 fontSize: 14.0,
            //                 fontWeight: FontWeight.normal,
            //                 color: Colors.black),
            //           ),
            //         ),
            //         confirm: Expanded(
            //           child: ElevatedButton(
            //             onPressed: () =>
            //                 AuthenticationRepository.instance.logout(),
            //             style: ElevatedButton.styleFrom(
            //                 backgroundColor: Colors.redAccent,
            //                 side: BorderSide.none),
            //             child: const Text("Yes"),
            //           ),
            //         ),
            //         cancel: OutlinedButton(
            //             style: ElevatedButton.styleFrom(
            //                 backgroundColor: Colors.black,
            //                 side: BorderSide.none),
            //             onPressed: () => Get.back(),
            //             child: const Text(
            //               "No",
            //               style: TextStyle(color: Colors.white),
            //             )),
            //       );
            //     }),
          ],
        ),
      ),
    );
  }
}
