import 'package:aqi_monitor/BLoC/bloc_provider.dart';
import 'package:aqi_monitor/BLoC/myplaces_bloc.dart';
import 'package:aqi_monitor/UI/location_screen.dart';
import 'package:aqi_monitor/Utils/utils.dart';
import 'package:aqi_monitor/database/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';

class AllPlacesTab extends StatefulWidget {
  @override
  _AllPlacesTabState createState() => _AllPlacesTabState();
}

class _AllPlacesTabState extends State<AllPlacesTab> {
  ///List of all the predefined images
  final List<String> cities = <String>[
    'Bengaluru',
    'Chandigarh',
    'Chennai',
    'Delhi',
    'Gurugram',
    'Hyderabad',
    'Kolkata',
    'Noida',
    'Pune',
  ];

  Box<Place> placeBox;

  @override
  void initState() {
    super.initState();

    ///get the hive box you want to use (read/write values to)
    placeBox = Hive.box("place_box");
  }

  @override
  Widget build(BuildContext context) {
    ///Get the PlacesBloc here which is defined at the root (Wrapping MaterialApp)
    final myPlacesBloc = BlocProvider.of<MyPlacesBloc>(context);

    return ListView.separated(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
      itemCount: cities.length,
      reverse: false,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: Theme.of(context).primaryColor,
          child: ListTile(
            contentPadding: EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0, bottom: 12.0),
            leading: Container(
              width: 48,
              height: 48,
              padding: EdgeInsets.symmetric(vertical: 4.0),
              alignment: Alignment.center,
              child: CircleAvatar(
                child: Center(
                  child: Text(
                    "${index + 1}",
                    style: TextStyle(
                      fontFamily: Utils.ubuntuRegularFont,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                backgroundColor: Colors.blue,
              ),
            ),
            trailing: IconButton(
              icon: _buildFavoriteButton(myPlacesBloc, cities[index], context),
              onPressed: () {
                ///Check whether to add place to PlacesBox
                myPlacesBloc.togglePlace(cities[index]);
                myPlacesBloc.containsPlace(cities[index])
                    ? ScaffoldMessenger.of(context).showSnackBar(
                        _createSnackBar(Colors.green, "${cities[index]} added to My Places"),
                      )
                    : ScaffoldMessenger.of(context).showSnackBar(
                        _createSnackBar(Colors.red, "${cities[index]} removed from My Places"),
                      );
              },
            ),
            title: Text(
              "${cities[index]}",
              style: TextStyle(color: Theme.of(context).accentColor, fontFamily: Utils.ubuntuRegularFont),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => LocationScreen(cities[index]),
              ),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => Divider(
        thickness: 0,
      ),
    );
  }

  ///This method is used to toggle Star icon depending on the fact that
  ///the PlacesBox has the city or not
  Widget _buildFavoriteButton(MyPlacesBloc bloc, String cityName, BuildContext context) {
    return StreamBuilder<List<Place>>(
      stream: bloc.myPlacesStream,
      initialData: <Place>[],
      builder: (context, snapshot) {
        bool isMyPlace = bloc.containsPlace(cityName);
        return Icon(
          isMyPlace ? Icons.star : Icons.star_border,
          color: Theme.of(context).accentColor,
        );
      },
    );
  }

  ///Method to create a SnackBar depending on the fact that the place is
  ///in the Places Box or not
  Widget _createSnackBar(Color color, String message) {
    return SnackBar(
      elevation: 6.0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
      content: Text("$message"),
      duration: Duration(milliseconds: 1000),
    );
  }
}
