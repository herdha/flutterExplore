import 'package:dio/dio.dart';
import 'package:fluthi/config/api.dart';
import 'package:fluthi/modules/Task/model/task_detail_model.dart';
import 'package:fluthi/modules/Task/model/task_model.dart';
import 'package:fluthi/modules/Task/model/user_model.dart';
import 'package:geocoding/geocoding.dart' as geocode;
import 'package:get/get.dart';
import 'package:location/location.dart' as myLoc;
import 'package:mapbox_search/mapbox_search.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskService {
  Future<List<TaskModel>?> getAllTask() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('token');
    try{
      var res = await Api.request.get('/alltask', options: Options(headers: {'authorization': 'Bearer $userToken'}));
      List data = res.data;
      // print(data);
      return data.map((e) => TaskModel.fromJson(e)).toList();
    } on DioException catch (err) {
      print('cek service task ${err.toString()}');
    }
    return null;
  }

  Future<List<TaskModel>?> addTaskService(title, description, assignTo, startPoint, endPoint) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('token');
    
    List<geocode.Location> startLoc = await geocode.locationFromAddress(startPoint);
    List<geocode.Location> endLoc = await geocode.locationFromAddress(endPoint);
    
    var data = {
      'title': title,
      'description': description,
      'areaStart': {
        'location': startPoint,
        'long': startLoc[0].longitude,
        'lat': startLoc[0].latitude
      },
      'areaEnd': {
        'location': endPoint,
        'long': endLoc[0].longitude,
        'lat': endLoc[0].latitude
      },
      'assignTo': assignTo
    };

    try {
      // print(data);
      await Api.request
      .post('/addTask', data: data,
        options: Options(
          headers: {
            'authorization': 'Bearer $userToken'
          }
        )
      );
      Get.back();
    } on DioException catch (err) {
      print('add task ${err.response!}');
    }
    return null;
  }

  Future<List<Suggestion>?> fetchSuggestPlace (address) async {
    try {
      // if(address){
        SearchBoxAPI search = SearchBoxAPI(
          apiKey: 'pk.eyJ1IjoiaGVyZGhhIiwiYSI6ImNsbXB1cXM0ZzFub2MycnRjb280YzAzdmgifQ.XRPB_SOt1WwmFZ29sPZeVw',
          country: 'ID',
          limit: 4,
        );

        var searchPlace = await search.getSuggestions(address);
        return searchPlace.success!.suggestions;
    } catch (err) {
      print('Error in task service: $err');
    }
    return null;
  }
  Future<List<UserModel>?> fetchUser () async {
    try {
      var response = await Api.request.get('/getUser');
      List result = response.data;
      return result.map((e) => UserModel.fromJson(e)).toList();
    } on DioException catch (err) {
      print('Error in task service $err');
    }
    return null;
  }
  
  Future<TaskDetailModel?> fetchTaskDetail (id) async {
    try {
      var response = await Api.request.get('/getOneTask/$id');
      Map<String, dynamic> res = response.data;
      return TaskDetailModel.fromJson(res);
    } on DioException catch (err) {
      print('Error in task service $err');
    }
  }
  
  Future<List<geocode.Location>?> fetchLongLat(address) async {
    try {
      List<geocode.Location> location = await geocode.locationFromAddress(address);
      return location;
    } catch (err) {
      print('Error in task service: $err');
    }
  }
  
  fetchCurrentPosition() async {
    myLoc.Location location = myLoc.Location();
    bool isServiceEnabled;
    myLoc.PermissionStatus permissionGranted;
    myLoc.LocationData locationData;

    try{
      isServiceEnabled = await location.serviceEnabled();
      if (!isServiceEnabled) {
        isServiceEnabled = await location.requestService();
        if (!isServiceEnabled) {
          return;
        }
      }
    } catch (err) {
      print('Error : $err');
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == myLoc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != myLoc.PermissionStatus.granted) {
        return;
      }
    }
    
    return locationData = await location.getLocation();
    // print(locationData);
  }
  
  fetchRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('role');
  }

  fetchRuntask(id, lat, long) async {
    try{
      var data = {"lat": lat, "long": long};
      var response = await Api.request.put('/startTask/$id', data: data);
      Get.back();
      return response;
    } on DioException catch (err) {
      return err;
    }
  }

  fetchEndTask(id, note, lat, long) async {
    try{
      var data = {"lat": lat, "long": long, "note": note};
      var response = await Api.request.put('/endTask/$id', data: data);
      Get.back();
      return response;
    } on DioException catch (err) {
      return err;
    }
  }
}