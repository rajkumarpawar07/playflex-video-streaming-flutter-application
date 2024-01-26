import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../../../constants/image_strings.dart';
import '../../../../constants/sizes.dart';
import '../../../../repository/authentication_repository/authentication_repository.dart';
import '../../controllers/mail_verification_controller.dart';

class MailVerification extends StatelessWidget {
  const MailVerification({super.key});

  @override
  Widget build(BuildContext context) {
    // initialize the controller
    final controller = Get.put(MailVerificationController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              top: tDefaultSpace * 5,
              left: tDefaultSpace,
              right: tDefaultSpace,
              bottom: tDefaultSpace * 2), // EdgeInsets.only

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(tForgetPasswordImage,
                  // color: imageColor,
                  height: 200),
              const SizedBox(height: tDefaultSpace * 1.5),
              Text("Verify Your Email".tr,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: tDefaultSpace),
              Text(
                "Please check your inbox for a verification link".tr,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ), // Text
              const SizedBox(height: tDefaultSpace * 2),
              SizedBox(
                width: 200,
                child: OutlinedButton(
                    child: Text("Continue".tr),
                    onPressed: () =>
                        controller.manuallyCheckEmailVerificationStatus()),
              ), // SizedBox
              const SizedBox(height: tDefaultSpace * 2),
              TextButton(
                onPressed: () => controller.sendVerificationEmail(),
                child: Text("Resend Email Link".tr),
              ), // TextButton
              TextButton(
                onPressed: () => AuthenticationRepository.instance.logout(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(LineAwesomeIcons.alternate_long_arrow_left),
                    const SizedBox(width: 5),
                    Text("Back To Login".tr),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
