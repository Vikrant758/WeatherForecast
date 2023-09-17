import 'package:dio/dio.dart';

import 'logger_interceptor.dart';
import 'open_weather_endpoints.dart';

class OpenWeatherService {

  late final Dio _dio;

  OpenWeatherService()
      : _dio = Dio(
    BaseOptions(
      baseUrl: OpenWeatherEndpoints.baseURL,
      connectTimeout: const Duration(seconds: OpenWeatherEndpoints.connectionTimeout),
      receiveTimeout: const Duration(seconds: OpenWeatherEndpoints.receiveTimeout),
      sendTimeout: const Duration(seconds: OpenWeatherEndpoints.sendTimeout) ,
      responseType: ResponseType.json,
    ),
  )..interceptors.addAll([
    LoggerInterceptor(),
  ]);


  Future<dynamic> getCurrentWeatherInformation({required String lat, required String long, required String appId}) async {
    try {
      Map<String, dynamic> queryParams = {
        'lat': lat,
        'long': long,
        'appid': appId
      };
      Response<dynamic> getAllProjects =
      await _dio.get(OpenWeatherEndpoints.getCurrentWeatherData, queryParameters: queryParams);

      if (getAllProjects.statusCode == 200) {
        return {'data': getAllProjects.data};
      }
    } on DioException catch (e) {
      return {'data': e.response?.data, 'status': 400};
    } catch (e) {
      return {'data': e, 'status': 400};
    }
  }
}
