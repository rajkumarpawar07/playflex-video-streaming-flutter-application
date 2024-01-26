import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({
    Key? key,
    this.imageColor,
    this.heightBetween,
    required this.image,
    required this.title,
    required this.subTitle,
    this.imageHeight = 0.2,
    this.textAlign,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  }) : super(key: key);

  //Variables -- Declared in Constructor
  final Color? imageColor;
  final double imageHeight;
  final double? heightBetween;
  final String image, title, subTitle;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Lottie.asset(image,
            // color: imageColor,
            height: size.height * imageHeight),
        SizedBox(height: heightBetween),
        Text(
          title,
          style: GoogleFonts.poppins(
              fontSize: 26.0, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        Text(
          subTitle,
          textAlign: textAlign,
          style: GoogleFonts.poppins(
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
              color: Colors.black),
        ),
      ],
    );
  }
}
