import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/features/home/domain/usecases/search_location_use_case.dart';

import '../../features/home/data/datasources/location_remote_data_source.dart';
import '../../features/home/data/datasources/weather_remote_data_source.dart';
import '../../features/home/data/repositories/location_repository_impl.dart';
import '../../features/home/data/repositories/weather_repository_impl.dart';
import '../../features/home/domain/repositories/search_location.dart';
import '../../features/home/domain/repositories/weather_repository.dart';
import '../../features/home/domain/usecases/get_weather_forecast.dart';
import '../../features/home/presentation/cubit/home_weather/weather_cubit.dart';
import '../../features/home/presentation/cubit/location_permission/location_cubit.dart';
import '../../features/home/presentation/cubit/search_location/location_search_cubit.dart';

final getIt = GetIt.instance;

void init() {
  // Register Dio
  getIt.registerLazySingleton<Dio>(() => Dio());

  // Register Data Sources
  getIt.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(getIt<Dio>()),
  );
  getIt.registerLazySingleton<LocationRemoteDataSource>(
    () => LocationRemoteDataSource(getIt<Dio>()),
  );

  // Register Repositories
  getIt.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(getIt<WeatherRemoteDataSource>()),
  );
  getIt.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(getIt<LocationRemoteDataSource>()),
  );

  // Register Use Cases
  getIt.registerLazySingleton<GetWeatherForecast>(
    () => GetWeatherForecast(getIt<WeatherRepository>()),
  );
  getIt.registerLazySingleton<SearchLocationUseCase>(
    () => SearchLocationUseCase(getIt<LocationRepository>()),
  );

  // Register Cubits / Blocs
  getIt.registerFactory<WeatherCubit>(
    () => WeatherCubit(getIt<GetWeatherForecast>()),
  );

  getIt.registerFactory(
    () => LocationSearchCubit(getIt<SearchLocationUseCase>()),
  );
  getIt.registerFactory(() => LocationCubit());
}
