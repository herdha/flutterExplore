import 'package:fluthi/modules/Task/service/task_service.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart' as latlong;
import 'package:location/location.dart' as myLoc;

class MapTaskController extends GetxController {
  final TaskService taskService = TaskService();
  var mapControllerMapTask = MapController().obs;
  var point = latlong.LatLng(0,0).obs;
  List<Marker> markers = <Marker>[].obs;
  var newPoint = latlong.LatLng(-6.374923, 107.287439).obs;
  var cekGesture = true.obs;

  @override
  void onInit(){
    // getCurrentPosition();
    super.onInit();
  }
  
  getMarkingAddress(address) async {
    try{
      var response = await taskService.fetchLongLat(address);
      mapControllerMapTask.value.move(newPoint.value = latlong.LatLng(response![0].latitude, response[0].longitude), 16.0);
      newPoint.value = latlong.LatLng(response[0].latitude, response[0].longitude);
      // if(markers.isEmpty){
      //   markers.add(
      //     Marker(
      //       point: latlong.LatLng(response[0].latitude, response[0].longitude),
      //       child: const Icon(Icons.location_pin, color: Colors.red, size: 40),
      //     )
      //   );
      //   print(markers[0].point);
      // } else {
      //   markers.clear();
      // }
    } catch (err){
      print('Error in task controller: $err');
    }
  }

  getCurrentPosition() async {
    try{
      var response = await taskService.fetchCurrentPosition();
      myLoc.LocationData loc = response;
      mapControllerMapTask.value.move(point.value = latlong.LatLng(loc.latitude!, loc.longitude!), 12.0);
    } catch (err) {
      print('Error in task controller: $err');
    }
  }

  onPositionChanged() async {
    
  }
}