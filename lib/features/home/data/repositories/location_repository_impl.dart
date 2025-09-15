import '../../domain/entities/location_entity.dart';
import '../../domain/repositories/search_location.dart';
import '../datasources/location_remote_data_source.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDataSource remoteDataSource;

  LocationRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<LocationEntity>> searchLocation(String query) {
    return remoteDataSource.searchLocation(query);
  }
}
