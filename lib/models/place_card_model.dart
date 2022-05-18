import 'package:equatable/equatable.dart';

class PlaceLocation {
  final double lat;
  final double lng;

  PlaceLocation({
    required this.lat,
    required this.lng,
  });

  factory PlaceLocation.fromJson(Map<String, dynamic> json) {
    return PlaceLocation(
      lat: json['lat'],
      lng: json['lng'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}

class PlaceCardModel extends Equatable {
  final String? placeName;
  final String? placeID;
  final PlaceLocation? location;
  final String? photoReference;

  const PlaceCardModel({
    this.placeName,
    this.placeID,
    this.location,
    this.photoReference,
  });

  factory PlaceCardModel.fromJson(Map<String, dynamic> json) {
    return PlaceCardModel(
      placeName: json['placeName'],
      placeID: json['placeID'],
      location: PlaceLocation.fromJson(json['location']),
      photoReference: json['photoReference'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'placeName': placeName,
      'placeID': placeID,
      'location': location?.toJson(),
      'photoReference': photoReference,
    };
  }

  PlaceCardModel copyWith({
    String? placeName,
    String? placeID,
    PlaceLocation? location,
    String? photoReference,
  }) {
    return PlaceCardModel(
      placeName: placeName ?? this.placeName,
      placeID: placeID ?? this.placeID,
      location: location ?? this.location,
      photoReference: photoReference ?? this.photoReference,
    );
  }

  @override
  List<Object?> get props => [
        placeName,
        placeID,
        location,
        photoReference,
      ];
}
