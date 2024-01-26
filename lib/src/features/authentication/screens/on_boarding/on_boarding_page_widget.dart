import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_flutter_app/src/constants/colors.dart';
import 'package:lottie/lottie.dart';

import '../../../../constants/sizes.dart';
import '../../models/model_on_boarding.dart';

class OnBoardingPageWidget extends StatelessWidget {
  const OnBoardingPageWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  final OnBoardingModel model;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(tDefaultSize),
      color: model.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Lottie.asset(
            model.image,
            height: size.height * 0.45,
          ),
          Column(
            children: [
              Text(
                model.title,
                // style: Theme.of(context).textTheme.headline3,
                style: GoogleFonts.montserrat(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                    color: tDarkColor),
              ),
              Text(
                model.subTitle,
                style: GoogleFonts.poppins(
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                    color: tDarkColor),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Text(
            model.counterText,
            style: GoogleFonts.poppins(
                fontSize: 14.0, fontWeight: FontWeight.w600, color: tDarkColor),
          ),
          const SizedBox(
            height: 50.0,
          )
        ],
      ),
    );
  }
}
