import '../../domain/entities/weather.dart';

class WeatherModel extends Weather {
  WeatherModel({
    required String date,
    required super.temperature,
    required super.humidity,
    required super.pressure,
    required super.windSpeed,
    required super.icon,
  }) : super(dateTime: date);

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      date: json['dt_txt'],
      icon: json['weather'][0]['icon'],

      humidity: (json['main']['humidity'] as num).toDouble(),
      pressure: (json['main']['pressure'] as num).toDouble(),
      windSpeed: (json['wind']['speed'] as num).toDouble() * 3.6,
      temperature: ((json['main']['temp'] as num).toDouble()),
    );
  }
}
