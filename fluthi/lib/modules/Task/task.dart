import 'package:fluthi/modules/Task/controller/task_controller.dart';
import 'package:fluthi/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Task extends StatelessWidget {
  const Task({super.key});

  @override
  Widget build(BuildContext context) {
    var taskControl = Get.put(TaskController());
    taskControl.getAllDataTask();
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Task'),
      ),
      body: SafeArea(
        child: SizedBox(
          child: Column(
            children: [              
              Expanded(
                child: Obx(() => 
                  taskControl.data.isEmpty ? 
                  const Center(
                      child: CircularProgressIndicator(),
                  ) :
                  ListView.separated(
                    itemCount: taskControl.data.length,
                    separatorBuilder: (context, index){ return Container(margin: const EdgeInsets.only(left: 16,right: 16), height: 1, color: const Color(0xffe5e5e5),);},
                    itemBuilder: (context, index){
                      var data = taskControl.data[index];
                      // print(data);
                      return InkWell(
                        onTap: (){
                          taskControl.getDetailTask(data.sId);
                          Get.toNamed(AppRoutes.detailtask);
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: taskControl.data.length - 1 == index ? 80 : 0),
                          padding: const EdgeInsets.all(16),
                          // color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(data.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600,),),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    margin: const EdgeInsets.only(left: 8),
                                    decoration: BoxDecoration(
                                      color: data.statusTask == 'On' ?
                                              Colors.blue : data.statusTask == 'Off' ?
                                              Colors.red : Colors.amber,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      data.statusTask,
                                      style: const TextStyle(
                                        fontSize: 8, 
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        height: 1.2                                             
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 4,),
                              Text(data.description, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w200, color: Color(0xff555555)),),
                              const SizedBox(height: 4,),
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(right: 6),
                                    child: Icon(
                                      Icons.assignment_ind,
                                      color: Colors.blue,
                                      size: 14,
                                    ),
                                  ),
                                  Text(data.assignTo.username, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w200, color: Color(0xff555555)),),
                                ],
                              ),
                              // const SizedBox(height: 10,),
                              // Divider(color: Color(0xffe5e5e5), height: 1,),
                              const SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    constraints: const BoxConstraints(maxWidth: 100),
                                    child: Text(
                                      data.areaStart.areaName.length >= 16 ?
                                      '${data.areaStart.areaName.toString().substring(0,13)}...' :
                                      data.areaStart.areaName, 
                                      style: const TextStyle(
                                        fontSize: 10, 
                                        fontWeight: FontWeight.w200, 
                                        color: Color(0xff555555)
                                      )
                                    )
                                  ),
                                  const Icon(
                                    Icons.double_arrow_rounded, 
                                    color: Colors.blue,
                                    size: 20,
                                  ),
                                  Container(
                                    constraints: const BoxConstraints(maxWidth: 100),
                                    child: Text(
                                      data.areaEnd.areaName.length >= 16 ?
                                      '${data.areaEnd.areaName.toString().substring(0,13)}...' :
                                      data.areaEnd.areaName,
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                        fontSize: 10, 
                                        fontWeight: FontWeight.w200, 
                                        color: Color(0xff555555)
                                      )
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  )
                )
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Obx(() => 
        taskControl.role.value == 'Super Admin' ?
        FloatingActionButton(onPressed: (){Get.toNamed(AppRoutes.addtask);},child: const Icon(Icons.add),) : 
        Container()
      )
    );
  }

}