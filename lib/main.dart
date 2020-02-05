import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'UI/myapp.dart';
import 'database/place.dart';

const placeBox = 'place_box';

void main() async {
  /// Initialise Hive on App startup
  await Hive.initFlutter();

  /// Register adapters (if any)
  Hive.registerAdapter(PlaceAdapter());

  /// Open Hive boxes fo ruse throughout the app
  await Hive.openBox<Place>(placeBox);
  runApp(MyApp());
}
