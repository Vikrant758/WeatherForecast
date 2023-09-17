import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:permission_handler/permission_handler.dart';

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

  static Future<dynamic> getLatLong() async {
    try {
      PermissionStatus permission = await Permission.location.status;
      if (permission == PermissionStatus.denied) {
        permission = await Permission.location.request();
        if (permission == PermissionStatus.denied) {
          Utils.showSnackBar(
              title: "Please Allow the access to location",
              message:
                  "If you want to see weather report please allow location access",
              iconWidget: const Icon(Icons.error_outline));
          return {'location_found': false};
        }
      }

      if (permission == PermissionStatus.permanentlyDenied) {
        Utils.showSnackBar(
            title: "Location access required to see forecast report",
            message: "Click on this popup to give location permission",
            iconWidget: const Icon(Icons.error_outline),
            onTap: () async {
              await Geolocator.openAppSettings();
            });
        return {'location_found': false};
      }

      var desiredAccuracy = permission == PermissionStatus.granted
          ? LocationAccuracy.high
          : LocationAccuracy.low;

      Position getCurrentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: desiredAccuracy,
        timeLimit: const Duration(seconds: 20),
      );

      return {
        'location_found': true,
        'lat': getCurrentPosition.latitude,
        'long': getCurrentPosition.longitude
      };
    } catch (e) {
      return {
        'location_found': false,
      };
    }
  }

  static showSnackBar(
      {required String title,
      required String message,
      Function? onTap,
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
