import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/usecases/search_location_use_case.dart';

part 'location_search_state.dart';

class LocationSearchCubit extends Cubit<LocationSearchState> {
  final SearchLocationUseCase searchLocationUseCase;

  LocationSearchCubit(this.searchLocationUseCase) : super(LocationSearchInitial());

  void search(String query) async {
    emit(LocationSearchLoading());

    try {
      final results = await searchLocationUseCase(query);
      emit(LocationSearchLoaded(results));
    } catch (e) {
      emit(LocationSearchError('Failed to search location'));
    }
  }
}
