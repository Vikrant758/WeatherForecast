class OpenWeatherEndpoints {
  static const String baseURL = 'https://api.openweathermap.org/data/2.5/';

  static const int sendTimeout = 20;

  static const int receiveTimeout = 20;

  static const int connectionTimeout = 20;

  static const int successStatusCode = 200;

  static const int created = 201;

  static const int forbiddenStatusCode = 403;

  static const int unAuthorizedStatusCode = 401;

  static const int notFoundStatusCode = 404;

  static const String getCurrentWeatherData = 'weather';
}