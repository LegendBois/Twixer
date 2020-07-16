import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:Twixer/routes.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Twixer | Home',
        style: Theme.of(context).appBarTheme.textTheme.headline6,
      ),
      actions: <Widget>[
        // action button
        IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () => _logout(context),
        ),
      ],
    );
  }

  _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
    prefs.setString('userkey', "INVALID");
    prefs.setString('username', "");
    Navigator.pushReplacementNamed(context, LoginRoute);
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
