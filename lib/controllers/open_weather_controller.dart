import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/credentials.dart';
import '../models/open_weather_model.dart';
import '../services/open_weather_service/open_weather_service.dart';
import '../utils/error_messages.dart';
import '../utils/utils.dart';
import '../views/weather_forecaste.dart';

class OpenWeatherController extends GetxController {
  OpenWeatherModel openWeatherModel = OpenWeatherModel();

  getCurrentDayForecastReport() async {
    var latLongData = await Utils.getLatLong();
    if (latLongData is Map && latLongData['location_found']) {
      var weatherInfo = await OpenWeatherService().getCurrentWeatherInformation(
          lat: latLongData['lat'].toString(),
          long: latLongData['long'].toString(),
          appId: Credentials.openWeatherApiKey);
      if (weatherInfo is Map && weatherInfo['status']) {
        openWeatherModel.fromJson(weatherInfo['data']);

        if (openWeatherModel.showForecast) {
          Get.to(() => const WeatherForecast());
        }
      } else {
        Utils.showSnackBar(
            title: ErrorMessages.mainErrorMessageTitle,
            message: ErrorMessages.mainErrorMessageMessage,
            iconWidget: const Icon(Icons.error_outline));
      }
    } else {
      Utils.showSnackBar(
          title: "Sorry couldn't find your location",
          message:
              "Please try again or Check you location settings are on or not",
          iconWidget: const Icon(Icons.error_outline));
    }
  }
}
