import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/core/constant/app_extentions.dart';
import 'package:weather_app/core/utils/custom_text.dart';

import '../../../../core/constant/app_config.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/url_tile_provider.dart';
import '../../../../l10n/app_localizations.dart';
import '../cubit/home_weather/weather_cubit.dart';
import '../cubit/weather_map/weather_map_cubit.dart';
import '../cubit/weather_map/weather_map_state.dart';

class WeatherMapPage extends StatefulWidget {
  static const String routeName = 'weather-map';

  const WeatherMapPage({Key? key}) : super(key: key);

  @override
  State<WeatherMapPage> createState() => _WeatherMapPageState();
}

class _WeatherMapPageState extends State<WeatherMapPage> {
  late GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    final weatherState = context.watch<WeatherCubit>();

    final appStrings = AppLocalizations.of(context)!;
    final appColors = AppColors.of(context);
    final appStyles = AppStyles.of(context);
    return BlocProvider(
      create: (_) => WeatherMapCubit()
        ..initializeFromPosition(
          latitude: weatherState.currentPosition?.latitude ?? 0,
          longitude: weatherState.currentPosition?.longitude ?? 0,
        ),
      child: Scaffold(
        appBar: AppBar(
          title: SingleLineText(
            appStrings.weatherApp,
            style: appStyles.s18w500black,
          ),
        ),
        body: BlocBuilder<WeatherMapCubit, WeatherMapState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.latitude == null || state.longitude == null) {
              return Center(
                child: SingleLineText(
                  appStrings.locationNotAvailable,
                  style: appStyles.s16w400Grey,
                ),
              );
            }

            final LatLng position = LatLng(state.latitude!, state.longitude!);

            final weatherOverlay = state.showPrecipitation
                ? {
                    TileOverlay(
                      tileOverlayId: TileOverlayId('precipitation'),
                      tileProvider: UrlTileProvider(
                        urlTemplate:
                            "https://tile.openweathermap.org/map/precipitation_new/{z}/{x}/{y}.png?appid=${AppConfig.apiKey}",
                      ),
                    ),
                  }
                : {
                    TileOverlay(
                      tileOverlayId: TileOverlayId('temperature'),
                      tileProvider: UrlTileProvider(
                        urlTemplate:
                            "https://tile.openweathermap.org/map/temp_new/{z}/{x}/{y}.png?appid=${AppConfig.apiKey}",
                      ),
                    ),
                  };

            return Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: position,
                    zoom: 14,
                  ),
                  zoomControlsEnabled: false,
                  myLocationEnabled: true,
                  onMapCreated: (controller) {
                    _mapController = controller;
                  },
                  markers: {
                    Marker(
                      markerId: const MarkerId('current_location'),
                      position: position,
                      onTap: () => _onMarkerTapped(
                        context,
                        state.latitude!,
                        state.longitude!,
                        appStrings,
                        appStyles,
                      ),
                    ),
                  },
                  tileOverlays: weatherOverlay,
                ),

                // BOTTOM TOGGLE BUTTON
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      context.read<WeatherMapCubit>().toggleOverlay();
                    },
                    icon: Icon(
                      state.showPrecipitation
                          ? Icons.local_fire_department_rounded
                          : Icons.water_drop_rounded,
                    ),
                    label: Text(
                      state.showPrecipitation
                          ? appStrings.showTemperatureLayer
                          : appStrings.showPrecipitationLayer,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  /// Show bottom sheet with weather data for tapped location
  Future<void> _onMarkerTapped(
    BuildContext context,
    double lat,
    double lon,
    AppLocalizations appStrings,
    AppStyles appStyles,
  ) async {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SingleLineText(
                appStrings.currentWeather,
                style: appStyles.s18w500black,
              ),
              12.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SingleLineText(
                    appStrings.temperature,
                    style: appStyles.s18w500black,
                  ),
                  SingleLineText(
                    appStrings.celsius(
                      context
                              .read<WeatherCubit>()
                              .currentWeather
                              ?.temperature ??
                          '--',
                    ),
                    style: appStyles.s18w500black,
                  ),
                ],
              ),
              8.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SingleLineText(
                    appStrings.humidity,
                    style: appStyles.s18w500black,
                  ),
                  SingleLineText(
                    appStrings.percentage(
                      context.read<WeatherCubit>().currentWeather?.humidity ??
                          '--',
                    ),
                    style: appStyles.s18w500black,
                  ),
                ],
              ),

              8.heightBox,
            ],
          ),
        );
      },
    );
  }
}
