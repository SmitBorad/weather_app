import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  final String name;
  final double latitude;
  final double longitude;
  final String city;

  const LocationEntity({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.city,
  });

  @override
  List<Object?> get props => [name, latitude, longitude, city];
}
