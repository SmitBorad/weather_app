// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get locationPermissionNeeded => 'Location permission needed';

  @override
  String get locationServiceNeeded => 'Location service needed';

  @override
  String get locationPermissionNeededDis =>
      'Please enable location permission to get more accurate weather information.';

  @override
  String get allowLocation => 'Allow location';

  @override
  String get enableLocation => 'Enable location';

  @override
  String get discoverTheWeather => 'Discover the weather';

  @override
  String get wind => 'Wind';

  @override
  String get weatherNow => 'Weather now';

  @override
  String get search => 'Search';

  @override
  String get locationPermissionPermanentlyDenied =>
      'Location permission permanently denied.';

  @override
  String get locationPermissionDenied => 'Location permission denied.';

  @override
  String get locationServicesDisabled => 'Location service is disable.';

  @override
  String get openSettings => 'Open Settings';

  @override
  String get upcoming => 'Upcoming';

  @override
  String get noResultsFound => 'No result found';

  @override
  String get currentLocation => 'Current location';

  @override
  String get currentWeather => 'Current Weather';

  @override
  String get startTypingToSearch => 'Start typing to search';

  @override
  String get searchLocation => 'Search location';

  @override
  String get temperature => 'Temperature:';

  @override
  String get temperatureChart => 'Temperature Chart';

  @override
  String get weatherApp => 'Weather App';

  @override
  String get failedToSearchLocation => 'Failed to search location';

  @override
  String get locationNotAvailable => 'Location not available.';

  @override
  String get showTemperatureLayer => 'Show Temperature Layer';

  @override
  String get showPrecipitationLayer => 'Show Precipitation Layer';

  @override
  String get retry => 'Retry';

  @override
  String get humidity => 'Humidity:';

  @override
  String windSpeed(Object name) {
    return 'Wind Speed: $name/kmph';
  }

  @override
  String celsius(Object name) {
    return '$name°C';
  }

  @override
  String percentage(Object name) {
    return '$name%';
  }
}
