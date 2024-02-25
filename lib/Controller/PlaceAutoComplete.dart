import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart';
import 'package:sg_carpark_availability/Entity/Place.dart';


class PlaceApiProvider {
  final client = Client();

  PlaceApiProvider(this._sessionToken);

  final _sessionToken;

  final String _apiKey = 'AIzaSyAzedSahYVFaCTK3_YP19NYYd9_mW3EI5A';

  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&language=$lang&components=country:sg&key=$_apiKey&sessiontoken=$_sessionToken';
    final response = await client.get(request as Uri);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<Place> getPlaceDetailFromId(String placeId) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_component&key=$_apiKey&sessiontoken=$_sessionToken';
    final response = await client.get(request as Uri);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        final components =
            result['result']['address_components'] as List<dynamic>;
        // build result
        final place = Place(streetNumber: '', street: '', city: '', zipCode: '');
        for (var c in components) {
          final List type = c['types'];
          if (type.contains('street_number')) {
            place.streetNumber = c['long_name'];
          }
          if (type.contains('route')) {
            place.street = c['long_name'];
          }
          if (type.contains('locality')) {
            place.city = c['long_name'];
          }
          if (type.contains('postal_code')) {
            place.zipCode = c['long_name'];
          }
        }
        return place;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
  static Future<LatLng> getCoordinates(String searchTerm) async {
    List<Location> locations = await locationFromAddress(searchTerm);
    return LatLng(locations[0].latitude, locations[0].longitude);
  }
}


