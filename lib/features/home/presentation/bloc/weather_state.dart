part of 'weather_cubit.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather currentWeather;
  final List<Weather> forecast;

  WeatherLoaded(this.currentWeather, this.forecast);
}

class WeatherError extends WeatherState {
  final String message;

  WeatherError(this.message);
}

class CurrentLocation extends WeatherState {
  final Position current;
  CurrentLocation(this.current);
}
