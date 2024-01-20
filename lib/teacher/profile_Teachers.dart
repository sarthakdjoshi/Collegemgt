import 'package:cms/teacher/Teacher_signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile_Teacher extends StatefulWidget {
  final String u_email;

  const Profile_Teacher(this.u_email, {super.key});

  @override
  State<Profile_Teacher> createState() => _Profile_TeacherState();
}

class _Profile_TeacherState extends State<Profile_Teacher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teacher_Profile"),
        centerTitle: true,
        backgroundColor: Colors.lime,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Teacher_Siginin(),
                    ));
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: Center(
        child: Text(widget.u_email),
      ),
    );
  }
}
