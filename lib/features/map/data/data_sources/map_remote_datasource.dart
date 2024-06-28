import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:petsguides/core/api/api_helper.dart';
import 'package:petsguides/core/constants/error_message.dart';
import 'package:petsguides/core/error/exceptions.dart';
import 'package:petsguides/core/util/logger.dart';
import 'package:petsguides/features/map/data/models/auto_complete_model.dart';
import 'package:petsguides/features/map/domain/usecases/usecase_params.dart';

sealed class MapRemoteDataSource {
  Future<List<AutoCompleteModel>> searchPlaces(SearchPlacesParams params);
}

class MapRemoteDataSourceImpl implements MapRemoteDataSource {
  final ApiHelper apiHelper;
  MapRemoteDataSourceImpl(this.apiHelper);

  final String types = 'geocode';

  @override
  Future<List<AutoCompleteModel>> searchPlaces(
      SearchPlacesParams params) async {
    try {
      final response = await apiHelper.execute(
        method: Method.get,
        baseUrl: dotenv.env['googleMapBaseUrl'],
        endpoint:
            '/place/autocomplete/json?input=${params.searchInput}&types=$types&key=${dotenv.env['googleMapKey']}',
      );

      var result = response['predictions'] as List;

      return result.map((e) => AutoCompleteModel.fromJson(e)).toList();
    } catch (exception) {
      logger.e(exception);
      if (exception.toString() == noElement) {
        throw AuthException();
      }
      throw ServerException();
    }
  }
}
