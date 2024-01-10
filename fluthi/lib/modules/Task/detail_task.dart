import 'package:fluthi/modules/Task/controller/task_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class DetailTask extends StatelessWidget {
  const DetailTask({super.key});
  
  @override
  Widget build(BuildContext context) {
    var taskControl = Get.put(TaskController());
    return Obx(() =>
      Scaffold(
        appBar: AppBar(
          title: Text(taskControl.detailTask.value.title.toString()),
        ),
        body: SafeArea(
          child: Container(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 250,
                      child: FlutterMap(
                        mapController: taskControl.mapController.value,
                        options: MapOptions(
                          initialCenter: LatLng(taskControl.detailTask.value.areaEnd != null ? taskControl.detailTask.value.areaEnd!.lat! : 0, taskControl.detailTask.value.areaEnd != null ? taskControl.detailTask.value.areaEnd!.long! : 0),
                          onMapReady: () {
                            taskControl.mapController.value.mapEventStream.listen((event) {
                              taskControl.mapController.value.move(LatLng(taskControl.detailTask.value.areaEnd != null ? taskControl.detailTask.value.areaEnd!.lat! : 0, taskControl.detailTask.value.areaEnd != null ? taskControl.detailTask.value.areaEnd!.long! : 0), 12);
                            });
                          }
                        ),
                        children: [
                          TileLayer(
                            urlTemplate: 'https://api.mapbox.com/styles/v1/herdha/clqq2u1pe00v801pj44yl27l1/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiaGVyZGhhIiwiYSI6ImNrN2JkcnVxdTEzcGgzbG51Z2IycHgwcHIifQ.mm9XLuAVnZc4lzAUwtJY1A',
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: LatLng(taskControl.detailTask.value.areaEnd != null ? taskControl.detailTask.value.areaEnd!.lat! : 0, taskControl.detailTask.value.areaEnd != null ? taskControl.detailTask.value.areaEnd!.long! : 0),
                                child: const Icon(Icons.location_pin, color: Colors.red,size: 35),
                              ),
                              // Marker(
                              //   point: LatLng(taskControl.detailTask.value.areaStart != null ? taskControl.detailTask.value.areaStart!.lat! : 0, taskControl.detailTask.value.areaStart != null ? taskControl.detailTask.value.areaStart!.long! : 0),
                              //   child: Icon(Icons.pin_drop, color: Colors.red,size: 35),
                              // ),
                            ]
                          )
                        ]
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Description', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,),),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                margin: const EdgeInsets.only(left: 8),
                                decoration: BoxDecoration(
                                  color: taskControl.detailTask.value.statusTask == 'On' ?
                                          Colors.blue : taskControl.detailTask.value.statusTask == 'Off' ?
                                          Colors.red : Colors.amber,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  taskControl.detailTask.value.statusTask.toString(),
                                  style: const TextStyle(
                                    fontSize: 10, 
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    height: 1.2                                             
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 4,),
                          Text(taskControl.detailTask.value.description.toString(), style: const TextStyle(color: Colors.grey, fontSize: 12,),),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Additional Information', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,),),
                          const SizedBox(height: 4,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Assigned by :', style: TextStyle(color: Colors.grey, fontSize: 12,)),
                              Text(taskControl.detailTask.value.assignBy != null ? taskControl.detailTask.value.assignBy!.username.toString() : '', style: const TextStyle(color: Colors.grey, fontSize: 12,)),
                            ],
                          ),
                          const SizedBox(height: 4,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Assign To :', style: TextStyle(color: Colors.grey, fontSize: 12,)),
                              Text(taskControl.detailTask.value.assignTo != null ? taskControl.detailTask.value.assignTo!.username.toString() : '', style: const TextStyle(color: Colors.grey, fontSize: 12,)),
                            ],
                          ),
                          const SizedBox(height: 4,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Time Start :', style: TextStyle(color: Colors.grey, fontSize: 12,)),
                              Text(taskControl.detailTask.value.timeStart != null ? taskControl.detailTask.value.timeStart.toString() : '-', style: const TextStyle(color: Colors.grey, fontSize: 12,)),
                            ],
                          ),
                          const SizedBox(height: 4,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Time End :', style: TextStyle(color: Colors.grey, fontSize: 12,)),
                              Text(taskControl.detailTask.value.timeEnd != null ? taskControl.detailTask.value.timeEnd.toString() : '-', style: const TextStyle(color: Colors.grey, fontSize: 12,)),
                            ],
                          ),
                          const SizedBox(height: 4,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Duration :', style: TextStyle(color: Colors.grey, fontSize: 12,)),
                              Text(taskControl.detailTask.value.timeTotal != null ? taskControl.detailTask.value.timeTotal.toString() : '-', style: const TextStyle(color: Colors.grey, fontSize: 12,)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Route', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,),),
                          const SizedBox(height: 4,),
                          Text(taskControl.detailTask.value.areaStart != null ? taskControl.detailTask.value.areaStart!.areaName.toString() : '', style: const TextStyle(color: Colors.grey, fontSize: 12,)),
                          const SizedBox(height: 10,),
                          const Text('To', style: TextStyle(fontSize: 10,)),
                          const SizedBox(height: 10,),
                          Text(taskControl.detailTask.value.areaEnd != null ? taskControl.detailTask.value.areaEnd!.areaName.toString() : '', style: const TextStyle(color: Colors.grey, fontSize: 12,)),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     const Text('From :', style: TextStyle(color: Colors.grey, fontSize: 12,)),
                          //     Text(taskControl.detailTask.value.areaStart != null ? taskControl.detailTask.value.areaStart!.areaName.toString() : '', style: const TextStyle(color: Colors.grey, fontSize: 12,)),
                          //   ],
                          // ),
                          // const SizedBox(height: 4,),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     const Text('To :', style: TextStyle(color: Colors.grey, fontSize: 12,)),
                          //     Text(taskControl.detailTask.value.areaEnd != null ? taskControl.detailTask.value.areaEnd!.areaName.toString() : '', style: const TextStyle(color: Colors.grey, fontSize: 12,)),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0, 
                  child: taskControl.role.value == 'User Biasa' ?
                    Container(
                      margin: EdgeInsets.only(left: 16, right: 16, bottom: 10),
                      child: taskControl.detailTask.value.statusTask == 'On' ?
                        FilledButton(
                          onPressed: (){
                            taskControl.runTask(taskControl.detailTask.value.sId.toString(), context);
                          },
                          style: ElevatedButton.styleFrom(
                          fixedSize: const Size(300, 20),
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)
                          )
                        ),
                          child: Text('Run Task')
                        ) : taskControl.detailTask.value.statusTask == 'Running' ?
                        FilledButton(
                          onPressed: (){
                            // taskControl.runTask(taskControl.detailTask.value.sId.toString(), context);
                          },
                          style: ElevatedButton.styleFrom(
                          fixedSize: const Size(300, 20),
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)
                          )
                        ),
                          child: Text('End Task')
                        ) :
                        FilledButton(
                          onPressed: (){
                            // taskControl.runTask(taskControl.detailTask.value.sId.toString(), context);
                          },
                          style: ElevatedButton.styleFrom(
                          fixedSize: const Size(300, 20),
                          backgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)
                          )
                        ),
                          child: Text('Done')
                        )
                    ) : 
                    Container()
                )
              ],
            )
          ),
        ),
      )
    );
  }
}