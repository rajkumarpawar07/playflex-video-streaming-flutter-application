import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../../constants/image_strings.dart';
import '../../../../constants/text_strings.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Lottie.asset(tWelcomeScreenImage, height: size.height * 0.2),
        Text(
          tLoginTitle,
          style: GoogleFonts.poppins(
              fontSize: 26.0, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        Text(
          tLoginSubTitle,
          style: GoogleFonts.poppins(
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
              color: Colors.black),
        ),
      ],
    );
  }
}
