import 'dart:convert';
import 'package:http/http.dart' as http;
import 'vale.dart';

class Services {
  static const ROOT = 'http://10.33.105.22:84/vale/crud';
  static const String _GET_ACTION = 'GET_ALL';
  static const String _UPDATE_EMP_ACTION = 'UPDATE_EMP';

  static const String _LOGIN = 'LOGIN';

  static Future<String> login(user, pass) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _LOGIN;
      map["user"] = user;
      map['pass'] = pass;

      final response = await http.post(Uri.parse(ROOT), body: map);
      //print(response.body);
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<List<Vale>> liste() async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      if (response.statusCode == 200) {
        List<Vale> list = parsePhotos(response.body);
        print(list);
        return list;
      } else {
        throw List<Vale>.empty();
      }
    } catch (e) {
      return List<Vale>.empty();
    }
  }

  static List<Vale> parsePhotos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Vale>((json) => Vale.fromJson(json)).toList();
  }

  static Future<String> updateVale(String id) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _UPDATE_EMP_ACTION;
      map["id"] = id;

      final response = await http.post(Uri.parse(ROOT), body: map);
      return response.body;
    } catch (e) {
      return 'error';
    }
  }
}
