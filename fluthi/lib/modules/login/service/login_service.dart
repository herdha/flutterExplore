import 'package:dio/dio.dart';
import 'package:fluthi/config/api.dart';
import 'package:fluthi/routes/routes.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  loginService(String email, String password) async {
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
    } on DioException catch (err) {
      if(err.response != null){
        return err;
      }
    }
  }
}