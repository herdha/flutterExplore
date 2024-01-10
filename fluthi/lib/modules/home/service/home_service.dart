import 'package:dio/dio.dart';
import 'package:fluthi/config/api.dart';
import 'package:fluthi/routes/routes.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeService {
  Future<void> logoutService() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    
    try {
      var logout = await Api.request.get('/logout/$token');
      await prefs.clear();
      print(logout.data);
      Get.offNamed(AppRoutes.login);
    } on DioException catch (err){
      print(err.message!);
    }
  }

  Future<Map<String,dynamic>?> getDataUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? name = prefs.getString('name');
    return {
      'name': name,
    };
  }
}