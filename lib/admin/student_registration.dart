import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:email_validator/email_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../main.dart';

class Second extends StatefulWidget {
  const Second({super.key});

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var Name = TextEditingController(); //name
  var Parents = TextEditingController(); //name
  var Address = TextEditingController(); //address
  var Mobile = TextEditingController(); //address
  var Email = TextEditingController(); //email
  var password = TextEditingController(); //password
  var Cpasseword = TextEditingController(); //password
  var Aadhar = TextEditingController(); //Aadhaar
  var State = TextEditingController(); //State
  var City = TextEditingController(); //City
  int? selectedValue = 1; //checkbox
  var Result = "Male"; //radio button
  var val = "";
  var email = "";
  String pwvalid = "yes";
  String dob = "Choose Date Of Birth";
  String Course = 'Select Course'; //dropdown
  List<String> options = [
    'Select Course',
    'Bca',
    'B.com',
    'M.com',
    'MSC.IT',
    'Mca'
  ];
  bool sec = true;
  bool sec2 = true;
  File? profilepic;

  void createuser() async {
    String email = Email.text.toString();
    String password2 = password.text.toString();
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password2);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Student Created"), duration: Duration(seconds: 2)));
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
          .child("Stud-profilepic")
          .child(const Uuid().v1())
          .putFile(profilepic!);
      uploadTask.snapshotEvents.listen((snapshot) {
        double per = snapshot.bytesTransferred / snapshot.totalBytes * 100;
        print(per.toString());
      });
      TaskSnapshot taskSnapshot = await uploadTask;
      String photourl = await taskSnapshot.ref.getDownloadURL();

      Map<String, dynamic> studdata = {
        "name": Name.text.trim().toString(),
        "parentsname": Parents.text.trim().toString(),
        "gender": Result.toString(),
        "address": Address.text.trim().toString(),
        "dob": dob.toString(),
        "Course": Course.trim().toString(),
        "mobileno.": Mobile.text.trim().toString(),
        "email": Email.text.trim().toString(),
        "addharcard": Aadhar.text.trim().toString(),
        "CurrentSem": "1",
        "state": State.text.trim().toString(),
        "city": City.text.trim().toString(),
        "photo": photourl.toString(),
        "fees": "unpaid",
        "mobilepass": "no",
        "mobile_pass_gen_date": "notgenerate",
        "PresentDate": DateFormat('yyyy-MM-dd').format(DateTime.now()),
      };
      FirebaseFirestore.instance.collection("Students").add(studdata);
      print("Saved");
    } catch (e) {
      print(e.toString());
    }
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Student Registered"), duration: Duration(seconds: 2)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "Student Registration Form",
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Student Register",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.blue,
                        fontWeight: FontWeight.w900),
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
                        XFile? selecetedimage = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (selecetedimage != null) {
                          print("Image");
                          File cf = File(selecetedimage.path);
                          setState(() {
                            profilepic = cf;
                          });
                        } else {
                          print("No Image");
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
                  TextFormField(
                    controller: Name,
                    decoration: InputDecoration(
                        labelText: "Enter Name",
                        prefixIcon: const Icon(FontAwesomeIcons.user),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ), //Name
                  const SizedBox(
                    height: 11,
                  ),
                  TextFormField(
                    controller: Parents,
                    decoration: InputDecoration(
                        labelText: "Enter Parents Name",
                        prefixIcon: const Icon(FontAwesomeIcons.user),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ), //Name
                  const SizedBox(
                    height: 11,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    controller: Address,
                    decoration: InputDecoration(
                        labelText: "Enter Address",
                        prefixIcon: const Icon(FontAwesomeIcons.addressCard),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  TextFormField(
                    controller: Mobile,
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        labelText: "Enter Mobile Number",
                        prefixIcon: const Icon(FontAwesomeIcons.mobile),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  Row(
                    children: [
                      const Text("Choose Gender"),
                      Radio(
                        value: 1,
                        groupValue: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                            Result = "Male";
                          });
                        },
                      ),
                      const Text("Male"),
                      Radio(
                        value: 2,
                        groupValue: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                            Result = "Female";
                          });
                        },
                      ),
                      const Text("Female"),
                    ],
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  const Text(
                    "Enter Location",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: TextFormField(
                          controller: State,
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
                          controller: City,
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
                            fontSize: 20, fontWeight: FontWeight.w900),
                      ),
                      Expanded(
                          child: ElevatedButton(
                              onPressed: () async {
                                DateTime? datepick = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime.now(),
                                );
                                if (datepick != null) {
                                  dob =
                                      "${datepick.day.toString()}-${datepick.month.toString()}-${datepick.year.toString()}";
                                  setState(() {});
                                } else {
                                  dob = "Select Date Of Birth";
                                  setState(() {});
                                }
                              },
                              child: const Text("Choose")))
                    ],
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  TextFormField(
                    controller: Aadhar,
                    maxLength: 12,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Enter Aadhaar number",
                        prefixIcon: const Icon(Icons.credit_card),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  Row(
                    children: [
                      const Expanded(
                          child: Text(
                        "Choose Your Course",
                        style: TextStyle(fontSize: 20),
                      )),
                      DropdownButton<String>(
                        value: Course,
                        onChanged: (String? newValue) {
                          setState(() {
                            Course = newValue!;
                          });
                        },
                        items: options
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  TextFormField(
                    controller: Email,
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
                    controller: password,
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
                    controller: Cpasseword,
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
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            if (password.text.toString() ==
                                Cpasseword.text.toString()) {
                              pwvalid = "yes";
                            } else {
                              pwvalid = "no";
                            }
                            setState(() {});
                            final bool isValid =
                                EmailValidator.validate(Email.text.toString());
                            if (isValid) {
                              email = "Valid";
                            } else {
                              email = "Invalid";
                            }
                            setState(() {});
                            if (Name.text == "" ||
                                Address.text == "" ||
                                Email.text == "" ||
                                password.text == "" ||
                                email == "Invalid" ||
                                pwvalid == "no" ||
                                Mobile.text.length < 10 ||
                                dob == "Choose Date Of Birth" ||
                                Aadhar.text == "" ||
                                Aadhar.text.length < 12 ||
                                State.text == "" ||
                                City.text == "" ||
                                Parents.text == "" ||
                                profilepic == null ||
                                Course == "Select Course") {
                              setState(() {
                                val = "Please Fill The Form Correctly";
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(val.trim().toString()),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Please Wait"),
                                duration: Duration(seconds: 2),
                              ));
                              register();
                              createuser();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero)),
                          child: const Text(
                            "Register",
                            style: TextStyle(fontSize: 36,color: Colors.white),
                          ))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
