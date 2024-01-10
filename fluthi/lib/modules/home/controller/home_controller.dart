import 'package:fluthi/modules/home/service/home_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  HomeService homeService = HomeService();

  
  logout() async {
    try {
      await homeService.logoutService();
    } finally {
      print('final');
    }
  }
}