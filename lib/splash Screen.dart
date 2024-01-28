import 'dart:async';

import 'package:cms/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget{
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2),() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(title: "const MyHomePage(title: 'Login')"),)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset("assets/images/icon.jpg")),
    );
  }
}