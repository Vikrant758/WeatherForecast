import 'package:flutter_weather_application/services/open_weather_service/open_weather_endpoints.dart';

class OpenWeatherModel {
  String placeName = '';
  String weatherInfo = '';
  String weatherIconUrl = '';
  String openWeatherIconUrl = 'https://openweathermap.org/img/wn/';

  num temperatureInCelsius = 0;
  num minimumTemperatureInCelsius = 0;
  num maximumTemperatureInCelsius = 0;
  num temperatureFeelsLike = 0;
  num humidityInPercentage = 0;

  bool showForecast = true;

  fromJson(Map data) {
    if (data.containsKey('cod') && data['cod'] == OpenWeatherEndpoints.successStatusCode) {
      showForecast = true;
      placeName = data['name'];
      weatherInfo = '${data['weather'][0]['main']}, ${data['weather'][0]['description']}';
      weatherIconUrl = '$openWeatherIconUrl${data['weather'][0]['icon']}.png';

      temperatureInCelsius = convertKelvinToCelsius(data['main']['temp']);
      minimumTemperatureInCelsius = convertKelvinToCelsius(data['main']['temp_min']);
      maximumTemperatureInCelsius = convertKelvinToCelsius(data['main']['temp_max']);
      temperatureFeelsLike = convertKelvinToCelsius(data['main']['feels_like']);
      humidityInPercentage = data['main']['humidity'];
    } else {
      showForecast = false;
    }
  }

  convertKelvinToCelsius(num kelvinValue) {
    return (kelvinValue - 273.15).round();
  }


}