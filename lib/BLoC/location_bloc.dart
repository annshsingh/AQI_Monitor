import 'dart:async';

import 'package:aqi_monitor/DataLayer/AqiClient.dart';
import 'package:aqi_monitor/UI/location_screen.dart';

import '../DataLayer/location.dart';
import 'bloc.dart';

class LocationBloc implements Bloc {

  ///Array of locations of type [Location] for the list on [LocationScreen]
  final _locations = <Location>[];

  ///A private StreamController is declared that will manage the stream and sink for this BLoC
  final _controller = StreamController<List<Location>>();
  final _client = AqiClient();

  ///A public getter to the defined StreamController's stream
  Stream<List<Location>> get locationStream => _controller.stream;

  ///Method to fetch locations for the city from Network
  ///[city]- Name of the city you want to fetch locations for
  ///[page]- The page you want to fetch from the API.
  ///Useful when you want to fetch data in badges.
  void selectedCity(String city, int page) async {
    final results = await _client.fetchLocations(city, page);
    ///add results to the array
    _locations.addAll(results);
    ///Fetched results added to the sink for the stream
    _controller.sink.add(_locations);
  }

  @override
  void dispose() {
    _controller.close();
    //clear the array of locations
    _locations.clear();
  }
}
