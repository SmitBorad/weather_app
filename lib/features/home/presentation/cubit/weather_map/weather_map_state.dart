import 'package:equatable/equatable.dart';

class WeatherMapState extends Equatable {
  final bool isLoading;
  final bool permissionDenied;
  final bool serviceDisabled;
  final double? latitude;
  final double? longitude;
  final String? errorMessage;
  final bool showPrecipitation;

  const WeatherMapState({
    required this.isLoading,
    this.permissionDenied = false,
    this.serviceDisabled = false,
    this.latitude,
    this.longitude,
    this.errorMessage,
    this.showPrecipitation = false,
  });

  factory WeatherMapState.initial() {
    return const WeatherMapState(isLoading: true);
  }

  WeatherMapState copyWith({
    bool? isLoading,
    bool? permissionDenied,
    bool? serviceDisabled,
    double? latitude,
    double? longitude,
    String? errorMessage,
    bool? showWeatherOverlay,
  }) {
    return WeatherMapState(
      isLoading: isLoading ?? this.isLoading,
      permissionDenied: permissionDenied ?? this.permissionDenied,
      serviceDisabled: serviceDisabled ?? this.serviceDisabled,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      errorMessage: errorMessage ?? this.errorMessage,
      showPrecipitation: showWeatherOverlay ?? this.showPrecipitation,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    permissionDenied,
    serviceDisabled,
    latitude,
    longitude,
    errorMessage,
    showPrecipitation,
  ];
}
