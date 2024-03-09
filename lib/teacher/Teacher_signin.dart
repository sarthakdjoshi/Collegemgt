import 'package:cms/teacher/profile_Teachers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class Teacher_Siginin extends StatefulWidget {
  const Teacher_Siginin({super.key});

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
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Profile_Teacher(email),
          ));
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Teacher Loggedin")));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Teacher Login"),
          centerTitle: true,
          backgroundColor: Colors.amber,
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Teacher Login Here",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Colors.cyanAccent),
              ),
              SizedBox(
                  height: 200, child: Image.asset("assets/images/teacher.png")),
              TextField(
                controller: e_mail,
                decoration: const InputDecoration(
                  hintText: "Enter Email",
                  prefixIcon: Icon(Icons.email),
                  prefixIconColor: Colors.indigoAccent,
                ),
              ),
              TextField(
                controller: pass,
                obscureText: abc,
                obscuringCharacter: "*",
                decoration: InputDecoration(
                  hintText: "Enter Password",
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Please Wait"),
                          duration: Duration(seconds: 2),
                        ));
                        singin();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero)),
                      child: const Text("Login",
                          style: TextStyle(fontSize: 26, color: Colors.white))),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        e_mail.clear();
                        pass.clear();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero)),
                      child: const Text("Clear",
                          style: TextStyle(fontSize: 26, color: Colors.white))),
                ),
              ),
              Row(
                children: [
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
                            print(e_mail.text.toString());
                            String email = e_mail.text.toString();
                            FirebaseAuth.instance
                                .sendPasswordResetEmail(email: email);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content:
                                  Text("Reset Link Has Sent To Your Email"),
                              duration: Duration(seconds: 2),
                            ));
                          }
                        } on FirebaseAuthException catch (e) {
                          print(e.code.toString());
                        }
                      },
                      child: const Text("Forgot Password")),
                  Expanded(
                      child: CupertinoButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyHomePage(),
                          ));
                    },
                    child: const Text("Student Login"),
                  ))
                ],
              ),
            ],
          )),
        ));
  }
}
