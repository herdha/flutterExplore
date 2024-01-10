import 'package:fluthi/routes/routes.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplachScreenService {
  Future<void> autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    // print('cek token splash: $token');

    if(token != null){
      Future.delayed(const Duration(seconds: 1),(){
        Get.offNamed(AppRoutes.main);
      });
    } else {
      Future.delayed(const Duration(seconds: 1),(){
        Get.offNamed(AppRoutes.login);
      });
    }
  }
}