import 'package:dio/dio.dart';
import 'package:fluthi/modules/home/service/home_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  HomeService homeService = HomeService();

  
  logout(BuildContext context) async {
    try {
      var res = await homeService.logoutService();
      if(res is DioException){
        throw res;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            margin: EdgeInsets.all(16),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 1),
            content: Text(res['message']),
          )
        );
        update();
      }
    } on DioException catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          margin: EdgeInsets.all(16),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
          content: Text(err.response!.data.toString()),
        )
      );
    }
  }
}