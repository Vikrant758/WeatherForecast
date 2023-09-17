import 'package:flutter_weather_application/services/open_weather_service/open_weather_endpoints.dart';

class OpenWeatherModel {
  String placeName = '';
  String weatherInfo = '';
  String weatherIconUrl = 'https://openweathermap.org/img/wn/';

  num temperatureInCelsius = 0;
  num minimumTemperatureInCelsius = 0;
  num maximumTemperatureInCelsius = 0;
  num humidityInPercentage = 0;

  bool showForecast = true;

  fromJson(Map data) {
    if (data.containsKey('cod') && data['cod'] == OpenWeatherEndpoints.successStatusCode) {
      showForecast = true;
      placeName = data['name'];
      weatherInfo = '${data['weather']['main']}, ${data['weather']['description']}';
      weatherIconUrl = '$weatherIconUrl${data['weather']['icon']}.png';

      temperatureInCelsius = convertKelvinToCelsius(data['main']['temp']);
      minimumTemperatureInCelsius = convertKelvinToCelsius(data['main']['temp_min']);
      maximumTemperatureInCelsius = convertKelvinToCelsius(data['main']['temp_max']);
      humidityInPercentage = data['main']['humidity'];
    } else {
      showForecast = false;
    }
  }

  convertKelvinToCelsius(num kelvinValue) {
    return kelvinValue - 273.15;
  }


}