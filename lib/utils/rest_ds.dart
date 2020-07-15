import 'dart:async';
import 'dart:convert';

import 'package:Twixer/utils/network_util.dart';

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "http://13.235.9.123:42069/";
  static final LOGIN_URL = BASE_URL + "login";
  static final REGISTER_URL = BASE_URL + "register";
  static final _API_KEY =
      "Ws58CM6n264Wk318TZwKFnjGucUSN4qZ3qtuzs32kTRqBSP2249hR2sSf8IESfkr";
  final JsonDecoder _decoder = new JsonDecoder();

  Future<List<String>> login(String username, String password, bool login) {
    String url = login ? LOGIN_URL : REGISTER_URL;

    print(url);
    return _netUtil.post(url, body: {
      "apikey": _API_KEY,
      "email": username,
      "password": password
    }).then((dynamic res) {
      if (res is String) {
        return ["INVALID", "Network Error"];
      } else {
        final String body = res.body;
        final int statusCode = res.statusCode;

        if (statusCode < 200 || statusCode > 400 || json == null) {
          return ["INVALID", "Error while fetching data"];
        }
        print(res.toString());
        dynamic response = _decoder.convert(body);
        return [response["userkey"], response["message"]];
      }
    });
  }
}
