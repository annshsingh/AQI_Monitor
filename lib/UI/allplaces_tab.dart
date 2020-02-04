import 'package:aqi_monitor/UI/location_screen.dart';
import 'package:aqi_monitor/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AllPlacesTab extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
      itemCount: cities.length,
      reverse: false,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: Theme.of(context).primaryColor,
          child: ListTile(
            contentPadding: EdgeInsets.only(
                left: 12.0, right: 12.0, top: 8.0, bottom: 12.0),
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
              icon: Icon(
                Icons.star_border,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {},
            ),
            title: Text(
              "${cities[index]}",
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontFamily: Utils.ubuntuRegularFont),
            ),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        LocationScreen(cities[index]))),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => Divider(
        thickness: 0,
      ),
    );
  }
}
