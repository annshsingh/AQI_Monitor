import 'package:aqi_monitor/UI/allplaces_tab.dart';
import 'package:aqi_monitor/UI/myplaces_tab.dart';
import 'package:aqi_monitor/Utils/settings.dart';
import 'package:aqi_monitor/Utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Tab> myTabs = <Tab>[
    Tab(text: "My Places"),
    Tab(text: "All Places"),
  ];

  @override
  Widget build(BuildContext context) {
    //Wrap everything in DefaultTabController
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: SvgPicture.asset(
                  StringUtils.lungs_img,
                  width: 32.0,
                  height: 32.0,
                  color: Theme.of(context).accentColor,
                  semanticsLabel: "Lungs Image",
                ),
              ),
              Text(
                widget.title,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: StringUtils.ubuntuRegularFont),
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Provider.of<Settings>(context).isDarkMode
                  ? Icons.brightness_high
                  : Icons.brightness_low),
              onPressed: () {
                changeTheme(
                    Provider.of<Settings>(context, listen: false).isDarkMode
                        ? false
                        : true,
                    context);
              },
            ),
          ],
          //Specify the tabs for your view
          bottom: TabBar(
            tabs: myTabs,
            indicatorColor: Theme.of(context).accentColor,
          ),
        ),
        //Provide each tab with its own content
        body: TabBarView(
          children: [
            MyPlacesTab(),
            AllPlacesTab()
          ]
        ),
      ),
    );
  }

  void changeTheme(bool set, BuildContext context) {
    ///Call setDarkMode method inside our Settings ChangeNotifier class to
    ///Notify all the listeners of the change.
    Provider.of<Settings>(context, listen: false).setDarkMode(set);
  }
}