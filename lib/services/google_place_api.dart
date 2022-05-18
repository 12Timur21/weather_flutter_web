import 'dart:typed_data';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_place/google_place.dart';

class GooglePlaceAPI {
  GooglePlaceAPI._();
  static GooglePlaceAPI instance = GooglePlaceAPI._();

  final GooglePlace _googlePlace = GooglePlace(
    dotenv.env['GOOGLE_PLACE_API_KEY']!,
    headers: {
      'Access-Control-Allow-Origin': '*',
    },
  );

  Future<List<AutocompletePrediction>> getAutocomplete({
    required String placeName,
  }) async {
    if (placeName == '') return [];

    AutocompleteResponse? result = await _googlePlace.autocomplete.get(
      placeName,
      types: '(cities)',
    );

    String? status = result?.status;

    if (status == 'OK') {
      return result?.predictions ?? [];
    }
    if (status == 'ZERO_RESULTS') {
      throw Exception('ZERO_RESULTS');
    }

    throw Exception('Google place autocomplete status != OK');
  }

  Future<DetailsResult> getDetails({
    required String placeId,
  }) async {
    if (placeId == '') throw Exception('PlaceID is empty');

    DetailsResponse? response = await _googlePlace.details.get(
      placeId,
    );

    if (response == null || response.result == null) {
      throw Exception('No response');
    }

    String status = response.status ?? 'Error';
    DetailsResult result = response.result!;

    if (status == 'OK' && result.photos != null && result.photos!.isNotEmpty) {
      Location? location = result.geometry?.location;
      if (location?.lat == null && location?.lng == null) {
        throw Exception('Location not available');
      }
      return result;
    } else {
      throw Exception('Google details status != OK');
    }
  }

  Future<Uint8List> getPhoto({
    required String photoReference,
    int maxHeight = 1000,
    int maxWidth = 1000,
  }) async {
    if (photoReference == '') throw Exception('PhotoReference is empty');

    Uint8List? result = await _googlePlace.photos.get(
      photoReference,
      maxHeight,
      maxWidth,
    );

    if (result != null) {
      return result;
    } else {
      throw Exception('Photo does not exists');
    }
  }
}
