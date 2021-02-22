import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiHelper {
  String baseUrl = 'http://192.168.2.133:8000/';
  String registrationUrl = 'auth/registration/';
  String loginUrl = 'auth/login/';

  //USER - REGISTRATION
  Future<Map> registration(
      {String username, String password, BuildContext context}) async {
    try {
      Response response = await Dio().post(
          'http://192.168.2.133:8000/auth/registration/',
          data: {"username": username, "password": password});
      return {"data": response.data, "status_code": response.statusCode};
    } catch (e) {
      // if (e.response.statusCode == 500) {
      return {"status_code": e};
      // }
    } finally {}
  }

  Future<Map> login(
      {String username, String password, BuildContext context}) async {
    try {
      Response response = await Dio().post('$baseUrl$loginUrl',
          data: {"username": username, "password": password});
      return {"data": response.data, "status_code": response.statusCode};
    } catch (e) {
      if (e.response.statusCode == 400) {
        return {"status_code": e.response.statusCode};
      }
      print(e.toString());
    }
  }
}
