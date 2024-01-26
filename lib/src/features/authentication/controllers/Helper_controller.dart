import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';

class Helper extends GetxController {
/* ---------- VALIDATIONS ---------- */
  static String? validateEmail(value) {}

  static String? validatePassword(value) {}

/* ------ SNACK-BARS ------*/
  static successSnackBar({required title, message}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: tWhiteColor,
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 6),
        margin: const EdgeInsets.all(tDefaultSpace * 10),
        icon: const Icon(LineAwesomeIcons.check_circle, color: tWhiteColor));
  }

  static warningSnackBar({required title, message}) {}

  static errorSnackBar({required title, message}) {}

  static modernSnackBar({required title, message}) {}
}
