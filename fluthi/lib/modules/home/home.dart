import 'package:fluthi/modules/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var homeCont = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text('Home', style: GoogleFonts.inter(color: Colors.blue, fontSize: 24, fontWeight: FontWeight.w700),),
              FilledButton(
                onPressed: (){homeCont.logout(context);},
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(double.infinity, 20),
                  // padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)
                  )
                ), 
                child: Text(
                  'Logout', 
                  style: GoogleFonts.inter(
                    color: Colors.white, 
                    fontSize: 16, 
                    fontWeight: FontWeight.w500
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}