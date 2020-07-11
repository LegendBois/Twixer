import 'package:flutter/material.dart';

import 'home/home.dart';
import 'login/login.dart';
import 'routes.dart';

void main() {
  runApp(MyApp());
}

//colors : dark : 552163, light : c23264

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twixer',
      onGenerateRoute: _routes(),
      theme: _theme(),
    );
  }

  RouteFactory _routes() {
    return (settings) {
      final Map<String, dynamic> arguments = settings.arguments;
      Widget screen;
      switch (settings.name) {
        case HomeRoute:
          screen = Home();
          break;
        case LoginRoute:
          screen = Login();
          break;
        default:
          screen = Login();
          break;
      }
      return MaterialPageRoute(
          builder: (BuildContext context) => screen, settings: settings);
    };
  }

  ThemeData _theme() {
    return ThemeData(
      fontFamily: 'Roboto',
      //textTheme: TextTheme(),
      brightness: Brightness.dark,
      primaryColor: Color.fromARGB(255, 194, 50, 100),
      accentColor: Color.fromARGB(255, 85, 33, 99),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
