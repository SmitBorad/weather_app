import 'package:flutter_bloc/flutter_bloc.dart';
import 'weather_map_state.dart';

class WeatherMapCubit extends Cubit<WeatherMapState> {
  WeatherMapCubit() : super(WeatherMapState.initial());

  /// Use lat/lon from WeatherCubit to initialize the map
  void initializeFromPosition({
    required double latitude,
    required double longitude,
  }) {
    emit(
      state.copyWith(
        isLoading: false,
        latitude: latitude,
        longitude: longitude,
      ),
    );
  }

  /// Toggle weather overlay on/off
  void toggleOverlay() {
    emit(state.copyWith(showWeatherOverlay: !state.showPrecipitation));
  }
}
