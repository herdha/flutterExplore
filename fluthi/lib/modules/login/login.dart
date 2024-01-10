// import 'package:dio/dio.dart';
// import 'package:fluthi/config/api.dart';
import 'package:fluthi/modules/login/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(LoginController());
    final email = TextEditingController(text: 'superadmin@gmail.com');
    final password = TextEditingController(text: 'Admin123!');
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: LoadingOverlay(
          progressIndicator: const CircularProgressIndicator(color: Colors.blue,),
          isLoading: false,
          child: SizedBox(
            width: double.infinity,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // Expanded(
                  //   child: Obx(() {
                  //     return ListView.builder(
                  //       itemCount: controller.getData.length,
                  //       itemBuilder: (BuildContext context, int index){
                  //         var el = controller.getData[index];
                  //         return Container(
                  //           child: Column(
                  //             children: [
                  //               Text('${el.title} : ${el.total}')
                  //             ],
                  //           ),
                  //         );
                  //       } 
                  //     );
                  //   }),
                  // ),
                  Image.asset('assets/images/flutter.png', width: 80, height: 80,),
                  const SizedBox(height: 16,),
                  Text(
                    'Fluthi',
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue
                    )
                  ),
                  const SizedBox(height: 16,),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 16, right: 16),
                    child: TextFormField(
                      controller: email,
                      validator: (String? emailValue) {
                        var emailValid = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                        if (emailValue!.isEmpty){
                          return 'Email can not be empty';
                        } else if (!RegExp(emailValid).hasMatch(emailValue)) {
                          return 'Email is not valid';
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
                        hintText: 'e.x@mail.com',
                        hintStyle: GoogleFonts.inter(color: Colors.grey, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16,),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 16, right: 16),
                    child: Obx(() => 
                      TextFormField(
                        controller: password,
                        obscureText: controller.showPass.value,
                        validator: (String? passwordValue) {
                          // var uppercase = r'^(?=.*?[A-Z])';
                          // var lowercase = r'^(?=.*?[a-z])';
                          // var number = r'^(?=.*?[0-9])';
                          // var specialChar = r'^(?=.*?[!@#\$&*~])';
                          // RegExp regExp = new RegExp(validPass);
                          if (passwordValue!.isEmpty){
                            return 'Password can not be empty';
                          } 
                          else if(passwordValue.length <= 8){
                            return 'password at least 8 character';
                          } 
                          //else if(!RegExp(uppercase).hasMatch(passwordValue)){
                          //   return 'password must contains at least 1 uppercase';
                          // } else if(!RegExp(lowercase).hasMatch(passwordValue)){
                          //   return 'password must contains at least 1 lowercase';
                          // } else if(!RegExp(number).hasMatch(passwordValue)){
                          //   return 'password must contains at least 1 number';
                          // } else if(!RegExp(specialChar).hasMatch(passwordValue)){
                          //   return 'password must contains at least 1 special character';
                          // }
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
                          hintText: '********',
                          hintStyle: GoogleFonts.inter(color: Colors.grey, fontWeight: FontWeight.w400),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.showPass.value ? 
                              Icons.visibility : 
                              Icons.visibility_off,
                            ),
                            onPressed: (){
                              controller.showPass.value ?
                              controller.showPass.value = false :
                              controller.showPass.value = true;
                            },
                          )
                        ),
                      ),
                    )
                  ),
                  const SizedBox(height: 16,),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 16, right: 16),
                    child: FilledButton(
                      onPressed: (){
                        if(formKey.currentState!.validate()){
                          controller.login(email.text, password.text);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              margin: EdgeInsets.all(16),
                              behavior: SnackBarBehavior.floating,
                              duration: Duration(seconds: 1),
                              content: Text(controller.errorMessage.value),
                            )
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)
                        )
                      ),
                      child: Text('Login', style: GoogleFonts.inter(),),
                    ),
                  ),
                ],
              ),
            ),
          )
        ),
      ),
    );
    // var controller = Get.put(LoginController());
    // return SafeArea(
    //   child: Scaffold(
    //     body: Center(
    //       child: Column(
    //         children: [
    //           Expanded(
    //             child: Obx(() {
    //               return ListView.builder(
    //                 itemCount: controller.getData.length,
    //                 itemBuilder: (context, index){
    //                   var el = controller.getData[index];
    //                   return Text(
    //                     '${el.title} ${el.total}'
    //                   );
    //                 }
    //                 );
    //               // return Text(
    //               //   controller.getData.length.toString()
    //               // );
    //             })
    //           )
    //           // TextButton(onPressed: , child: Text('get')),
    //           // Text('Hasil :'),
    //           // Text(mydata != null ? mydata.toString() : '')
    //         ],
    //       ),
    //     ),
    //   )
    // );
  }

}

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
  
// }

// class _LoginState extends State<Login> {
//   List? mydata;
//   Future<dynamic> _getData() async {
//     try {
//       var response = await Api.request.get('/driver');
//       print(response.data);
//       setState(() {
//         mydata = response.data;
//       });
//     } on DioException catch (err) {
//       print(err.response!.statusMessage);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           children: [
//             TextButton(onPressed: _getData, child: Text('get')),
//             Text('Hasil :'),
//             Text(mydata != null ? mydata.toString() : '')
//           ],
//         ),
//       ),
//     );
//   }

// }