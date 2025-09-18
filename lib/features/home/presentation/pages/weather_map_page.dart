import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/core/constant/app_config.dart';

import '../cubit/weather_cubit.dart';

class WeatherMapPage extends StatelessWidget {
  const WeatherMapPage({super.key});

  static const String routeName = '/map';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: LatLng(0, 0), zoom: 5),
        onTap: (latLng) => context.read<WeatherCubit>().setCurrentLocation(
          latLng.latitude,
          latLng.longitude,
          'h',
        ),
        tileOverlays: {
          TileOverlay(
            tileOverlayId: TileOverlayId('precipitation'),
            tileProvider: UrlTileProvider(
              urlTemplate:
                  "https://tile.openweathermap.org/map/precipitation_new/{z}/{x}/{y}.png?appid=${AppConfig.apiKey}",
            ),
          ),
          TileOverlay(
            tileOverlayId: TileOverlayId('temperature'),
            tileProvider: UrlTileProvider(
              urlTemplate:
                  "https://tile.openweathermap.org/map/temp_new/{z}/{x}/{y}.png?appid=${AppConfig.apiKey}",
            ),
          ),
        },
      ),
    );
  }
}

class UrlTileProvider implements TileProvider {
  final String urlTemplate;

  UrlTileProvider({required this.urlTemplate});

  @override
  Future<Tile> getTile(int x, int y, int? zoom) async {
    final url = urlTemplate
        .replaceAll('{x}', x.toString())
        .replaceAll('{y}', y.toString())
        .replaceAll('{z}', zoom.toString());

    final response = await NetworkAssetBundle(Uri.parse(url)).load("");
    final bytes = response.buffer.asUint8List();

    return Tile(256, 256, bytes);
  }
}
