import 'package:flutter_polyline_points/flutter_polyline_points.dart';
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

  Future<Map<String, dynamic>> getDirections(
      String origin, String destination) async {
    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&key=$key';

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var results = {
      'bounds_ne': json['routes'][0]['bounds']['northeast'],
      'bounds_sw': json['routes'][0]['bounds']['southwest'],
      'start_location': json['routes'][0]['legs'][0]['start_location'],
      'end_location': json['routes'][0]['legs'][0]['end_location'],
      'polyline': json['routes'][0]['overview_polyline']['points'],
      'polyline_decoded': PolylinePoints()
          .decodePolyline(json['routes'][0]['overview_polyline']['points'])
    };

    return results;
  }

  Future<Map<String, dynamic>> getPlaceDetails(
      double lat, double lng, int radius) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?&location=$lat,$lng&radius=$radius&key=$key';

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);

    return json;
  }

  Future<Map<String, dynamic>> getMorePlaceDetails(String tokenKey) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?&pagetoken=$tokenKey&key=$key';

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);

    return json;
  }
}
