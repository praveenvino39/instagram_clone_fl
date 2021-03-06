import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/contant.dart';

class ApiHelper {
  String registrationUrl = 'auth/registration/';
  String loginUrl = 'auth/login/';

  //USER - REGISTRATION
  Future<Map> registration(
      {String username, String password, BuildContext context}) async {
    try {
      Response response = await Dio().post('$baseUrl$registrationUrl',
          data: {"username": username, "password": password});
      return {"data": response.data, "status_code": response.statusCode};
    } catch (e) {
      // if (e.response.statusCode == 500) {
      return {"status_code": e};
      // }
    } finally {}
  }

  // USER - LOGIN
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
      return Future(null);
    }
  }
}
