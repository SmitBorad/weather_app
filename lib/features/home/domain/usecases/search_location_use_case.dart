import '../entities/location_entity.dart';
import '../repositories/search_location.dart';

class SearchLocationUseCase {
  final LocationRepository repository;

  SearchLocationUseCase(this.repository);

  Future<List<LocationEntity>> call(String query) {
    return repository.searchLocation(query);
  }
}
