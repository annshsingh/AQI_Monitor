import 'package:aqi_monitor/UI/home_page.dart';
import 'package:aqi_monitor/UI/location_screen.dart';
import 'package:aqi_monitor/model/city_model.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

mixin FluroRouteHandlers {
  /// Handler for MyHomePage
  var homeScreenHandler = Handler(
    handlerFunc: (
      BuildContext context,
      Map<String, dynamic> parameters,
    ) {
      return MyHomePage();
    },
  );

  /// Handler for LocationScreen
  var locationScreenHandler = Handler(
    handlerFunc: (
      BuildContext context,
      Map<String, dynamic> parameters,
    ) {
      CityModel cityModel;
      if (parameters != null && parameters.isNotEmpty) {
        cityModel = CityModel.fromQueryParam(parameters);
      }
      return LocationScreen(
        city: cityModel != null ? cityModel.city : null,
        // city: null,
      );
    },
  );
}
