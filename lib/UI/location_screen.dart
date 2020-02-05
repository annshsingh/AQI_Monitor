import 'package:aqi_monitor/BLoC/bloc_provider.dart';
import 'package:aqi_monitor/BLoC/location_bloc.dart';
import 'package:aqi_monitor/Utils/ListInfo.dart';
import 'package:aqi_monitor/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
        appBar: AppBar(
          title: Text(
            widget.city,
            style: TextStyle(
                fontFamily: Utils.ubuntuRegularFont,
                color: Theme.of(context).accentColor),
          ),
        ),
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
          return Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)),
          );
        }

        if (results.isEmpty) {
          return Center(
              child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.error,
                  size: 48.0,
                  color: Colors.red,
                ),
              ),
              Text(
                'No Results',
                style: TextStyle(
                    fontFamily: Utils.ubuntuRegularFont,
                    color: Theme.of(context).accentColor),
              ),
            ],
          ));
        }

        return _buildSearchResults(results);
      },
    );
  }

  Widget _buildSearchResults(List<Location> results) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final location = results[index];
        return _locationCard(
            Utils.getListInfo(location.value), location.location);
      },
    );
  }

  Widget _locationCard(ListInfo listInfo, String location) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 4.0, left: 8.0, right: 8.0, bottom: 4.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        elevation: 2.0,
        child: Container(
          color: Colors.transparent,
          width: 300,
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6.0),
                      bottomLeft: Radius.circular(6.0)),
                  child: Container(
                    color: listInfo.color,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        SvgPicture.asset(
                          listInfo.assetName,
                          width: 60.0,
                          height: 60.0,
                        ),
                        Text(
                          "${listInfo.message}",
                          style: TextStyle(
                              fontFamily: Utils.ubuntuRegularFont,
                              color: Colors.black38,
                              fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(6.0),
                      bottomRight: Radius.circular(6.0)),
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 8.0, left: 8.0),
                              child: Icon(Icons.location_on,
                                  color: Theme.of(context).accentColor),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  "$location",
                                  style: TextStyle(
                                    fontFamily: Utils.ubuntuRegularFont,
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 4.0, left: 12.0),
                              child: Text(
                                "AQI: ",
                                style: TextStyle(
                                    fontFamily: Utils.ubuntuRegularFont,
                                    color: Theme.of(context).accentColor,
                                    fontSize: 18.0),
                              ),
                            ),
                            Text(
                              "${listInfo.aqi}",
                              style: TextStyle(
                                  fontFamily: Utils.ubuntuRegularFont,
                                  color: Theme.of(context).accentColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
