import '../entities/location_entity.dart';

abstract class LocationRepository {
  Future<List<LocationEntity>> searchLocation(String query);
}
