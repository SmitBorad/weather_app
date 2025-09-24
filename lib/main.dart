import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/theme/app_theme.dart';
import 'package:weather_app/l10n/app_localizations.dart';
import 'core/injection/injection.dart';
import 'core/router/app_router.dart';
import 'features/home/presentation/cubit/location_permission/location_cubit.dart';
import 'features/home/presentation/cubit/search_location/location_search_cubit.dart';
import 'features/home/presentation/cubit/home_weather/weather_cubit.dart';

void main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      init();
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      runApp(const MyApp());
    },
    (error, stackTrace) {
      debugPrint('Uncaught error: $error');
      debugPrint('$stackTrace');
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<WeatherCubit>()),
        BlocProvider(create: (_) => getIt<LocationSearchCubit>()),
        BlocProvider(create: (_) => getIt<LocationCubit>()),
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
