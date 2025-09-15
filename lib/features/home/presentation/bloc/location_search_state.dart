part of 'location_search_cubit.dart';

abstract class LocationSearchState {}

class LocationSearchInitial extends LocationSearchState {}

class LocationSearchLoading extends LocationSearchState {}

class LocationSearchLoaded extends LocationSearchState {
  final List<LocationEntity> locations;
  LocationSearchLoaded(this.locations);
}

class LocationSearchError extends LocationSearchState {
  final String message;
  LocationSearchError(this.message);
}
