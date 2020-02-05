import 'dart:ui';

///Class used to add custom properties to the list of locations for a city
class ListInfo {
  const ListInfo(this.color, this.aqi, this.assetName, this.message);

  final Color color;
  final int aqi;
  final String assetName;
  final String message;
}