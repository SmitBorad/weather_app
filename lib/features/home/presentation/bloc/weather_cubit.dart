import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../domain/entities/weather.dart';
import '../../domain/usecases/get_weather_forecast.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final GetWeatherForecast getWeatherForecast;

  WeatherCubit(this.getWeatherForecast) : super(WeatherInitial());

  Future<void> fetchWeather(double lat, double lon) async {
    try {
      emit(WeatherLoading());
      final List<Weather> weatherList = await getWeatherForecast(lat, lon);

      final currentWeather = weatherList.first;
      final forecast = weatherList.skip(1).take(4).toList();
      emit(WeatherLoaded(currentWeather, forecast));
    } catch (e) {
      emit(WeatherError('Failed to fetch weather: $e'));
    }
  }

  LatLng? currentPosition;
  String? city;
  void setCurrentLocation(double lat,double lng, String? city) {
    currentPosition = LatLng(lat, lng);
    city = city ?? '--';

    if (currentPosition != null) {
      fetchWeather(currentPosition!.latitude, currentPosition!.longitude);
    } else {
      emit(WeatherError('Failed to fetch weather'));
    }
  }
}
