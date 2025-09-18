import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app/features/home/presentation/cubit/weather_cubit.dart';
import 'location_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../home/presentation/pages/home_page.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationState.initial());

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

  Future<void> _fetchLocation(BuildContext context) async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(state.copyWith(isServiceDisabled: true, isLoading: false));
      return;
    }

    try {
      final position = await Geolocator.getCurrentPosition();
      final city = await _getCityFromPosition(position);
      var weatherCubit = context.read<WeatherCubit>();
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
      emit(
        state.copyWith(
          isError: true,
          errorMessage: 'Failed to fetch location: $e',
          isLoading: false,
        ),
      );
    }
  }

  Future<void> enableLocation(BuildContext context) async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.requestPermission();
      await _fetchLocation(context);
    }
  }

  Future<String?> _getCityFromPosition(Position position) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        return placemarks.first.locality;
      }
    } catch (_) {}
    return null;
  }
}
