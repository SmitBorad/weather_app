import 'package:dio/dio.dart';
import 'package:weather_app/core/constant/app_config.dart';
import 'package:weather_app/features/home/domain/entities/location_entity.dart';
import 'dart:developer';

class LocationRemoteDataSource {
  final Dio dio;

  LocationRemoteDataSource(this.dio);

  Future<List<LocationEntity>> searchLocation(String query) async {
    if (query.trim().isEmpty) {
      // Optionally return empty or error
      throw Exception('Query is empty');
    }

    try {
      final autocompleteResponse = await dio.get(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json',
        queryParameters: {
          'input': query,
          'types': 'geocode',
          'key': AppConfig.googlwMapKey,
        },
      );

      log('Autocomplete status code: ${autocompleteResponse.statusCode}');
      log('Autocomplete response data: ${autocompleteResponse.data}');

      final data = autocompleteResponse.data;
      final String status = data['status'];

      if (status != 'OK') {
        // Handle non-OK statuses
        final errorMessage = data['error_message'] ?? 'Unknown error';
        throw Exception('Autocomplete API error: $status, $errorMessage');
      }

      List predictions = data['predictions'];

      final results = await Future.wait(predictions.map((prediction) async {
        final placeId = prediction['place_id'];
        if (placeId == null || placeId.isEmpty) {
          throw Exception('Missing place_id in prediction');
        }

        final detailsResponse = await dio.get(
          'https://maps.googleapis.com/maps/api/place/details/json',
          queryParameters: {
            'place_id': placeId,
            'key': AppConfig.googlwMapKey,
          },
        );

        log('DetailsResponse data for $placeId: ${detailsResponse.data}');

        final detailsData = detailsResponse.data;

        final detailsStatus = detailsData['status'];
        if (detailsStatus != 'OK') {
          final err = detailsData['error_message'] ?? 'Unknown';
          throw Exception('Place Details API error: $detailsStatus, $err');
        }

        final location = detailsData['result']['geometry']['location'];
        final addressComponents = detailsData['result']['address_components'];

        double lat = (location['lat'] as num).toDouble();
        double lng = (location['lng'] as num).toDouble();

        String city = '';
        for (var component in addressComponents) {
          final types = component['types'] as List;
          if (types.contains('locality')) {
            city = component['long_name'];
            break;
          }
          // fallback options
          if (types.contains('administrative_area_level_2') && city.isEmpty) {
            city = component['long_name'];
          }
        }
        if (city.isEmpty) {
          city = prediction['description']; // fallback
        }

        return LocationEntity(
          name: prediction['description'],
          latitude: lat,
          longitude: lng,
          city: city,
        );
      }).toList());

      return results;
    } on DioError catch (e) {
      log('Dio error: ${e.response?.data} ${e.message}');
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      log('Unexpected error: $e');
      throw Exception('Unexpected error: $e');
    }
  }
}
