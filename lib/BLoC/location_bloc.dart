import 'dart:async';
import 'package:aqi_monitor/DataLayer/AqiClient.dart';

import '../DataLayer/location.dart';
import 'bloc.dart';

class LocationBloc implements Bloc {
  final _controller = StreamController<List<Location>>();
  final _client = AqiClient();
  Stream<List<Location>> get locationStream => _controller.stream;

  void selectedCity(String query) async {
    final results = await _client.fetchLocations(query);
    _controller.sink.add(results);
  }

  @override
  void dispose() {
    _controller.close();
  }
}