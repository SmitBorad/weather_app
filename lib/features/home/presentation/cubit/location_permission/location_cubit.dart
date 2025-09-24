import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app/features/home/presentation/cubit/home_weather/weather_cubit.dart';
import '../../../../../core/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../pages/home_page.dart';
import 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationState.initial());

  LocationService locationService = LocationService();

  /// Handles permission check and acts accordingly on splash or similar start
  Future<void> onSplash(BuildContext context) async {
    await _handlePermission(context);
  }

  /// Requests location permission and fetches location if granted
  Future<void> requestLocation(BuildContext context) async {
    emit(
      state.copyWith(
        isLoading: true,
        isInitial: false,
        isGranted: false,
        isDenied: false,
        isPermanentlyDenied: false,
        isError: false,
      ),
    );

    final status = await Permission.location.status;

    if (status.isGranted) {
      await _fetchLocation(context);
    } else if (status.isDenied) {
      final result = await Permission.location.request();
      if (result.isGranted) {
        await _fetchLocation(context);
      } else if (result.isPermanentlyDenied) {
        emit(state.copyWith(isPermanentlyDenied: true, isLoading: false));
      } else {
        emit(state.copyWith(isDenied: true, isLoading: false));
      }
    } else if (status.isPermanentlyDenied) {
      emit(state.copyWith(isPermanentlyDenied: true, isLoading: false));
    }
  }

  /// Private helper to DRY permission check logic used in onSplash
  Future<void> _handlePermission(BuildContext context) async {
    emit(
      state.copyWith(
        isLoading: true,
        isInitial: false,
        isGranted: false,
        isDenied: false,
        isPermanentlyDenied: false,
        isError: false,
      ),
    );

    final status = await Permission.location.status;

    if (status.isGranted) {
      await _fetchLocation(context);
    } else if (status.isDenied || status.isRestricted) {
      emit(state.copyWith(isLoading: false, isDenied: true));
    } else if (status.isPermanentlyDenied) {
      emit(state.copyWith(isLoading: false, isPermanentlyDenied: true));
    }
  }

  /// Fetches location and updates WeatherCubit and state accordingly
  Future<void> _fetchLocation(BuildContext context) async {
    final serviceEnabled = await locationService.isLocationEnabled();
    if (!serviceEnabled) {
      emit(state.copyWith(isServiceDisabled: true, isLoading: false));
      return;
    }

    try {
      final position = await locationService.getCurrentPosition();
      final city = await locationService.getCityFromPosition(position);
      final weatherCubit = context.read<WeatherCubit>();
      weatherCubit.setCurrentLocation(
        position.latitude,
        position.longitude,
        city ?? '--',
      );

      emit(state.copyWith(isGranted: true, isFetched: true, isLoading: false));

      if (context.mounted) {
        context.goNamed(HomePage.routeName);
      }
    } catch (e) {
      // Log error here if needed
      emit(
        state.copyWith(
          isError: true,
          errorMessage: 'Failed to fetch location: $e',
          isLoading: false,
        ),
      );
    }
  }

  /// Opens location settings and fetches location again
  Future<void> enableLocation(BuildContext context) async {
    final serviceEnabled = await locationService.isLocationEnabled();
    if (!serviceEnabled) {
      await locationService.openLocationSettings();
      await _fetchLocation(context);
    } else {
      await _fetchLocation(context);
    }
  }
}
