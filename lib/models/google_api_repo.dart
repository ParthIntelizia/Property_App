import 'dart:io';
import 'package:dio/dio.dart';

import '../get_storage_services/get_storage_service.dart';

class Place {
  final String? placeId, description;
  final dynamic structuredFormatting;

  Place({this.placeId, this.description, this.structuredFormatting});
  static Place fromJson(Map<String, dynamic> json) {
    return Place(
      placeId: json['placeId'],
      description: json['description'],
      structuredFormatting: json['structured_formatting'],
    );
  }
}

class PlaceApi {
  PlaceApi._internal();
  static PlaceApi get instance => PlaceApi._internal();
  final Dio _dio = Dio();

  static final String androidKey = 'AIzaSyBLjgELUHE9X1z5OI0if3tMRDG5nWK2Rt8';
  static final String iosKey = 'YOUR_API_KEY_HERE';
  final apiKey = Platform.isAndroid ? androidKey : iosKey;

  Future<List<Place>> searchPredictions(String input) async {
    // print(
    //     'countryName short from  ${AppPref.countryShortCode.toString().toLowerCase()}');
    try {
      final response = await this._dio.get(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json',
        queryParameters: {
          "input": input,
          "key": apiKey,
          "types": "address",
          "language": "en",
          "components":
              "country:${GetStorageServices.getCountryCode().toString().toLowerCase()}",
        },
      );
      // print(response.data);
      final List<Place> places = (response.data['predictions'] as List)
          .map((item) => Place.fromJson(item))
          .toList();
      return places;
    } catch (e) {
      return [];
    }
  }
}
