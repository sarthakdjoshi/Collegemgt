import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../main.dart';

class Teacher_reg extends StatefulWidget {
  const Teacher_reg({super.key});

  @override
  State<Teacher_reg> createState() => _Teacher_regState();
}

class _Teacher_regState extends State<Teacher_reg> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var name = TextEditingController();
  var address = TextEditingController();
  var mobile = TextEditingController();
  var state = TextEditingController();
  var city = TextEditingController();
  var addharcard = TextEditingController();
  var email = TextEditingController();
  var pass = TextEditingController();
  var cpass = TextEditingController();
  int? selectedvalue = 1;
  var result = "Male";
  File? profilepic;
  var dob = "Choose Date of Birth";
  var doj = "Choose Date of Join";
  String Degree = "BCA";
  String Teacher = "BCA";
  List<String> options = [
    'BCA',
    'BCOM',
    'MCA',
    'MSCIT',
    'MCOM',
  ];
  var isvisible = false;
  bool sec = true;
  bool sec2 = true;
  bool pm = false;
  bool dm = false;

  void createuser() async {
    String email2 = email.text.toString();
    String password2 = pass.text.toString();
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email2, password: password2);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("User Account  Created"),
        duration: Duration(seconds: 2)));
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MyHomePage(),
        ));
  }

  void register() async {
    try {
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child("Teacher-profilepic")
          .child(const Uuid().v1())
          .putFile(profilepic!);
      uploadTask.snapshotEvents.listen((snapshot) {
        double per = snapshot.bytesTransferred / snapshot.totalBytes * 100;
        print(per.toString());
      });
      TaskSnapshot taskSnapshot = await uploadTask;
      String photourl = await taskSnapshot.ref.getDownloadURL();

      Map<String, dynamic> Teacherdata = {
        "name": name.text.trim().toString(),
        "gender": result.toString(),
        "address": address.text.trim().toString(),
        "dob": dob.toString(),
        "Degree": Degree.trim().toString(),
        "mobileno.": mobile.text.trim().toString(),
        "email": email.text.trim().toString(),
        "addharcard": addharcard.text.trim().toString(),
        "state": state.text.trim().toString(),
        "city": city.text.trim().toString(),
        "photo": photourl.toString(),
        "doj": DateFormat('yyyy-MM-dd').format(DateTime.now()),
        "Teacherof": Teacher.trim().toString(),
      };
      FirebaseFirestore.instance.collection("Teachers").add(Teacherdata);
      print("Saved");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Teacher Created"),
          duration: Duration(
            seconds: 2,
          )));
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teacher Registration"),
        centerTitle: true,
        backgroundColor: Colors.limeAccent,
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          height: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Teacher Register",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  const Text(
                    "Choose Photo",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () async {
                      try {
                        XFile? selecedimage = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (selecedimage != null) {
                          File cf = File(selecedimage.path);
                          setState(() {
                            profilepic = cf;
                          });
                        } else {
                          if (profilepic == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please Select Any Image"),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        }
                      } catch (e) {
                        print(e.toString());
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 40,
                      backgroundImage:
                          (profilepic != null) ? FileImage(profilepic!) : null,
                    ),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  TextField(
                    controller: name,
                    decoration: InputDecoration(
                      label: const Text("Enter Teacher Name"),
                      prefixIcon: const FaIcon(FontAwesomeIcons.user),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  TextField(
                    controller: address,
                    decoration: InputDecoration(
                      label: const Text("Enter Teacher Address"),
                      prefixIcon: const FaIcon(FontAwesomeIcons.addressBook),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: mobile,
                    maxLength: 10,
                    decoration: InputDecoration(
                      label: const Text("Enter Teacher Mobile Number"),
                      prefixIcon: const FaIcon(FontAwesomeIcons.mobile),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const Text("Choose Gender"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                          value: 1,
                          groupValue: selectedvalue,
                          onChanged: (value) {
                            setState(() {
                              selectedvalue = value;
                              result = "Male";
                            });
                          }),
                      const Text("Male"),
                      Radio(
                          value: 2,
                          groupValue: selectedvalue,
                          onChanged: (value) {
                            setState(() {
                              selectedvalue = value;
                              result = "Female";
                            });
                          }),
                      const Text("Female"),
                    ],
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: TextFormField(
                          controller: state,
                          decoration: InputDecoration(
                              labelText: "State",
                              prefixIcon:
                                  const Icon(FontAwesomeIcons.locationPin),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: TextFormField(
                          controller: city,
                          decoration: InputDecoration(
                              labelText: "City",
                              prefixIcon: const Icon(FontAwesomeIcons.city),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        dob,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          DateTime? picked = await showDatePicker(
                              context: context,
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now());
                          if (picked != null) {
                            dob =
                                "${picked.day.toString()}-${picked.month.toString()}-${picked.year.toString()}";
                            setState(() {});
                          } else {
                            dob = "Select Date Of Birth";
                            setState(() {});
                          }
                        },
                        child: const Text("Press To Choose"),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        doj,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          DateTime? picked2 = await showDatePicker(
                              context: context,
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now());
                          if (picked2 != null) {
                            doj =
                                "${picked2.day.toString()}-${picked2.month.toString()}-${picked2.year.toString()}";
                            setState(() {});
                          } else {
                            doj = "Select Date Of Join";
                            setState(() {});
                          }
                        },
                        child: const Text("Press To Choose"),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                          child: Text(
                        "Choose Degree",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      )),
                      DropdownButton<String>(
                        value: Degree,
                        onChanged: (String? newvalue) {
                          setState(() {
                            Degree = newvalue!;
                          });
                        },
                        items: options
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w600),
                              ));
                        }).toList(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                          child: Text(
                        "Teacher OF",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      )),
                      DropdownButton<String>(
                        value: Teacher,
                        onChanged: (String? newvalue) {
                          setState(() {
                            Teacher = newvalue!;
                          });
                        },
                        items: options
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w600),
                              ));
                        }).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: addharcard,
                    maxLength: 12,
                    decoration: InputDecoration(
                      label: const Text("Enter Addharcard Number"),
                      prefixIcon: const FaIcon(FontAwesomeIcons.creditCard),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  TextFormField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: "Enter Email",
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  TextFormField(
                    controller: pass,
                    keyboardType: TextInputType.text,
                    obscureText: sec,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                        labelText: "Enter Password",
                        prefixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              sec = !sec;
                            });
                          },
                          icon: const Icon(Icons.key),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  TextFormField(
                    controller: cpass,
                    obscureText: sec2,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                        labelText: "Enter Confirm Password",
                        prefixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              sec2 = !sec2;
                            });
                          },
                          icon: const Icon(Icons.key),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  const SizedBox(
                    width: double.infinity,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          register();
                          createuser();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero)),
                        child: const Text("Register",style: TextStyle(color: Colors.white),)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
