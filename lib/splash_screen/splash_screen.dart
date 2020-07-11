import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:twixer/routes.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // SchedulerBinding.instance.addPostFrameCallback((_) {
    //   _handleStartScreen();
    // });
    _handleStartScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.black),
      child: Image.asset(
        "assets/images/twixer-logo.png",
        fit: BoxFit.contain,
      ),
    );
  }

  Future<void> _handleStartScreen() async {
    //TODO : Create auth class or scoped_model
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isLoggedIn') == null) {
      await prefs.setBool('isLoggedIn', false);
    }
    print(prefs.getBool('isLoggedIn'));
    if (prefs.getBool('isLoggedIn')) {
      Navigator.popAndPushNamed(context, HomeRoute);
    } else {
      Navigator.popAndPushNamed(context, LoginRoute);
    }
  }
}
