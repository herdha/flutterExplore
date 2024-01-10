import 'package:dio/dio.dart';

class Api {
  // static const _baseUrl = 'http://localhost:8080/'; /*for windows emulator*/
  static const _baseUrl = 'http://10.0.2.2:8080/'; /*for android virtual device*/

  static Map<String, dynamic> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json'
  };

  static Dio request = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      headers: headers
    )
  );
}