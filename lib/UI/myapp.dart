import 'package:aqi_monitor/Utils/settings.dart';
import 'package:aqi_monitor/Utils/string_utils.dart';
import 'package:aqi_monitor/Utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Here we are asynchronously passing an instance of SharedPreferences
    /// to our Settings ChangeNotifier class and that in turn helps us
    /// determine the basic app settings to be applied whenever the app is
    /// launched.
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder:
          (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        return ChangeNotifierProvider<Settings>.value(
          value: Settings(snapshot.data),
          child: _MyApp(),
        );
      },
    );
  }
}

class _MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "AQI Monitor",
      theme: Provider.of<Settings>(context).isDarkMode
          ? setDarkTheme
          : setLightTheme,
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      home: MyHomePage(title: 'AQI Monitor'),
      //all the app routes are listed here
      routes: <String, WidgetBuilder>{
        //StringUtils.locationRoute : (BuildContext context) => LocationScreen()
      },
    );
  }
}
