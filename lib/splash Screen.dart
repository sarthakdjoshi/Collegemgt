import 'dart:async';
import 'package:cms_student/Login_Page.dart';
import 'package:cms_student/student/profile_stud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {

    super.initState();
    Timer(Duration(seconds: 2),(){
      if(FirebaseAuth.instance.currentUser!=null){
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Profile_Stud(),
            ));
      }
      else{
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Login_Page(),
            ));

      }

    });
      }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset("assets/images/icon.jpg")),
    );
  }
}
