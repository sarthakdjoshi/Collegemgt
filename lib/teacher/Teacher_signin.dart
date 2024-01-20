import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/teacher/profile_Teachers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../student/profile_stud.dart';

class Teacher_Siginin extends StatefulWidget {
  @override
  State<Teacher_Siginin> createState() => _Teacher_SigininState();
}

class _Teacher_SigininState extends State<Teacher_Siginin> {
  var e_mail = TextEditingController();
  var pass = TextEditingController();
  var abc = true;
  void singin() async {
    try {
      String email = e_mail.text.toString();
      String password = pass.text.toString();
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Profile_Teacher(email),
          ));
    } on FirebaseAuthException catch (e) {
      print(e.code.toString());
      if (e.code.toString() == "invalid-credential") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Username or password is NotCorrect"),
          duration: Duration(seconds: 2),
        ));
      }
      if (e.code.toString() == "channel-error") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Email or Password Must Be Filled"),
          duration: Duration(seconds: 2),
        ));
      }
      if (e.code.toString() == "user-disabled") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Your Account Has Been Lock  Contact Your Principal"),
          duration: Duration(seconds: 2),
        ));
      }
      if (e.code.toString() == "invalid-email") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Provide Valid Email "),
          duration: Duration(seconds: 2),
        ));
      }
    }
  }
  CollectionReference users = FirebaseFirestore.instance.collection('Teachers');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teacher Login"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: users.get(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return const CircularProgressIndicator();
          }else if(snapshot.hasError){
            return  Text("Error:${snapshot.error}");
          }else{
            List<DocumentSnapshot> documents=snapshot.data!.docs;
            return ListView.builder(
              itemCount: documents.length,
                itemBuilder:(context, index) {
                  Map<String,dynamic>data=documents[index].data() as Map<String,dynamic>;
                  return Column(
                    children: [
                      const Text(
                        "Teacher Login Here",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: Colors.cyanAccent),
                      ),
                      SizedBox(
                          height: (MediaQuery.of(context).size.height)*0.3, child: Image.asset("assets/images/teacher.png")),
                      TextField(
                        controller: e_mail,
                        decoration: const InputDecoration(
                          labelText: "Enter Your Email.",
                          prefixIcon: Icon(Icons.email),
                          prefixIconColor: Colors.indigoAccent,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: pass,
                        obscureText: abc,
                        obscuringCharacter: "*",
                        decoration: InputDecoration(
                          label: const Text("Enter Password"),
                          prefixIcon: IconButton(
                            onPressed: () {
                              abc = !abc;
                              setState(() {});
                            },
                            icon: const Icon(Icons.password),
                          ),
                          prefixIconColor: Colors.cyan,
                        ),
                      ),
                      ElevatedButton(onPressed: () {
                        if(e_mail.text.toString()==data['email']){
                          print("true");
                          singin();
                        }else{ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(" You Are Not Teacher"),
                          duration: Duration(seconds: 2),
                        ));}
                      }, child: const Text("Login")),
                      CupertinoButton(
                          onPressed: () {
                            try {
                              if (e_mail.text == "") {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Enter Email "),
                                  duration: Duration(seconds: 2),
                                ));
                              } else {
                                FirebaseAuth.instance
                                    .sendPasswordResetEmail(email: e_mail.text.toString());
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Reset Link Has Sent To Your Email"),
                                  duration: Duration(seconds: 2),
                                ));
                              }
                            } on FirebaseAuthException catch (e) {
                              print(e.code.toString());
                            }
                          },
                          child: const Text("Forgot Password")),

                    ],
                  );
                },

            );
          }
        },
      )
    );
  }
}
