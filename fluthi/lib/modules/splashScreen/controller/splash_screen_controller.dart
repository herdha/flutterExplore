import 'package:fluthi/modules/splashScreen/service/splash_screen_service.dart';
import 'package:get/get.dart';

class SplachScreenController extends GetxController {
  SplachScreenService splachScreenService = SplachScreenService();

  @override
  void onInit() {
    autoLoginControl();
    super.onInit();
  }
  
  autoLoginControl() async {
    await splachScreenService.autoLogin();  
  }
}