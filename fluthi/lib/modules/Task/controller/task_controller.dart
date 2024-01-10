import 'package:dio/dio.dart';
import 'package:fluthi/modules/Task/model/task_detail_model.dart';
import 'package:fluthi/modules/Task/model/task_model.dart';
import 'package:fluthi/modules/Task/model/user_model.dart';
import 'package:fluthi/modules/Task/service/task_service.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
// import 'package:location/location.dart' as myLoc;
import 'package:mapbox_search/mapbox_search.dart';
import 'package:latlong2/latlong.dart';

class TaskController extends GetxController {
  final TaskService taskService = TaskService();
  List data = <TaskModel>[].obs;
  List placeSugest = <Suggestion>[].obs;
  List user = <UserModel>[].obs;
  var detailTask = TaskDetailModel().obs;
  var lat = 0.0.obs;
  var long = 0.0.obs;
  var mapController = MapController().obs;
  var mapControllerMapTask = MapController().obs;
  var point = LatLng(0, 0).obs;
  List<Marker> markers = <Marker>[].obs;
  var role = ''.obs;
  var message = ''.obs;

  @override
  void onInit(){
    getAllDataTask();
    getRole();
    super.onInit();
  }

  getAllDataTask() async {
    try{
      var res = await taskService.getAllTask();
      res != null ?
      data.assignAll(res) :
      print('halooo  null');
    } catch (err) {
      print('cek controller ${err.toString()}');
    }
  }

  addTask(title, description, assignTo, startPoint, endPoint) async {
    var getuser = user.where((element) => element.username == assignTo);
    var getUserId = getuser.toList()[0].sId;
    await taskService.addTaskService(title, description, getUserId, startPoint, endPoint);
    getAllDataTask();
    update();
  }

  getSugestPlace(String address) async {
    if(address.isNotEmpty){
      try {
        var res = await taskService.fetchSuggestPlace(address);
        res != null ?
        placeSugest.assignAll(res) :
        print('halooo  null');
        update();

      } catch (err){
        print('Error in task controller: $err');
      }
    } else {
      placeSugest.clear();
      update();
    }
  }
  getUser() async {
    try {
      var res = await taskService.fetchUser();
      res != null ?
      user.assignAll(res) :
      user.clear();
    } catch (err) {
      print('Error in task controller: $err');
    }
  }

  getDetailTask(id) async {
    try {
      var res = await taskService.fetchTaskDetail(id);
      detailTask.value = res!;
      if(detailTask.value.areaEnd != null){
        lat.value = detailTask.value.areaEnd!.lat!;
        long.value = detailTask.value.areaEnd!.long!;
      }
      mapController.value.move(point.value = LatLng(lat.value, long.value), 13.0);
    } catch (err) {
      print('Error in task controller: $err');
    }
  }

  getRole() async {
    try {
      String res = await taskService.fetchRole();
      role.value = res;
    } catch (err) {
      print('Error in task controller: $err');
    }
  }
  
  runTask(String id, BuildContext context) async {
    try {
      var res = await taskService.fetchRuntask(id);
      if(res is DioException){
        throw res;        
      } else {
        getAllDataTask();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            margin: EdgeInsets.all(16),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 1),
            content: Text(res.toString()),
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
          content: Text(err.response.toString()),
        )
      );
    }
  }

  // getLongLat(address) async {
  //   try {
  //     var response = await taskService.fetchLongLat(address);
  //     print('ini responya $response');
  //     mapControllerMapTask.value.move(point.value = LatLng(response![0].latitude, response[0].longitude), 16.0);
  //     if(markers.isEmpty){
  //       markers.add(
  //         Marker(
  //           point: LatLng(response[0].latitude, response[0].longitude),
  //           child: const Icon(Icons.location_pin, color: Colors.red, size: 40),
  //         )
  //       );
  //     } else {
  //       markers.clear();
  //     }      
  //     print('ini marker ${markers.toString()}');
  //   } catch (err) {
  //     print('Error in task controller: $err');
  //   }
  // }

  // getCurrentPosition() async {
  //   try{
  //     var response = await taskService.fetchCurrentPosition();
  //     myLoc.LocationData loc = response;
  //     mapControllerMapTask.value.move(point.value = LatLng(loc.latitude!, loc.longitude!), 12.0);
  //     print('my current position : $loc');
  //   } catch (err) {
  //     print('Error in task controller: $err');
  //   }
  // }
}