import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_application/views/sign_in.dart';
import 'package:flutter_weather_application/views/sign_up.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/open_weather_controller.dart';
import '../models/credentials.dart';
import '../services/open_weather_service/open_weather_service.dart';
import '../utils/utils.dart';

class WeatherForecast extends StatefulWidget {
  const WeatherForecast({super.key});

  @override
  State<WeatherForecast> createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {

  OpenWeatherController controller = Get.put(OpenWeatherController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Forecast"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Image.network(controller.openWeatherModel.weatherIconUrl),
              const SizedBox(width: 30),
              Text(
                '${controller.openWeatherModel.temperatureInCelsius} °C',
              ),
            ],),
            const SizedBox(width: 30),

            Text(
              'Place: ${controller.openWeatherModel.placeName}',
            ),
            const SizedBox(width: 30),

            Text(
              'Temperature feels like: ${controller.openWeatherModel.temperatureFeelsLike} °C',
            ),
            const SizedBox(width: 30),

            Text(
              'Maximum Temperature: ${controller.openWeatherModel.maximumTemperatureInCelsius} °C',
            ),
            const SizedBox(width: 30),

            Text(
              'Minimum Temperature: ${controller.openWeatherModel.minimumTemperatureInCelsius} °C',
            ),
            const SizedBox(width: 30),

            Text(
              'Humidity Percentage: ${controller.openWeatherModel.humidityInPercentage}%',
            ),

            const SizedBox(width: 30),

          ],
        ),
      ),
    );
  }
}
