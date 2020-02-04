import 'package:aqi_monitor/BLoC/bloc_provider.dart';
import 'package:aqi_monitor/BLoC/location_bloc.dart';
import 'package:flutter/material.dart';

import '../DataLayer/location.dart';

class LocationScreen extends StatefulWidget {
  final String city;

  const LocationScreen(this.city);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final bloc = LocationBloc();

  @override
  void initState() {
    bloc.selectedCity(widget.city);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocationBloc>(
      bloc: bloc,
      child: Scaffold(
        appBar: AppBar(title: Text('Locations')),
        body: _buildResults(bloc),
      ),
    );
  }

  Widget _buildResults(LocationBloc bloc) {
    return StreamBuilder<List<Location>>(
      stream: bloc.locationStream,
      builder: (context, snapshot) {
        final results = snapshot.data;

        if (results == null) {
          return Center(child: Text('Fetching locations....'));
        }

        if (results.isEmpty) {
          return Center(child: Text('No Results'));
        }

        return _buildSearchResults(results);
      },
    );
  }

  Widget _buildSearchResults(List<Location> results) {
    return ListView.separated(
      itemCount: results.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (context, index) {
        final location = results[index];
        return ListTile(
          title: Text(location.location),
          onTap: () {},
        );
      },
    );
  }
}
