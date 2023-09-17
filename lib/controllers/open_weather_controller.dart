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

  @override
  void onInit() {
    // TODO: implement onInit
    print("OnInit OpenWeatherController");
    super.onInit();
  }

  OpenWeatherModel openWeatherModel = OpenWeatherModel();

  getCurrentDayForecastReport() async {
    var latLongData = await Utils.getLatLong();
    print(latLongData);
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

        if (openWeatherModel.showForecast) {
          Get.to(()=> const WeatherForecast());
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
          message: "Please try again or Check you location settings are on or not",
          iconWidget: const Icon(Icons.error_outline));
    }
  }
}