import 'dart:async';

import 'package:flutter/material.dart';

import 'start.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MySplashScreen();
  }

}

class _MySplashScreen extends State<SplashScreen>{
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
            (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext){
                return Start();
              }
          ));
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 209, 196, 233,),
      body: Center(
        child: Image.asset("assets/logo.png"),
      ),
    );
  }


}