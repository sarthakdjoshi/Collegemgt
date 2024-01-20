import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Teacher_Siginin extends StatefulWidget {
  @override
  State<Teacher_Siginin> createState() => _Teacher_SigininState();
}

class _Teacher_SigininState extends State<Teacher_Siginin> {
  var Mobile = TextEditingController();
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teacher Login"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          const Text(
            "Teacher Login Here",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Colors.cyanAccent),
          ),
          SizedBox(height: 200, child: Image.asset("assets/images/teacher.png")),

          TextField(
            controller: Mobile,
            maxLength: 10,
            decoration:
                InputDecoration(labelText: "Enter Registered Mobile No."),
          ),
          SizedBox(height: 20),
          ElevatedButton(onPressed: () {
            
          }, child: const Text("Login"))
        ],
      ),
    );
  }
}
