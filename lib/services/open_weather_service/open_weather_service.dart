import 'package:dio/dio.dart';

import 'logger_interceptor.dart';
import 'open_weather_endpoints.dart';

class OpenWeatherService {
  late final Dio _dio;

  OpenWeatherService()
      : _dio = Dio(
          BaseOptions(
            baseUrl: OpenWeatherEndpoints.baseURL,
            connectTimeout:
                const Duration(seconds: OpenWeatherEndpoints.connectionTimeout),
            receiveTimeout:
                const Duration(seconds: OpenWeatherEndpoints.receiveTimeout),
            sendTimeout:
                const Duration(seconds: OpenWeatherEndpoints.sendTimeout),
            responseType: ResponseType.json,
          ),
        )..interceptors.addAll([
            LoggerInterceptor(),
          ]);

  Future<dynamic> getCurrentWeatherInformation(
      {required String lat,
      required String long,
      required String appId}) async {
    try {
      Response<dynamic> currentWeatherInfo = await _dio.get(
        '${OpenWeatherEndpoints.getCurrentWeatherData}?lat=$lat&lon=$long&appid=$appId',
      );
      if (currentWeatherInfo.statusCode == 200) {
        return {'data': currentWeatherInfo.data, 'status': true};
      }
      return {'status': false};
    } on DioException catch (e) {
      print(e);
      return {'status': false};
    } catch (e) {
      print(e);
      return {'status': false};
    }
  }
}
