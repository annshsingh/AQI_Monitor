import 'package:flutter/material.dart';

class MyPlacesTab extends StatefulWidget {
  @override
  _MyPlacesTabState createState() => _MyPlacesTabState();
}

class _MyPlacesTabState extends State<MyPlacesTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Your saved places"),
      ),
    );
  }
}
