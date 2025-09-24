import 'package:weather_app/features/home/data/datasources/weather_remote_data_source.dart';

import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  WeatherRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Weather>> getWeatherForecast(double lat, double lon) async {
    return await remoteDataSource.getWeatherForecast(lat, lon);
  }
}
