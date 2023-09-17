import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_application/controllers/sign_up_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../main.dart';
import '../utils/error_messages.dart';
import '../utils/utils.dart';
import '../views/home.dart';

class SignInController extends GetxController{
  logInUserIntoFirebase(
      {required String email, required String password}) async {
    try {
      SignUpController controller = Get.put(SignUpController());
      controller.emailValidator(email);
      if (Utils.isValidEmail(email)) {
        if (password.isNotEmpty) {
          try {
            UserCredential credential = await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: email, password: password);

            if (credential.user != null) {
              if (kDebugMode) {
                print(credential.user);
                print("User is signed in broo");
              }

              Get.offAll(() => const MyHomePage());
            }
          } on FirebaseAuthException catch (e) {
            if (kDebugMode) {
              print(e.code);
            }

            if (e.code == 'user-not-found') {
              Utils.showSnackBar(
                  message: "Please Sign Up First!!",
                  title: "No user found for that email.",
                  iconWidget: const Icon(Icons.error_outline));
            } else if (e.code == 'wrong-password') {
              Utils.showSnackBar(
                  message: "Invalid Password",
                  title: "Make you have written right password.",
                  iconWidget: const Icon(Icons.error_outline));
            } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
              Utils.showSnackBar(
                  title: "Invalid Email or Password",
                  message: "Make sure you have written right credentials.",
                  iconWidget: const Icon(Icons.error_outline));
            }
          } catch (e) {
            Utils.showSnackBar(
                title: ErrorMessages.mainErrorMessageTitle,
                message: ErrorMessages.mainErrorMessageMessage,
                iconWidget: const Icon(Icons.error_outline));
          }
        } else {
          Utils.showSnackBar(
              title: "Invalid Password",
              message: "Password can't be empty.",
              iconWidget: const Icon(Icons.error_outline));
        }
      }
    } catch (e) {
      Utils.showSnackBar(
          title: ErrorMessages.mainErrorMessageTitle,
          message: ErrorMessages.mainErrorMessageMessage,
          iconWidget: const Icon(Icons.error_outline));
    }
  }
}
