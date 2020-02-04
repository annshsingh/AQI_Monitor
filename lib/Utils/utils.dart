import 'dart:ui';

import 'ListInfo.dart';

class Utils {
  //Routes
  static const String locationRoute = "/LocationScreen";

  //Fonts
  static const String ubuntuRegularFont = "Ubuntu-Regular.ttf";

  //Assets
  static const String imageDir = "assets/images";
  static const String lungs_img = "$imageDir/lungs.svg";
  static const String green_img = "$imageDir/green.svg";
  static const String yellow_img = "$imageDir/yellow.svg";
  static const String orange_img = "$imageDir/orange.svg";
  static const String red_img = "$imageDir/red.svg";
  static const String purple_img = "$imageDir/purple.svg";
  static const String maroon_img = "$imageDir/maroon.svg";

  //Get AQI

  static ListInfo getListInfo(dynamic pm25) {
    if (pm25 <= 30) {
      return ListInfo(
          Color(0xFFA9DE67), (pm25 * 50 / 30).round(), green_img, "Good");
    } else if (pm25 > 30 && pm25 <= 60) {
      return ListInfo(Color(0xFFFCD658), (50 + (pm25 - 30) * 50 / 30).round(),
          yellow_img, "Moderate");
    } else if (pm25 > 60 && pm25 <= 90) {
      return ListInfo(Color(0xFFFC9B5E), (100 + (pm25 - 60) * 100 / 30).round(),
          orange_img, "Slightly Unhealty");
    } else if (pm25 > 90 && pm25 <= 120) {
      return ListInfo(Color(0xFFFC6B6C), (200 + (pm25 - 90) * 100 / 30).round(),
          red_img, "Unhealty");
    } else if (pm25 > 120 && pm25 <= 250) {
      return ListInfo(
          Color(0xFFA87CBA),
          (300 + (pm25 - 120) * 100 / 130).round(),
          purple_img,
          "Very Unhealty");
    } else {
      return ListInfo(Color(0xFFA77483),
          (400 + (pm25 - 250) * 100 / 130).round(), maroon_img, "Hazardous");
    }
  }
}
