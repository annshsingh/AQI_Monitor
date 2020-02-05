import 'dart:async';

import 'package:aqi_monitor/DataLayer/AqiClient.dart';

import '../DataLayer/location.dart';
import 'bloc.dart';

class LocationBloc implements Bloc {
  ///A private StreamController is declared that will manage the stream and sink for this BLoC
  final _controller = StreamController<List<Location>>();
  final _client = AqiClient();

  ///A public getter to the defined StreamController's stream
  Stream<List<Location>> get locationStream => _controller.stream;

  ///Method to fetch locations for the city from Network
  void selectedCity(String query) async {
    final results = await _client.fetchLocations(query);

    ///Fetched results added to the sink for the stream
    _controller.sink.add(results);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
