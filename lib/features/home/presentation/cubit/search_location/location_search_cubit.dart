import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../domain/usecases/search_location_use_case.dart';
import 'location_search_state.dart';

class LocationSearchCubit extends Cubit<LocationSearchState> {
  final SearchLocationUseCase searchLocationUseCase;

  LocationSearchCubit(this.searchLocationUseCase)
    : super(const LocationSearchInitial());

  void search(String query, AppLocalizations appStrings) async {
    emit(const LocationSearchLoading());

    try {
      final results = await searchLocationUseCase(query);
      emit(LocationSearchLoaded(results));
    } catch (e) {
      emit(LocationSearchError(appStrings.failedToSearchLocation));
    }
  }
}
