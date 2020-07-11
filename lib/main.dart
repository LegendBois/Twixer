import 'package:flutter/material.dart';

import 'login/login.dart';

void main() {
  runApp(MyApp());
}

//colors : dark : 552163, light : c23264

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Roboto',
        //textTheme: TextTheme(),
        brightness: Brightness.dark,
        primaryColor: Color.fromARGB(255, 194, 50, 100),
        accentColor: Color.fromARGB(255, 85, 33, 99),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Login(),
    );
  }
}
