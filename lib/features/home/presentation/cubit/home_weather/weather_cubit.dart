import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/features/home/presentation/cubit/home_weather/weather_state.dart';

import '../../../domain/entities/weather.dart';
import '../../../domain/usecases/get_weather_forecast.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final GetWeatherForecast getWeatherForecast;

  WeatherCubit(this.getWeatherForecast) : super(WeatherInitial());

  Weather? currentWeather;
  Future<void> fetchWeather(double lat, double lon) async {
    try {
      emit(WeatherLoading());
      final List<Weather> weatherList = await getWeatherForecast(lat, lon);

      currentWeather = weatherList.first;
      final forecast = weatherList.skip(1).take(4).toList();
      emit(WeatherLoaded(weatherList.first, forecast));
    } catch (e) {
      emit(WeatherError('Failed to fetch weather: $e'));
    }
  }

  LatLng? currentPosition;
  String? currentCity;
  void setCurrentLocation(double lat, double lng, String? city) {
    currentPosition = LatLng(lat, lng);
    currentCity = city ?? '--';

    if (currentPosition != null) {
      fetchWeather(currentPosition!.latitude, currentPosition!.longitude);
    } else {
      emit(WeatherError('Failed to fetch weather'));
    }
  }

  Future<void> retryHomeData() async {
    try {
      fetchWeather(currentPosition!.latitude, currentPosition!.longitude);
    } catch (e) {
      emit(WeatherError('Failed to fetch weather: $e'));
    }
  }
}
