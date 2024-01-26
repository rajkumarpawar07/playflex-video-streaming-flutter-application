import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/image_strings.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../../../../utils/theme/widget_theme/social_button.dart';
import '../../controllers/login_controller.dart';
import '../signup/signup_screen.dart';

class LoginFooterWidget extends StatefulWidget {
  const LoginFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginFooterWidget> createState() => _LoginFooterWidgetState();
}

class _LoginFooterWidgetState extends State<LoginFooterWidget> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Container(
        // crossAxisAlignment: CrossAxisAlignment.center,
        padding: const EdgeInsets.only(bottom: tDefaultSpace),
        child: Column(
          children: [
            Text(
              "OR",
              style: GoogleFonts.poppins(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
            const SizedBox(height: tFormHeight - 15),
            Obx(
              () => TSocialButton(
                image: tGoogleLogoImage,
                background: tDarkColor,
                foreground: tWhiteColor,
                text: 'Google',
                isLoading: controller.isGoogleLoading.value ? true : false,
                onPressed: controller.isLoading.value
                    ? () {}
                    : controller.isGoogleLoading.value
                        ? () {}
                        : () => controller.googleSignIn(),
              ),
            ), // Obx
            const SizedBox(height: tFormHeight - 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpScreen()));
              },
              child: Text.rich(
                TextSpan(
                    text: tDontHaveAnAccount,
                    style: GoogleFonts.poppins(
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                    children: const [
                      TextSpan(
                          text: tSignup, style: TextStyle(color: Colors.blue))
                    ]),
              ),
            ),
          ],
        ));
  }
}
