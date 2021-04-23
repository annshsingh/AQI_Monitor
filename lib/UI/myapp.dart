import 'package:aqi_monitor/BLoC/bloc_provider.dart';
import 'package:aqi_monitor/BLoC/myplaces_bloc.dart';
import 'package:aqi_monitor/Utils/settings.dart';
import 'package:aqi_monitor/Utils/themes.dart';
import 'package:aqi_monitor/routes/fluro_routes.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FluroRouter fluroRouter = FluroRouter();

  @override
  void initState() {
    super.initState();

    /// setting up FluroRoutes
    FluroRoutes().routes(fluroRouter);
  }

  @override
  Widget build(BuildContext context) {
    /// Here we are asynchronously passing an instance of SharedPreferences
    /// to our Settings ChangeNotifier class and that in turn helps us
    /// determine the basic app settings to be applied whenever the app is
    /// launched.
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        return ChangeNotifierProvider<Settings>.value(
          value: Settings(snapshot.data),
          child: _MyApp(
            fluroRouter: fluroRouter,
          ),
        );
      },
    );
  }
}

class _MyApp extends StatelessWidget {
  final FluroRouter fluroRouter;

  _MyApp({
    this.fluroRouter,
  });

  @override
  Widget build(BuildContext context) {
    ///The MyPlacesBloc needs to be accessible from multiple screens,
    ///which means it needs to be placed above the navigator
    return BlocProvider<MyPlacesBloc>(
      bloc: MyPlacesBloc(),
      child: MaterialApp(
        title: "AQI Monitor",
        theme: Provider.of<Settings>(context).isDarkMode ? setDarkTheme : setLightTheme,
        debugShowCheckedModeBanner: false,
        showPerformanceOverlay: false,
        home: MyHomePage(),

        /// pass you initial screen's route in initialRoute
        initialRoute: MyHomePage.routeName,

        /// use fluro's generator
        /// generator is a property as callback to create routes that can be used with the Navigator class.
        onGenerateRoute: fluroRouter.generator,

        /// in onUnknownRoute we can specify home screen or splash or unknown screen
        onUnknownRoute: (unknownRoutes) {
          return MaterialPageRoute(
            builder: (context) => MyHomePage(),
          );
        },
      ),
    );
  }
}
