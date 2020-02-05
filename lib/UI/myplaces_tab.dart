import 'package:aqi_monitor/UI/location_screen.dart';
import 'package:aqi_monitor/Utils/utils.dart';
import 'package:aqi_monitor/database/place.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MyPlacesTab extends StatefulWidget {
  @override
  _MyPlacesTabState createState() => _MyPlacesTabState();
}

class _MyPlacesTabState extends State<MyPlacesTab> {
  Box<Place> placeBox;

  @override
  void initState() {
    super.initState();

    ///get the hive box you want to use (read/write values to)
    placeBox = Hive.box("place_box");
  }

  @override
  Widget build(BuildContext context) {
    ///Here we observe the changes in the Hive box.
    return ValueListenableBuilder(
      valueListenable: placeBox.listenable(),
      builder: (context, Box<Place> box, _) {
        return box.values.toList().length == 0
            ? Center(child: Text("No Saved Places"))
            : ListView.separated(
                padding:
                    const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
                shrinkWrap: true,
                itemCount: placeBox.length,
                itemBuilder: (context, listIndex) {
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
                              "${listIndex + 1}",
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
                      title: Text(
                        "${placeBox.getAt(listIndex).name}",
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontFamily: Utils.ubuntuRegularFont),
                      ),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => LocationScreen(
                                  placeBox.getAt(listIndex).name))),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => Divider(
                  thickness: 0,
                ),
              );
      },
    );
  }
}
