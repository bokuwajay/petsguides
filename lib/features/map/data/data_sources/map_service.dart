import 'package:http/http.dart' as http;
import 'package:petsguides/features/map/data/models/auto_complete_model.dart';
import 'dart:convert' as convert;

class MapService {
  final String key = 'AIzaSyDvM7vtrGRyn3Ie3Fcpf0EJJ_8dN4WA4e8';
  final String types = 'geocode';

  Future<List<AutoCompleteModel>> searchPlaces(String searchInput) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchInput&types=$types&key=$key';

    var response = await http.get(Uri.parse(url));

    var json = convert.jsonDecode(response.body);

    var results = json['predictions'] as List;

    return results.map((e) => AutoCompleteModel.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>> getPlace(String? placeId) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';

    var response = await http.get(Uri.parse(url));

    var json = convert.jsonDecode(response.body);

    var results = json['result'] as Map<String, dynamic>;

    return results;
  }
}
