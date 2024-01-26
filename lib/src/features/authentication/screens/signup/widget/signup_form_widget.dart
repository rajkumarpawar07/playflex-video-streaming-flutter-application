import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:login_flutter_app/src/features/authentication/controllers/signup_controller.dart';
import 'package:login_flutter_app/src/features/authentication/models/user_model.dart';
// import 'package:login_flutter_app/src/features/authentication/screens/forget_password/forget_password_otp/otp_screen.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/sizes.dart';
import '../../../../../constants/text_strings.dart';
import '../../forget_password/forget_password_otp/otp_screen.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    Key? key,
  }) : super(key: key);

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);
    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : value == null || value.isEmpty
            ? 'Enter Your Email'
            : null;
  }

  String? validatePassword(String? value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value!.isEmpty) {
      return 'Please Enter Password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter Valid Password';
      } else {
        return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    // final formkey = GlobalKey<FormState>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
      child: Form(
        key: controller.signupFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Your Name';
                }
                return null;
              },
              controller: controller.fullName,
              decoration: const InputDecoration(
                  label: Text(tFullName),
                  prefixIcon: Icon(Icons.person_outline_rounded),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100)))),
            ),

            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              validator: validateEmail,
              controller: controller.email,
              decoration: const InputDecoration(
                label: Text(tEmail),
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100))),
              ),
            ),

            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Valid Phone Number';
                }
                return null;
              },
              controller: controller.phoneNo,
              decoration: const InputDecoration(
                label: Text(tPhoneNo),
                prefixIcon: Icon(Icons.numbers),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100))),
              ),
            ),

            const SizedBox(height: tFormHeight - 20),
            Obx(
              () => TextFormField(
                validator: validatePassword,
                obscureText: controller.showPassword.value ? false : true,
                controller: controller.password,
                decoration: InputDecoration(
                  label: const Text(tPassword),
                  prefixIcon: const Icon(Icons.fingerprint),
                  suffixIcon: IconButton(
                    icon: controller.showPassword.value
                        ? const Icon(LineAwesomeIcons.eye)
                        : const Icon(LineAwesomeIcons.eye_slash),
                    onPressed: () => controller.showPassword.value =
                        !controller.showPassword.value,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                ),
              ),
            ),
            const SizedBox(height: tFormHeight - 10),
            // SizedBox(
            //   width: double.infinity,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       if (formkey.currentState!.validate()) {
            //         // email & password authentication
            //         // SignUpController.instance.registerUser(
            //         //     controller.email.text.trim(),
            //         //     controller.password.text.trim());
            //
            //         // phone & otp authentication
            //         // SignUpController.instance
            //         //     .phoneAuthentication(controller.phoneNo.text.trim());
            //
            //         /*
            //         ========
            //         Get user and pass it to controller
            //         ========
            //          */
            //
            //         final user = UserModel(
            //             fullName: controller.fullName.text.trim(),
            //             email: controller.email.text.trim(),
            //             phoneNo: controller.phoneNo.text.trim(),
            //             password: controller.password.text.trim());
            //         // first save users data then perform phone authentication
            //         SignUpController.instance.createUser(user);
            //       } else {
            //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            //             content:
            //                 Text("Something went wrong please try again")));
            //       }
            //     },
            //     child: Text(tSignup.toUpperCase()),
            //   ),
            // )
            Obx(
              () => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: tPrimaryColor,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  // isLoading: controller.isLoading.value? true: false,
                  onPressed: controller.isGoogleLoading.value
                      ? () {}
                      : controller.isLoading.value
                          ? () {}
                          : () => controller.createUser(),
                  // isLoading: controller.isLoading.value? true: false,
                  child: Text(
                    tSignup.toUpperCase(),
                    style: GoogleFonts.poppins(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
