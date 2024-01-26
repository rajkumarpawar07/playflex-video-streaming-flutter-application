import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/image_strings.dart';
import '../../../../../constants/sizes.dart';
import '../../../../../constants/text_strings.dart';
import '../../../../../utils/theme/widget_theme/social_button.dart';
import '../../../controllers/login_controller.dart';
import '../../login/login_screen.dart';

class SignUpFooterWidget extends StatelessWidget {
  const SignUpFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Column(
      children: [
        Text(
          "OR",
          style: GoogleFonts.poppins(
              fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.black),
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
        ),
        TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          child: Text.rich(TextSpan(children: [
            TextSpan(
              text: tAlreadyHaveAnAccount,
              style: GoogleFonts.poppins(
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.black),
            ),
            TextSpan(text: tLogin.toUpperCase())
          ])),
        )
      ],
    );
  }
}
