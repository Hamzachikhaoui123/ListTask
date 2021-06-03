import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthCalls {
  /*static Future<http.Response> login(String email, String pass) async {
    var myBody = {"email": email, "password": pass};
    var reponse = await http.post(
        'https://api-nodejs-todolist.herokuapp.com/user/login',
        body: jsonEncode(myBody),
        headers: {'Content-Type': 'application/json'});
    return reponse;
  }
*/
  static Future<http.Response> login(String email, String pass) async {
    var myBody = {"email": email, "password": pass};
    var reponse = await http.post(
        'https://api-nodejs-todolist.herokuapp.com/user/login',
        body: jsonEncode(myBody),
        headers: {'Content-Type': 'application/json'});
    return reponse;
  }

  /*static Future<http.Response> Register(
      String email, String pass, String name) async {
    var myBody = {"email": email, "password": pass, "name": name, "age": 98};
    var reponse = await http.post(
        'https://api-nodejs-todolist.herokuapp.com/user/register',
        body: jsonEncode(myBody),
        headers: {'Content-Type': 'application/json'});
    return reponse;
  }*/
  static Future<http.Response> Register(
      String email, String pass, String name) async {
    var myBody = {'email': email, 'password': pass, 'name': name, 'age': 50};
    var reponse = await http.post(
        'https://api-nodejs-todolist.herokuapp.com/user/register',
        body: jsonEncode(myBody),
        headers: {'Content-Type': 'application/json'});
    return reponse;
  }
}
