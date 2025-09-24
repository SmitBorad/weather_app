import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

class GetWeatherForecast {
  final WeatherRepository repository;

  GetWeatherForecast(this.repository);

  Future<List<Weather>> call(double lat, double lon) {
    return repository.getWeatherForecast(lat, lon);
  }
}
