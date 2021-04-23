import 'dart:io';

import 'package:aqi_monitor/UI/home_page.dart';
import 'package:aqi_monitor/UI/location_screen.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';

import 'fluro_routes_handlers.dart';

/// setting up singleton class for FluroRoutes

class FluroRoutes with FluroRoutesHandlers {
  /// initializing FluroRoutes
  static final FluroRoutes fluroRoutesInstance = FluroRoutes._();

  factory FluroRoutes() {
    return fluroRoutesInstance;
  }

  FluroRoutes._();

  void routes(FluroRouter fluroRouter) {
    TransitionType transitionType;

    /// setting transition for web
    if (kIsWeb) {
      transitionType = TransitionType.fadeIn;
    }

    /// setting transition for android
    else if (Platform.isAndroid) {
      transitionType = TransitionType.material;
    }

    /// setting transition for iOS
    else {
      transitionType = TransitionType.cupertino;
    }

    /// linking handlers and routes
    fluroRouter.define(
      MyHomePage.routeName,
      handler: homeScreenHandler,
      transitionType: transitionType,
    );

    fluroRouter.define(
      LocationScreen.routeName,
      handler: locationScreenHandler,
      transitionType: transitionType,
    );
  }
}
