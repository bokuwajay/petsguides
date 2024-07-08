import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:petsguides/core/api/api_helper.dart';
import 'package:petsguides/core/constants/error_message.dart';
import 'package:petsguides/core/error/exceptions.dart';
import 'package:petsguides/core/util/logger.dart';
import 'package:petsguides/features/map/data/models/auto_complete_model.dart';
import 'package:petsguides/features/map/domain/usecases/usecase_params.dart';

sealed class MapRemoteDataSource {
  Future<List<AutoCompleteModel>> searchPlaces(SearchPlacesParams params);
  Future<Map<String, dynamic>> selectFromSearchList(SelectFromSearchListParams params);
  Future<Map<String, dynamic>> getDirections(GetDirectionsParams params);
  Future<Map<String, dynamic>> searchInRadius(SearchInRadiusParams params);
  Future<Map<String, dynamic>> getMorePlacesInRadius(GetMorePlacesInRadiusParams params);
  Future<Map<String, dynamic>> tapOnCarouselCard(TapOnCarouselCardParams params);
}

class MapRemoteDataSourceImpl implements MapRemoteDataSource {
  final ApiHelper apiHelper;
  MapRemoteDataSourceImpl(this.apiHelper);

  final String types = 'geocode';

  @override
  Future<List<AutoCompleteModel>> searchPlaces(SearchPlacesParams params) async {
    try {
      final response = await apiHelper.execute(
        method: Method.get,
        baseUrl: dotenv.env['googleMapBaseUri'],
        endpoint: '/place/autocomplete/json?input=${params.searchInput}&type=$types&key=${dotenv.env['googleMapKey']}',
      );

      var result = response['predictions'] as List;

      return result.map((e) => AutoCompleteModel.fromJson(e)).toList();
    } catch (exception) {
      logger.e('Catch server exception in searchPlaces of MapRemoteDataSourceImpl: $exception');
      throw exception;
    }
  }

  @override
  Future<Map<String, dynamic>> selectFromSearchList(SelectFromSearchListParams params) async {
    try {
      final response = await apiHelper.execute(
        method: Method.get,
        baseUrl: dotenv.env['googleMapBaseUrl'],
        endpoint: '/place/details/json?place_id=${params.placeId}&key=${dotenv.env['googleMapKey']}',
      );
      var result = response['result'] as Map<String, dynamic>;

      return result;
    } catch (exception) {
      logger.e(exception);
      if (exception.toString() == noElement) {
        throw AuthException();
      }
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> getDirections(GetDirectionsParams params) async {
    try {
      final response = await apiHelper.execute(
        method: Method.get,
        baseUrl: dotenv.env['googleMapBaseUrl'],
        endpoint: '/directions/json?origin=${params.origin}&destination=${params.destination}&key=${dotenv.env['googleMapKey']}',
      );
      var result = {
        'bounds_ne': response['routes'][0]['bounds']['northeast'],
        'bounds_sw': response['routes'][0]['bounds']['southwest'],
        'start_location': response['routes'][0]['legs'][0]['start_location'],
        'end_location': response['routes'][0]['legs'][0]['end_location'],
        'polyline': response['routes'][0]['overview_polyline']['points'],
        'polyline_decoded': PolylinePoints().decodePolyline(response['routes'][0]['overview_polyline']['points'])
      };

      return result;
    } catch (exception) {
      logger.e(exception);
      if (exception.toString() == noElement) {
        throw AuthException();
      }
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> searchInRadius(SearchInRadiusParams params) async {
    try {
      final result = await apiHelper.execute(
        method: Method.get,
        baseUrl: dotenv.env['googleMapBaseUrl'],
        endpoint:
            '/place/nearbysearch/json?&location=${params.tappedPoint.latitude},${params.tappedPoint.longitude}&radius=${params.radius}&key=${dotenv.env['googleMapKey']}',
      );
      return result;
    } catch (exception) {
      logger.e(exception);
      if (exception.toString() == noElement) {
        throw AuthException();
      }
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> getMorePlacesInRadius(GetMorePlacesInRadiusParams params) async {
    try {
      final result = await apiHelper.execute(
        method: Method.get,
        baseUrl: dotenv.env['googleMapBaseUrl'],
        endpoint: '/place/nearbysearch/json?&pagetoken=${params.nextPageToken}&key=${dotenv.env['googleMapKey']}',
      );

      return result;
    } catch (exception) {
      logger.e(exception);
      if (exception.toString() == noElement) {
        throw AuthException();
      }
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> tapOnCarouselCard(TapOnCarouselCardParams params) async {
    try {
      final response = await apiHelper.execute(
        method: Method.get,
        baseUrl: dotenv.env['googleMapBaseUrl'],
        endpoint: '/place/details/json?place_id=${params.placeId}&key=${dotenv.env['googleMapKey']}',
      );
      var result = response['result'] as Map<String, dynamic>;

      return result;
    } catch (exception) {
      logger.e(exception);
      if (exception.toString() == noElement) {
        throw AuthException();
      }
      throw ServerException();
    }
  }
}
