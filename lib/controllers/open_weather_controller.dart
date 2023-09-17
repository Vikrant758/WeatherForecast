import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/credentials.dart';
import '../models/open_weather_model.dart';
import '../services/open_weather_service/open_weather_service.dart';
import '../utils/error_messages.dart';
import '../utils/utils.dart';

class OpenWeatherController extends GetxController {

  @override
  void onInit() {
    // TODO: implement onInit
    print("OnInit OpenWeatherController");
    super.onInit();
  }

  OpenWeatherModel openWeatherModel = OpenWeatherModel();

  getCurrentDayForecastReport() async {
    var latLongData = await Utils.getLatLong();
    if (latLongData is Map && latLongData['location_found']) {
      var weatherInfo = await OpenWeatherService().getCurrentWeatherInformation(lat: latLongData['lat'].toString(), long: latLongData['long'].toString(), appId: Credentials.openWeatherApiKey);
      print(weatherInfo);
      if (weatherInfo is Map && weatherInfo['status']) {
        print("We found the weather information");
        openWeatherModel.fromJson(weatherInfo['data']);
        print(openWeatherModel.showForecast);
        print(openWeatherModel.placeName);
        print(openWeatherModel.weatherInfo);
        print(openWeatherModel.humidityInPercentage);
        print(openWeatherModel.maximumTemperatureInCelsius);
        print(openWeatherModel.minimumTemperatureInCelsius);
        print(openWeatherModel.temperatureInCelsius);
        print(openWeatherModel.weatherIconUrl);
      } else {
        Utils.showSnackBar(
            title: ErrorMessages.mainErrorMessageTitle,
            message: ErrorMessages.mainErrorMessageMessage,
            iconWidget: const Icon(Icons.error_outline));
      }
    }
  }
}