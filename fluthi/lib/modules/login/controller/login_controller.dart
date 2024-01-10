import 'package:fluthi/modules/login/model/driver_model.dart';
// import 'package:fluthi/modules/login/model/login_model.dart';
import 'package:fluthi/modules/login/service/login_service.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  List getData = <DriverModel>[].obs;
  var email = ''.obs;
  var password = ''.obs;
  var showPass = true.obs;
  var errorMessage = ''.obs;
  LoginService loginService = LoginService();

  @override
  void onInit(){
    callGetData();
    // getDataUser();
    super.onInit();
  }

  callGetData() async {
    try{
      var res = await loginService.getDataDriver();
      print('halo res $res');
      res != null ? getData.assignAll(res) : print('null');
    } finally {
      print('final');
    }
    update();
  }

  login(String emailController, String passwordController) async {
    try{
      var res = await loginService.loginService(emailController,passwordController);
      print('halooooo $res');
    } catch (err){
      return errorMessage.value = 'User Not found';
    }
    update();
  }

  // shoPass(){
  //   showPass.value ?
  //   showPass.value = false :
  //   showPass.value = true ;
  // }
}