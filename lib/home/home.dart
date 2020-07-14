import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:Twixer/routes.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Home loaded");
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          // action button
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Center(
        child: Text('Placeholder'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Twixer'),
              decoration: BoxDecoration(
                color: Colors.black,
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Placeholder'),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }

  _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
    prefs.setString('userkey', "INVALID");
    prefs.setString('username', "");
    Navigator.pushReplacementNamed(context, LoginRoute);
  }
}
