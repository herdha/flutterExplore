import 'package:fluthi/modules/Task/controller/task_controller.dart';
import 'package:fluthi/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTask extends StatelessWidget {
  const AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    var taskControll = Get.put(TaskController());
    final titleTask = TextEditingController();
    final descTask = TextEditingController();
    String? assignTo;
    String? startPoint;
    String? endPoint;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Form(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: TextFormField(
                    style: const TextStyle(fontSize: 14),
                    controller: titleTask,
                    validator: (String? titleValue) {
                      if (titleValue!.isEmpty){
                        return 'Title can not be empty';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      focusedErrorBorder:const OutlineInputBorder(
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
                      // border: Border.all(color: Colors.red),
                      hintText: 'Task title',
                      hintStyle: GoogleFonts.inter(color: Colors.grey, fontWeight: FontWeight.w400),
                      contentPadding: const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10)
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: TextFormField(
                    style: const TextStyle(fontSize: 14),
                    controller: descTask,
                    validator: (String? titleValue) {
                      if (titleValue!.isEmpty){
                        return 'Description can not be empty';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      focusedErrorBorder:const OutlineInputBorder(
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
                      // border: Border.all(color: Colors.red),
                      hintText: 'Task description',
                      hintStyle: GoogleFonts.inter(color: Colors.grey, fontWeight: FontWeight.w400),
                      contentPadding: const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10)
                    ),
                  ),
                ),
                // Container(
                //   alignment: Alignment.centerLeft,
                //   margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                //   child: TextFormField(
                //     style: const TextStyle(fontSize: 14),
                //     controller: assignTo,
                //     validator: (String? titleValue) {
                //       if (titleValue!.isEmpty){
                //         return 'Assignment can not be empty';
                //       }
                //       return null;
                //     },
                //     decoration: InputDecoration(
                //       focusedErrorBorder:const OutlineInputBorder(
                //         borderSide: BorderSide(
                //           color: Colors.pink
                //         )
                //       ),
                //       errorBorder: const OutlineInputBorder(
                //         borderSide: BorderSide(
                //           color: Colors.pink
                //         )
                //       ),
                //       focusedBorder: const OutlineInputBorder(
                //         borderSide: BorderSide(
                //           color: Colors.blue
                //         )
                //       ),
                //       border: InputBorder.none,
                //       enabledBorder: const OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.grey)
                //       ),
                //       // border: Border.all(color: Colors.red),
                //       hintText: 'Assign To',
                //       hintStyle: GoogleFonts.inter(color: Colors.grey, fontWeight: FontWeight.w400),
                //       contentPadding: const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10)
                //     ),
                //   ),
                // ),
                // Container(
                //   alignment: Alignment.centerLeft,
                //   margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                //   child: Column(
                //     children: [
                //       TextFormField(
                //         style: const TextStyle(fontSize: 14),
                //         controller: startPoin,
                //         onChanged: (String query)=>{taskControll.getSugestPlace(query)},
                //         decoration: InputDecoration(
                //           focusedErrorBorder:const OutlineInputBorder(
                //             borderSide: BorderSide(
                //               color: Colors.pink
                //             )
                //           ),
                //           errorBorder: const OutlineInputBorder(
                //             borderSide: BorderSide(
                //               color: Colors.pink
                //             )
                //           ),
                //           focusedBorder: const OutlineInputBorder(
                //             borderSide: BorderSide(
                //               color: Colors.blue
                //             )
                //           ),
                //           border: InputBorder.none,
                //           enabledBorder: const OutlineInputBorder(
                //             borderSide: BorderSide(color: Colors.grey)
                //           ),
                //           // border: Border.all(color: Colors.red),
                //           hintText: 'Set starting point',
                //           hintStyle: GoogleFonts.inter(color: Colors.grey, fontWeight: FontWeight.w400),
                //           contentPadding: const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10)
                //         ),
                //       ),
                //       Obx(() => 
                //         taskControll.placeSugest.isNotEmpty ?
                //         Container(
                //           margin: const EdgeInsets.only(top: 6),
                //           // padding: const EdgeInsets.only(left: 10, right: 10),
                //           decoration: BoxDecoration(
                //             color: Color(0xfffff),
                //             border: Border.all(width: 1, color: Colors.grey),
                //             borderRadius: BorderRadius.circular(4)
                //           ),
                //           child: ListView.builder(
                //             shrinkWrap: true,
                //             scrollDirection: Axis.vertical,
                //             // separatorBuilder: (context, index){ return Container(height: 1, color: Colors.grey);},
                //             itemCount: taskControll.placeSugest.length,
                //             itemBuilder: (context, index)=> ListTile(
                //               subtitle: Container(
                //                 margin: const EdgeInsets.only(left: 0, right: 0, top: 4, bottom: 4), 
                //                 child: Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     Text(taskControll.placeSugest[index].name.toString()),
                //                     Text(taskControll.placeSugest[index].placeFormatted.toString())
                //                   ],
                //                 )
                //               ),
                //               onTap: (){},
                //             ),
                //           ),
                //         ) : 
                //         Container()
                //       )
                //     ],
                //   )
                // ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: Autocomplete<String>(
                    fieldViewBuilder: (BuildContext context,
                    TextEditingController fieldAssignTo,
                    FocusNode fieldFocusNode,
                    VoidCallback onFieldSubmitted){
                      return TextFormField(
                        style: const TextStyle(fontSize: 14),
                        decoration: const InputDecoration(
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
                            borderSide: BorderSide(color: Colors.grey)
                          ),
                          border: InputBorder.none,
                          hintText: 'Assign To',
                          hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
                          contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10)
                        ),
                        controller: fieldAssignTo,
                        focusNode: fieldFocusNode,
                      );
                    },
                    optionsBuilder: (TextEditingValue assignToOption) {
                      assignTo = assignToOption.text;
                      taskControll.getUser();
                      // return taskControll.optionPlace;
                      if (assignToOption.text == '') {
                        return const Iterable<String>.empty();
                      }
                      else {
                        var userbiasa = taskControll.user.where((el) => el.role != 'Super Admin');
                        List<String> user = <String>[];
                        for (var el in userbiasa) {
                          user.add("${el.username}");
                        }
                        return user.where((String user) => user.contains(assignToOption.text.toLowerCase()));
                        // return user;
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
                            borderSide: BorderSide(color: Colors.grey)
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
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: Autocomplete<String>(
                    fieldViewBuilder: (BuildContext context,
                    TextEditingController fieldEndPoint,
                    FocusNode fieldFocusNode,
                    VoidCallback onFieldSubmitted){
                      return TextFormField(
                        style: const TextStyle(fontSize: 14),
                        decoration: const InputDecoration(
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
                            borderSide: BorderSide(color: Colors.grey)
                          ),
                          border: InputBorder.none,
                          hintText: 'End point',
                          hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
                          contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10)
                        ),
                        controller: fieldEndPoint,
                        focusNode: fieldFocusNode,
                      );
                    },
                    optionsBuilder: (TextEditingValue endPointOption) {
                      endPoint = endPointOption.text;
                      taskControll.getSugestPlace(endPointOption.text);
                      // return taskControll.optionPlace;
                      if (endPointOption.text == '') {
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
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  padding: EdgeInsets.only(top: 14, bottom: 14, left: 10, right: 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(4)
                  ),
                  child: GestureDetector(
                    onTap: (){Get.toNamed(AppRoutes.maptask);},
                    child: Text('Set start location', style: TextStyle(color: Colors.grey),),
                  )
                ),
                // Container(
                //   alignment: Alignment.centerLeft,
                //   margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Container(
                //         margin: const EdgeInsets.only(bottom: 10,),
                //         child: const Row(
                //           children: [
                //             Icon(
                //               Icons.radio_button_checked,
                //               color: Colors.blue,
                //             ),
                //             SizedBox(width: 16,),
                //             Text('Bandung')
                //           ],
                //         ),
                //       ),
                //       Container(
                //         margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                //         height: 100,
                //         decoration: const BoxDecoration(
                //           border: Border(left: BorderSide(width: 4, style: BorderStyle.solid, color: Colors.blue))
                //         ),
                //       ),
                //       Container(
                //         margin: const EdgeInsets.only(bottom: 16,),
                //         child: const Row(
                //           children: [
                //             Icon(
                //               Icons.radio_button_checked,
                //               color: Colors.blue,
                //             ),
                //             SizedBox(width: 16,),
                //             Text('Jakarta')
                //           ],
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: FilledButton(
                    onPressed: (){
                      taskControll.addTask(titleTask.text, descTask.text, assignTo, startPoint, endPoint);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)
                      )
                    ),
                    child: Text('Submit', style: GoogleFonts.inter(),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}