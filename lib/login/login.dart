import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:twixer/routes.dart';

const users = const {
  'majithiaanmol12@gmail.com': '123456',
  'test@gmail.com': 'legendbois',
};

class Login extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) {
    //print('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'Username not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      _loginUser(data.name);
      return null;
    });
  }

  _loginUser(String name) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
    prefs.setString('username', name);
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
      logo: 'assets/images/twixer-logo.png', //works
      onLogin: _authUser,
      onSignup: _authUser,
      onSubmitAnimationCompleted: () {
        Navigator.pushReplacementNamed(context, HomeRoute);
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
