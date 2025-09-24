import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

import '../../../domain/entities/weather.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

class WeatherInitial extends WeatherState {
  const WeatherInitial();
}

class WeatherLoading extends WeatherState {
  const WeatherLoading();
}

class WeatherLoaded extends WeatherState {
  final Weather currentWeather;
  final List<Weather> forecast;

  const WeatherLoaded(this.currentWeather, this.forecast);

  @override
  List<Object?> get props => [currentWeather, forecast];
}

class WeatherError extends WeatherState {
  final String message;

  const WeatherError(this.message);

  @override
  List<Object?> get props => [message];
}

class CurrentLocation extends WeatherState {
  final Position current;

  const CurrentLocation(this.current);

  @override
  List<Object?> get props => [current];
}
