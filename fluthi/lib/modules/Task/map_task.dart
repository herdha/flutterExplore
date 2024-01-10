import 'package:fluthi/modules/Task/controller/map_task_controller.dart';
import 'package:fluthi/modules/Task/controller/task_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class MapTask extends StatelessWidget {
  const MapTask({super.key});

  @override
  Widget build(BuildContext context) {
    var taskControll = Get.put(TaskController());
    var mapTaskControll = Get.put(MapTaskController());
    String? startPoint;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(125),
        child: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: const Text('Set Location', style: TextStyle(color: Colors.white),),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.check,
                color: Colors.white,
              ),
              onPressed: (){print('check');},
            )
          ],
          backgroundColor: Colors.blue,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Autocomplete<String>(
                  fieldViewBuilder: (BuildContext context,
                  TextEditingController fieldStartPoint,
                  FocusNode fieldFocusNode,
                  VoidCallback onFieldSubmitted){
                    return TextFormField(
                      style: const TextStyle(fontSize: 14),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.pink
                          )
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.pink
                          )
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue
                          )
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)
                        ),
                        border: InputBorder.none,
                        hintText: 'Start point',
                        hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
                        contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10)
                      ),
                      controller: fieldStartPoint,
                      focusNode: fieldFocusNode,
                    );
                  },
                  optionsBuilder: (TextEditingValue startPointOption) {
                    startPoint = startPointOption.text;
                    taskControll.getSugestPlace(startPointOption.text);
                    // return taskControll.optionPlace;
                    if (startPointOption.text == '') {
                      return const Iterable<String>.empty();
                    }
                    else {
                      List<String> place = <String>[];
                      for (var el in taskControll.placeSugest) {
                        place.add("${el.name} ${el.placeFormatted}");
                      }
                      return place;
                    }
                  },
                  optionsViewBuilder: (context, Function(String) onSelected, options){
                    return Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          width: MediaQuery.of(context).size.width - 32,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(4)
                          ),
                          child: Wrap(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                // padding: const EdgeInsets.all(8.0),
                                itemCount: options.length,
                                itemBuilder: (context, index)=>InkWell(
                                  onTap: (){
                                    onSelected(options.elementAt(index).toString());
                                    mapTaskControll.getMarkingAddress(options.elementAt(index).toString());
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(options.elementAt(index).toString()),
                                      ],
                                    ),
                                  ),
                                )
                              ),
                            ],
                          ),
                        ),
                      )
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SafeArea(
          child: FlutterMap(
            mapController: mapTaskControll.mapControllerMapTask.value,
            options: MapOptions(
              initialCenter: mapTaskControll.newPoint.value,
              initialZoom: 12.0,
              onPositionChanged: (point, isGesture){
                // mapTaskControll.cekGesture.value = isGesture;
                mapTaskControll.newPoint.value = point.center!;
                // if(isGesture){
                //   print('point : ${mapTaskControll.newPoint.value}');
                // }
                // print(point.center);
              }
            ),
            children: [
              TileLayer(
                urlTemplate:
                  'https://api.mapbox.com/styles/v1/herdha/clqq2u1pe00v801pj44yl27l1/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiaGVyZGhhIiwiYSI6ImNrN2JkcnVxdTEzcGgzbG51Z2IycHgwcHIifQ.mm9XLuAVnZc4lzAUwtJY1A',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: mapTaskControll.newPoint.value, 
                    child: const Icon(Icons.location_pin, color: Colors.red, size: 40),
                  )
                ],
              ),
            ]
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){ mapTaskControll.getCurrentPosition(); print('centering my position');},
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: const Icon(Icons.my_location, color: Colors.blue,),
      ),
    );
  }

}