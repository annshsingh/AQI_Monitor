import 'package:aqi_monitor/UI/location_screen.dart';
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
          color: Colors.blue[500],
          child: ListTile(
            leading: GestureDetector(
              onTap: () {},
              child: Container(
                width: 48,
                height: 48,
                padding: EdgeInsets.symmetric(vertical: 4.0),
                alignment: Alignment.center,
                child: CircleAvatar(
                  child: Icon(Icons.person),
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            trailing: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            title: Text(
              "Person ${index + 1}",
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              "${cities[index]}",
              style: TextStyle(color: Colors.white),
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
        thickness: 2,
      ),
    );
  }
}
