import 'package:fluthi/modules/Task/add_task.dart';
import 'package:fluthi/modules/Task/map_task.dart';
import 'package:fluthi/modules/Task/detail_task.dart';
import 'package:fluthi/modules/home/home.dart';
import 'package:fluthi/modules/login/login.dart';
import 'package:fluthi/modules/main/main_page.dart';
import 'package:fluthi/modules/splashScreen/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  // route name
  static const String initalRoute = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String main = '/main';
  static const String addtask = '/addtask';
  static const String maptask = '/maptask';
  static const String detailtask = '/detailtask';

  static List<GetPage> pages = [
    GetPage(
      name: maptask,
      page: () =>  const MapTask()
    ),
    GetPage(
      name: detailtask,
      page: () =>  const DetailTask()
    ),
    GetPage(
      name: addtask,
      page: () =>  const AddTask()
    ),
    GetPage(
      name: main,
      page: () =>  MainPage()
    ),
    GetPage(
      name: home,
      page: () =>  const Home()
    ),
    GetPage(
      name: login,
      page: () => const Login()
    ),
    GetPage(
      name: initalRoute,
      page: () => const SplachScreen()
    )
  ];
}