import 'package:Twixer/game/game.dart';
import 'package:flutter/material.dart';

import 'home/home.dart';
import 'login/login.dart';
import 'routes.dart';
import 'splash_screen/splash_screen.dart';

import 'package:Twixer/style.dart';

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
      initialRoute: Loading,
      theme: _theme(),
    );
  }

  RouteFactory _routes() {
    return (settings) {
      final Map<String, dynamic> arguments = settings.arguments;
      Widget screen;
      switch (settings.name) {
        case Loading:
          screen = SplashScreen();
          break;
        case HomeRoute:
          screen = Home();
          break;
        case LoginRoute:
          screen = Login();
          break;
        case GameRoute:
          screen = GameDetail(arguments['game']);
          break;
        default:
          screen = SplashScreen();
          break;
      }
      return MaterialPageRoute(
        builder: (BuildContext context) => screen,
        settings: settings,
      );
    };
  }

  ThemeData _theme() {
    return ThemeData(
      appBarTheme: AppBarTheme(
        textTheme: TextTheme(
          headline6: AppBarTextStyle,
        ),
      ),
      textTheme: TextTheme(
        headline6: TitleTextStyle,
        headline5: TitleTextStyleJuliusR,
        headline4: TitleTextStyleJulius,
        bodyText2: Body2TextStyle,
        bodyText1: Body1TextStyle,
      ),

      //textTheme: TextTheme(),
      scaffoldBackgroundColor: Colors.black,
      brightness: Brightness.dark,
      primaryColor: Color.fromARGB(255, 194, 50, 100),
      accentColor: Color.fromARGB(255, 85, 33, 99),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
