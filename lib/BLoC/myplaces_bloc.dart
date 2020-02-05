import 'dart:async';

import 'package:aqi_monitor/UI/allplaces_tab.dart';
import 'package:aqi_monitor/database/place.dart';
import 'package:hive/hive.dart';

import 'bloc.dart';

class MyPlacesBloc implements Bloc {
  ///Get the placeBox
  Box<Place> placeBox = Hive.box("place_box");

  ///A private StreamController is declared that will manage the stream and sink for this BLoC
  ///Here broadcast is used so that this stream can be listened to more than once
  ///Which happens when we are determining Star icon state in [AllPlacesTab]
  final _controller = StreamController<List<Place>>.broadcast();

  ///A public getter to the defined StreamController's stream
  Stream<List<Place>> get myPlacesStream => _controller.stream;

  ///Method to check whether the place will be added or removed from the Box
  void togglePlace(String placeName) {
    if (placeBox.containsKey(placeName)) {
      placeBox.delete(placeName);
    } else {
      placeBox.put(placeName, Place(placeName));
    }
    ///Final places list from the Box added to the sink for the stream
    _controller.sink.add(placeBox.values.toList());
  }

  ///Method to check if the Box has the place
  bool containsPlace(String placeName) {
    return placeBox.containsKey(placeName);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
