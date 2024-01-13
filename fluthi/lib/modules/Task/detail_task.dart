import 'package:fluthi/modules/Task/controller/task_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';

class DetailTask extends StatelessWidget {
  const DetailTask({super.key});
  
  @override
  Widget build(BuildContext context) {
    var taskControl = Get.put(TaskController());
    final formState = GlobalKey<FormState>();
    final note = TextEditingController();
    return Obx(() =>
      Scaffold(
        appBar: AppBar(
          title: Text(taskControl.detailTask.value.title.toString()),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              child: Column(
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
                        // CircleLayer(circles: [
                        //   CircleMarker(point: LatLng(taskControl.detailTask.value.areaEnd != null ? taskControl.detailTask.value.areaEnd!.lat! : 0, taskControl.detailTask.value.areaEnd != null ? taskControl.detailTask.value.areaEnd!.long! : 0), radius: 20, color: Colors.red.shade200.withOpacity(.5))
                        // ]),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: LatLng(taskControl.detailTask.value.areaEnd != null ? taskControl.detailTask.value.areaEnd!.lat! : 0, taskControl.detailTask.value.areaEnd != null ? taskControl.detailTask.value.areaEnd!.long! : 0),
                              child: const Icon(Icons.location_pin, color: Colors.red,size: 35),
                            ),
                          ]
                        ),
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
                            Text(taskControl.detailTask.value.timeStart != '' ? taskControl.detailTask.value.timeStart.toString() : '-', style: const TextStyle(color: Colors.grey, fontSize: 12,)),
                          ],
                        ),
                        const SizedBox(height: 4,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Time End :', style: TextStyle(color: Colors.grey, fontSize: 12,)),
                            Text(taskControl.detailTask.value.timeEnd != '' ? taskControl.detailTask.value.timeEnd.toString() : '-', style: const TextStyle(color: Colors.grey, fontSize: 12,)),
                          ],
                        ),
                        const SizedBox(height: 4,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Duration :', style: TextStyle(color: Colors.grey, fontSize: 12,)),
                            Text(taskControl.detailTask.value.timeTotal != '' ? taskControl.detailTask.value.timeTotal.toString() : '-', style: const TextStyle(color: Colors.grey, fontSize: 12,)),
                          ],
                        ),
                        const SizedBox(height: 4,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Note :', style: TextStyle(color: Colors.grey, fontSize: 12,)),
                            Text(taskControl.detailTask.value.note != '' ? taskControl.detailTask.value.note.toString() : '-', style: const TextStyle(color: Colors.grey, fontSize: 12,)),
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
                  const SizedBox(height: 60,),
                  Container(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        taskControl.role.value == 'User Biasa' ?
                        Container(
                          width: double.infinity,
                          child: taskControl.detailTask.value.statusTask == 'On' ?
                            FilledButton(
                              onPressed: (){
                                taskControl.runTask(taskControl.detailTask.value.sId.toString(), context);
                              },
                              style: ElevatedButton.styleFrom(
                              fixedSize: const Size(double.infinity, 20),
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)
                              )
                            ),
                              child: Text('Run Task')
                            ) : taskControl.detailTask.value.statusTask == 'Running' ?
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Note', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,),),
                                  const SizedBox(height: 4,),
                                  Form(
                                    key: formState,
                                    child: TextFormField(
                                      controller: note,
                                      validator: (value){
                                        if(value!.isEmpty){
                                          return 'Fill the note please';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        focusedErrorBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.pink
                                            )
                                          ),
                                          errorBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.pink
                                            )
                                          ),
                                          focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.blue
                                            )
                                          ),
                                          border: InputBorder.none,
                                          enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.grey)
                                          ),
                                        hintText: 'Note: received by',
                                        hintStyle: GoogleFonts.inter(color: Colors.grey, fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4,),
                                  FilledButton(
                                    onPressed: (){
                                      if(formState.currentState!.validate()){
                                        taskControl.endTask(taskControl.detailTask.value.sId.toString(), note.text, context);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                    // fixedSize: const Size(double.infinity, 20),
                                    minimumSize: Size.fromHeight(40),
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)
                                    )
                                  ),
                                    child: Text('End Task')
                                  )
                                ],
                              ),
                            ) :
                            FilledButton(
                              onPressed: (){
                                // taskControl.runTask(taskControl.detailTask.value.sId.toString(), context);
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(double.infinity, 20),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)
                                ),
                                side: BorderSide(color: Colors.grey)
                              ),
                              child: Text('Done', style: GoogleFonts.inter(color: Colors.grey),)
                            )
                        ) : 
                        Container()
                      ],
                    )
                  )
                ],
              ),
            ),
          ),
        )
      )
    );
  }
}