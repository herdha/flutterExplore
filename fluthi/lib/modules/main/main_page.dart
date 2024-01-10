import 'package:fluthi/modules/Task/task.dart';
import 'package:fluthi/modules/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:fluthi/modules/main/controller/main_controller.dart';

class MainPage extends StatelessWidget {
  final mainControl = Get.put(MainController());

  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: const Text('Home Page'),
      // ),
      body: Obx(() {
        switch (mainControl.currentIndex.value) {
          case 0:
            return const Home();
          case 1:
            return const Task();
          case 2:
            return const Center(child: Text('Settings Content'));
          default:
            return const Home();
        }
      }),
      bottomNavigationBar: Obx(() => 
        BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12.0,
          unselectedFontSize: 12.0,
          currentIndex: mainControl.currentIndex.value,
          onTap: mainControl.changePage,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books),
              label: 'Task',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      )
    );
  }
}