import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:Twixer/routes.dart';
import 'package:Twixer/style.dart' as style;

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              "Twixer",
              style: Theme.of(context).textTheme.headline6,
            ),
            accountEmail: Text(
              "test@twixer.com",
              style: style.Subtitle1TextStyle,
            ),
            currentAccountPicture: Image.asset(
              "assets/images/twixer_logo_icon.png",
            ),
          ),
          Expanded(
            flex: 8,
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.games),
                  title: Text('Games'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.chrome_reader_mode),
                  title: Text('News'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.tv),
                  title: Text('Stream'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                onTap: () => _logout(context),
              ),
            ),
          ),
          Expanded(
              child: Align(
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "Made in India\nwith ",
                    style: style.Subtitle2TextStyle),
                WidgetSpan(
                  child: Icon(
                    Icons.favorite,
                    size: 12,
                  ),
                )
              ]),
              textAlign: TextAlign.center,
            ),
          ))
        ],
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
