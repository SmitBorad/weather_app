import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String dateTime;
  final double temperature;
  final double pressure;
  final double humidity;
  final double windSpeed;
  final String icon;

  const Weather({
    required this.dateTime,
    required this.temperature,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
    required this.icon,
  });

  @override
  List<Object?> get props => [
    dateTime,
    temperature,
    pressure,
    humidity,
    windSpeed,
    icon,
  ];
}
