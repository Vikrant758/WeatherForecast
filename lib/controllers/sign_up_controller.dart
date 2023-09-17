import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_application/utils/error_messages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../main.dart';
import '../utils/utils.dart';
import '../views/home.dart';

class SignUpController extends GetxController {

  RxString emailErrorText = ''.obs;
  RxString passWordErrorText = ''.obs;


  passwordValidator(String input) {
    if (!Utils.isValidPassword(input)) {
      passWordErrorText.value = 'Minimum 8 characters with letters and numbers';
      return;
    }
    passWordErrorText.value = '';
  }

  emailValidator(String input) {
    if (!Utils.isValidEmail(input)) {
      emailErrorText.value = 'Enter valid email address';
      return;
    }
    emailErrorText.value = '';
  }


  createUserAccountInFirebase(
      {required String email, required String password}) async {
    try {
      emailValidator(email);
      passwordValidator(password);
      if (Utils.isValidEmail(email)) {
        if (Utils.isValidPassword(password)) {
          try {
            emailErrorText.value = '';
            passWordErrorText.value = '';

            UserCredential credential = await FirebaseAuth.instance
                .createUserWithEmailAndPassword(email: email, password: password);

            if (credential.user != null) {
              print(credential.user);
              print("User is signed in broo");

              Get.offAll(const MyHomePage(
              ));
            }
          } on FirebaseAuthException catch (e) {
            print(e.code);
            if (e.code == 'weak-password') {
              Utils.showSnackBar(
                  title: "Weak Password",
                  message: "The password provided is too weak.",
                  iconWidget: const Icon(Icons.error_outline));
              return;
            } else if (e.code == 'email-already-in-use') {
              Utils.showSnackBar(
                  title: "Email already exists!!",
                  message: "The account already exists for that email.",
                  iconWidget: const Icon(Icons.error_outline));
              return;
            }
            Utils.showSnackBar(
                title: ErrorMessages.mainErrorMessageTitle,
                message: ErrorMessages.mainErrorMessageMessage,
                iconWidget: const Icon(Icons.error_outline));
            return;
          } catch (e) {
            Utils.showSnackBar(
                title: ErrorMessages.mainErrorMessageTitle,
                message: ErrorMessages.mainErrorMessageMessage,
                iconWidget: const Icon(Icons.error_outline));
            return;
          }
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
