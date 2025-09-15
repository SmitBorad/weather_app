import 'package:dio/dio.dart';
import 'package:weather_app/core/constant/app_config.dart';

import '../models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<List<WeatherModel>> getWeatherForecast(double lat, double lon);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final Dio dio;

  WeatherRemoteDataSourceImpl(this.dio);

  @override
  Future<List<WeatherModel>> getWeatherForecast(double lat, double lon) async {
    print('Calling API with lat: $lat, lon: $lon');

    final response = await dio.get(
      AppConfig.getWeather,
      queryParameters: {'lat': lat, 'lon': lon, 'appid': AppConfig.apiKey, 'units': 'metric'},
    );

    final List list = response.data['list'];

    // Get weather every 24 hours (8 intervals of 3-hour forecast)
    final daily = list.where((item) => item['dt_txt'].contains('12:00:00')).take(5).toList();

    return daily.map((item) => WeatherModel.fromJson(item)).toList();
  }
}
