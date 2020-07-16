import 'dart:async';
import 'package:http/http.dart' as http;

class NetworkUtil {
  // next three lines makes this class a Singleton
  static NetworkUtil _instance = new NetworkUtil.internal();
  NetworkUtil.internal();
  factory NetworkUtil() => _instance;

  Future<http.Response> get(String url) async {
    return http.get(url);
  }

  Future<dynamic> post(String url, {Map headers, body, encoding}) async {
    try {
      return await http.post(
        url,
        body: body,
        headers: headers,
        encoding: encoding,
      );
    } catch (e) {
      print(e);
      return e.toString();
    }
  }
}
