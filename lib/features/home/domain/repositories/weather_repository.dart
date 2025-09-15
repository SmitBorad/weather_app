import 'package:weather_app/features/home/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<List<Weather>> getWeatherForecast(double lat, double lon);
}