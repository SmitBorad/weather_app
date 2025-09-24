import 'package:go_router/go_router.dart';
import 'package:weather_app/features/home/presentation/pages/location_search_page.dart';
import 'package:weather_app/features/home/presentation/pages/weather_map_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/pages/location_permission_page.dart';
import '../../features/splash/presentation/page/splash_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: SplashPage.routeName,
    routes: [
      GoRoute(
        name: SplashPage.routeName,
        path: '/',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        name: LocationPermissionPage.routeName,
        path: '/location-permission',
        builder: (context, state) => const LocationPermissionPage(),
      ),
      GoRoute(
        name: HomePage.routeName,
        path: '/home',
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            name: LocationSearchPage.routeName,
            path: 'location-search',
            builder: (context, state) => LocationSearchPage(),
          ),
          GoRoute(
            name: WeatherMapPage.routeName,
            path: 'weather-map',
            builder: (context, state) => WeatherMapPage(),
          ),
        ],
      ),
    ],
  );
}
