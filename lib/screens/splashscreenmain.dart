import 'dart:async';

import 'package:flutter/material.dart';
import 'package:main_project/screens/otplogin.dart';

class SplashScreennew extends StatefulWidget {
  const SplashScreennew({super.key});

  @override
  State<SplashScreennew> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreennew> {






  @override
  void initState() {
    super.initState();
    
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => AuthScreen1())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Colors.white,
      body: 
      
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                color: Colors.white,
                child: Image.asset(
                  "assets/images/appstore.png",
                  scale: 3.4,
                )),
        
                // SizedBox(height: 20,),
                Text("DoorDash",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black,),)
          ],
        ),
      ),
      
    );
  }
}