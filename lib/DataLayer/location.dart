/// Data class for the locations inside a City
/// Here:
///  location: Name of the location
///  value: PM 2.5 value for the location
///  unit: Unit of the value
///  coordinates: Lat/Lng values for the location

class Location {
  final String location;
  final dynamic value;
  final String unit;
  final LocationCoordinates coordinates;

  Location.fromJson(Map json)
      : location = json['location'],
        value = json['value'],
        unit = json['unit'],
        coordinates = LocationCoordinates.fromJson(json['coordinates']);
}

class LocationCoordinates {
  final double latitude;
  final double longitude;

  LocationCoordinates.fromJson(Map json)
      : latitude = json['latitude'],
        longitude = json['longitude'];
}