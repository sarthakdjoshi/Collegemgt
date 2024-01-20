import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Teacher_Siginin extends StatefulWidget {
  @override
  State<Teacher_Siginin> createState() => _Teacher_SigininState();
}

class _Teacher_SigininState extends State<Teacher_Siginin> {
  var email = TextEditingController();
  var pass = TextEditingController();
  var abc = true;
  CollectionReference users = FirebaseFirestore.instance.collection('Teachers');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teacher Login"),
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
                          height: 200, child: Image.asset("assets/images/teacher.png")),
                      TextField(
                        controller: email,
                        decoration: const InputDecoration(
                          labelText: "Enter Your Email.",
                          prefixIcon: Icon(Icons.email),
                          prefixIconColor: Colors.indigoAccent,
                        ),
                      ),
                      SizedBox(height: 20),
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
                        if(email.text.toString()==data['email']){
                          print("true");
                        }else{print("False");}
                      }, child: const Text("Login")),
                      CupertinoButton(
                          onPressed: () {
                            try {
                              if (email.text == "") {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Enter Email "),
                                  duration: Duration(seconds: 2),
                                ));
                              } else {
                                FirebaseAuth.instance
                                    .sendPasswordResetEmail(email: email.text.toString());
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
