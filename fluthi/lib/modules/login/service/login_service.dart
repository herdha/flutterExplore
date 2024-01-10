import 'package:dio/dio.dart';
import 'package:fluthi/config/api.dart';
import 'package:fluthi/modules/login/model/driver_model.dart';
// import 'package:fluthi/modules/login/model/login_model.dart';
import 'package:fluthi/routes/routes.dart';
import 'package:get/get.dart';
// import 'dart:convert';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  Future<List<DriverModel>?> getDataDriver() async {
    try {
      var response = await Api.request.get('/driver');
      List data = response.data;
      return data.map((e) => DriverModel.fromJson(e)).toList();
    } on DioException catch (err) {
      print(err.message!);
      return null;
    }
  }

  loginService(String email, String password) async {
    // var mes = '';
    try {
      var login = { 'email': email, 'password': password };
      var res = await Api.request.post('/login', data: login);
      Map data = res.data;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', data['token']);
      prefs.setString('name', data['name']);
      prefs.setString('username', data['username']);
      prefs.setString('email', data['email']);
      prefs.setString('role', data['role']);
      Get.offNamed(AppRoutes.main);
      return data;
      // print(data);
    } on DioException catch (err) {
      // print('ini errornya '+err.response!.data['message'].toString());
      if(err.response != null){
        return err;
      }
    }
  }
}