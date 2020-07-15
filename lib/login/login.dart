import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:Twixer/routes.dart';
import 'package:Twixer/utils/rest_ds.dart';

const users = const {
  'majithiaanmol12@gmail.com': '123456',
  'test@gmail.com': 'legendbois',
};

class Login extends StatelessWidget {
  RestDatasource api = new RestDatasource();
  Duration get loginTime => Duration(milliseconds: 2250);
  Future<String> _login(LoginData data) {
    return _authUser(data, true);
  }

  Future<String> _signUp(LoginData data) {
    return _authUser(data, false);
  }

  Future<String> _authUser(LoginData data, bool login) {
    //return null; //testing
    //print('Name: ${data.name}, Password: ${data.password}');
    return api.login(data.name, data.password, login).then((response) {
      if (response[0] == "INVALID" || response[0] == null) {
        return response[1];
      } else {
        _loginUser(data.name, response[0]);
        return null;
      }
    });
  }

  _loginUser(String name, String userkey) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
    prefs.setString('username', name);
    prefs.setString('userkey', userkey);
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'Username not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Login loaded");
    return FlutterLogin(
      theme: LoginTheme(
        bodyStyle: TextStyle(
          color: Colors.white,
        ),
        primaryColor: Color.fromARGB(255, 194, 50, 100),
        accentColor: Colors.white,
        inputTheme: InputDecorationTheme(
          fillColor: Colors.white,
        ),
      ),
      title: 'TWIXER',
      logo: 'assets/images/twixer_logo.png', //works
      onLogin: _login,
      onSignup: _signUp,
      onSubmitAnimationCompleted: () {
        //Don't add a function for this
        Navigator.pushReplacementNamed(context, HomeRoute);
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
