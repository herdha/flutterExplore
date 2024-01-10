import 'package:dio/dio.dart';
import 'package:fluthi/modules/login/model/driver_model.dart';
// import 'package:fluthi/modules/login/model/login_model.dart';
import 'package:fluthi/modules/login/service/login_service.dart';
import 'package:flutter/material.dart';
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

  login(String emailController, String passwordController, BuildContext context) async {
    try{
      var res = await loginService.loginService(emailController,passwordController);
      if(res is DioException){
        throw res;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            margin: EdgeInsets.all(16),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 1),
            content: Text('Login success'),
          )
        );
        update();
      }
    } on DioException catch (err){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          margin: EdgeInsets.all(16),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
          content: Text(err.response!.data['message'].toString()),
        )
      );
      update();
    }
  }

  // shoPass(){
  //   showPass.value ?
  //   showPass.value = false :
  //   showPass.value = true ;
  // }
}