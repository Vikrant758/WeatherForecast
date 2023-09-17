import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Utils {

  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    num minLength = 8;

    if (password.length < minLength) {
      return false;
    }

    final hasLetter = password.contains(RegExp(r'[a-zA-Z]'));
    final hasNumber = password.contains(RegExp(r'[0-9]'));

    return hasLetter && hasNumber;
  }

  static showSnackBar({required String title, required String message, Function? onTap,
      Widget iconWidget = const Icon(Icons.alarm)}) {
    Get.snackbar(
      title,
      message,
      icon: iconWidget,
      shouldIconPulse: true,
      onTap: (snack) {
        if (onTap != null) {
          onTap();
        }
      },
      barBlur: 20,
      isDismissible: true,
      duration: const Duration(seconds: 5),
    );
  }
}