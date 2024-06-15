import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:login_flutter_app/src/features/authentication/models/user_model.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/image_strings.dart';
import '../../../../../constants/sizes.dart';
import '../../../../../constants/text_strings.dart';
import '../../../../../repository/authentication_repository/authentication_repository.dart';
import '../../../controllers/profile_controller.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
          "Profile",
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
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                content: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
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
            icon: Icon(
              LineAwesomeIcons.alternate_sign_out,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapShot) {
              if (snapShot.connectionState != ConnectionState.done) {
                Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              }
              if (snapShot.connectionState == ConnectionState.done) {
                if (snapShot.hasData) {
                  UserModel user = snapShot.data as UserModel;

                  //controllers
                  final email = TextEditingController(text: user.email);
                  final password = TextEditingController(text: user.password);
                  final fullName = TextEditingController(text: user.fullName);
                  final phoneNo = TextEditingController(text: user.phoneNo);

                  return Column(
                    children: [
                      // -- IMAGE with ICON
                      Stack(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: const Image(
                                    image: AssetImage(tProfileImage))),
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
                              child: const Icon(LineAwesomeIcons.camera,
                                  color: Colors.black, size: 20),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),
                      Text(fullName.text,
                          style: Theme.of(context).textTheme.headlineSmall),
                      Text(email.text,
                          style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 50),
                      // -- Form Fields
                      Form(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: fullName,
                              style: TextStyle(color: Colors.white),
                              // use (uncomment) initialvalue if you only want to show data to the user
                              // initialValue: userData.fullName,
                              decoration: InputDecoration(
                                  label: Text(
                                    tFullName,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: const BorderSide(
                                          color: Colors.white)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: const BorderSide(
                                          color: Colors.white)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: const BorderSide(
                                          color: Colors.white)),
                                  prefixIcon: Icon(
                                    LineAwesomeIcons.user,
                                    color: Colors.white,
                                  )),
                            ),
                            const SizedBox(height: tFormHeight - 20),
                            TextFormField(
                              controller: email,

                              // initialValue: userData.email,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  label: Text(
                                    tEmail,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: const BorderSide(
                                          color: Colors.white)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: const BorderSide(
                                          color: Colors.white)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: const BorderSide(
                                          color: Colors.white)),
                                  prefixIcon: Icon(
                                    LineAwesomeIcons.envelope_1,
                                    color: Colors.white,
                                  )),
                            ),
                            const SizedBox(height: tFormHeight - 20),
                            TextFormField(
                              controller: phoneNo,
                              // initialValue: userData.phoneNo,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  label: Text(
                                    tPhoneNo,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: const BorderSide(
                                          color: Colors.white)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: const BorderSide(
                                          color: Colors.white)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: const BorderSide(
                                          color: Colors.white)),
                                  prefixIcon: Icon(
                                    LineAwesomeIcons.phone,
                                    color: Colors.white,
                                  )),
                            ),
                            const SizedBox(height: tFormHeight - 20),
                            Obx(
                              () => TextFormField(
                                controller: password,
                                // initialValue: userData.password,
                                style: TextStyle(color: Colors.white),
                                obscureText: controller.showPassword.value,
                                decoration: InputDecoration(
                                  label: const Text(
                                    tPassword,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: const BorderSide(
                                          color: Colors.white)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: const BorderSide(
                                          color: Colors.white)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: const BorderSide(
                                          color: Colors.white)),
                                  prefixIcon: const Icon(
                                    Icons.fingerprint,
                                    color: Colors.white,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: controller.showPassword.value
                                        ? const Icon(
                                            LineAwesomeIcons.eye_slash,
                                            color: Colors.white54,
                                          )
                                        : const Icon(
                                            LineAwesomeIcons.eye,
                                            color: Colors.white54,
                                          ),
                                    onPressed: () => controller.showPassword
                                        .value = !controller.showPassword.value,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: tFormHeight),

                            // -- Form Submit Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  final userData = UserModel(
                                      fullName: fullName.text.trim(),
                                      email: email.text.trim(),
                                      phoneNo: phoneNo.text.trim(),
                                      password: password.text.trim());

                                  await controller.updateRecord(userData);

                                  // Get.to(() => const UpdateProfileScreen()),
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: tPrimaryColor,
                                    side: BorderSide.none,
                                    shape: const StadiumBorder()),
                                child: const Text(tEditProfile,
                                    style: TextStyle(color: tDarkColor)),
                              ),
                            ),
                            const SizedBox(height: tFormHeight),

                            // -- Created Date and Delete Button
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     ElevatedButton(
                            //       onPressed: () {},
                            //       style: ElevatedButton.styleFrom(
                            //           backgroundColor:
                            //               Colors.redAccent.withOpacity(0.5),
                            //           elevation: 0,
                            //           foregroundColor: Colors.white,
                            //           shape: const StadiumBorder(),
                            //           side: BorderSide.none),
                            //       child: const Text("Delete"),
                            //     ),
                            //   ],
                            // )
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (snapShot.hasError) {
                  return Center(
                    child: Text(snapShot.error.toString()),
                  );
                } else {
                  return const Center(
                    child: Text("Something went wrong"),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
