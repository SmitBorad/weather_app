import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/theme/app_theme.dart';
import 'package:weather_app/features/home/data/datasources/weather_remote_data_source.dart';
import 'package:weather_app/features/home/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/features/home/domain/usecases/get_weather_forecast.dart';
import 'package:weather_app/features/home/presentation/bloc/weather_cubit.dart';
import 'package:weather_app/features/home/presentation/pages/location_permission_page.dart';
import 'package:weather_app/l10n/app_localizations.dart';

import 'features/home/data/datasources/location_remote_data_source.dart';
import 'features/home/data/repositories/location_repository_impl.dart';
import 'features/home/domain/usecases/search_location_use_case.dart';
import 'features/home/presentation/bloc/location_search_cubit.dart';
import 'features/splash/presentation/page/splash_page.dart';

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

  runApp(MyApp(weatherCubit: weatherCubit,locationSearchCubit: locationSearchCubit,));
}

class MyApp extends StatelessWidget {
  final WeatherCubit weatherCubit;
  final LocationSearchCubit locationSearchCubit;

  const MyApp({super.key, required this.weatherCubit, required this.locationSearchCubit});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [

      BlocProvider<WeatherCubit>.value(value: weatherCubit),
      BlocProvider<LocationSearchCubit>.value(value: locationSearchCubit),

    ],
      child: MaterialApp(
        title: 'Weather App',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        themeMode: ThemeMode.light,
        theme: AppTheme.lightTheme,
        home: const SplashPage(),
      ),
    );
  }
}
