import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:list2/utils.dart';

class taskCalls {
  /*static Future<http.Response> addTask(String task) async {
    var response;
    await Utils.getToken().then((mytoken) async {
      var myBody = {"description": task};
      var myHeader = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $mytoken'
      };
      response = await http.post(
        "https://api-nodejs-todolist.herokuapp.com/task",
        body: jsonEncode(myBody),
        headers: myHeader,
      );
    });
    return response;
  }*/
  static Future<http.Response> addTask(String task) async {
    var reponse;
    await Utils.getToken().then((mytoken) async {
      var myBody = {"description": task};
      var myHeader = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $mytoken'
      };
      reponse = await http.post(
          "https://api-nodejs-todolist.herokuapp.com/task",
          body: jsonEncode(myBody),
          headers: myHeader);
    });
    return reponse;
  }

  static Future<http.Response> updateTask(String id, bool value) async {
    var reponse;
    await Utils.getToken().then((mytoken) async {
      var myBody = {"completed": value};
      var myHeader = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $mytoken'
      };
      reponse = await http.put(
        "https://api-nodejs-todolist.herokuapp.com/task/$id",
        body: jsonEncode(myBody),
        headers: myHeader,
      );
    });
    return reponse;
  }

  static Future<http.Response> getAllTasks() async {
    var response;
    await Utils.getToken().then((mytoken) async {
      var myHeader = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $mytoken'
      };
      response = await http.get(
        "https://api-nodejs-todolist.herokuapp.com/task",
        headers: myHeader,
      );
    });
    return response;
  }

  static Future<http.Response> deletTasek(String id) async {
    var response;
    await Utils.getToken().then((token) async {
      var myHeader = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      response = await http.delete(
        'https://api-nodejs-todolist.herokuapp.com/task/$id',
        headers: myHeader,
      );
    });
    return response;
  }
}
