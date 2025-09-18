import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/theme/app_theme.dart';
import 'package:weather_app/features/home/data/datasources/weather_remote_data_source.dart';
import 'package:weather_app/features/home/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/features/home/domain/usecases/get_weather_forecast.dart';
import 'package:weather_app/l10n/app_localizations.dart';
import 'core/router/app_router.dart';
import 'features/home/data/datasources/location_remote_data_source.dart';
import 'features/home/data/repositories/location_repository_impl.dart';
import 'features/home/domain/usecases/search_location_use_case.dart';
import 'features/home/presentation/cubit/location_cubit.dart';
import 'features/home/presentation/cubit/location_search_cubit.dart';
import 'features/home/presentation/cubit/weather_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final dio = Dio();
  final weatherDataSource = WeatherRemoteDataSourceImpl(dio);
  final weatherRepo = WeatherRepositoryImpl(weatherDataSource);
  final getWeatherUseCase = GetWeatherForecast(weatherRepo);
  final weatherCubit = WeatherCubit(getWeatherUseCase);

  final locationRemoteDataSource = LocationRemoteDataSource(dio);
  final locationRepository = LocationRepositoryImpl(locationRemoteDataSource);
  final searchLocationUseCase = SearchLocationUseCase(locationRepository);
  final locationSearchCubit = LocationSearchCubit(searchLocationUseCase);

  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // Lock orientation if needed
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      runApp(
        MyApp(
          weatherCubit: weatherCubit,
          locationSearchCubit: locationSearchCubit,
        ),
      );
    },
    (error, stackTrace) {
      debugPrint('Uncaught error: $error');
      debugPrint('$stackTrace');
    },
  );
}

class MyApp extends StatelessWidget {
  final WeatherCubit weatherCubit;
  final LocationSearchCubit locationSearchCubit;

  const MyApp({
    super.key,
    required this.weatherCubit,
    required this.locationSearchCubit,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherCubit>.value(value: weatherCubit),
        BlocProvider<LocationSearchCubit>.value(value: locationSearchCubit),
        BlocProvider(create: (_) => LocationCubit()),
      ],
      child: MaterialApp.router(
        title: 'Weather App',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        themeMode: ThemeMode.dark,
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
