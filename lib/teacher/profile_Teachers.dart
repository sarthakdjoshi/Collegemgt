import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/teacher/Show_Student_attendance.dart';
import 'package:cms/teacher/Teacher_signin.dart';
import 'package:cms/teacher/Upload_Assignmnet_Teacher.dart';
import 'package:cms/teacher/attendance_report.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../admin/Show_Student.dart';

class Profile_Teacher extends StatefulWidget {
  final String u_email;

  const Profile_Teacher(this.u_email, {super.key});

  @override
  State<Profile_Teacher> createState() => _Profile_TeacherState();
}

class _Profile_TeacherState extends State<Profile_Teacher> {
  CollectionReference users = FirebaseFirestore.instance.collection('Teachers');
  var teacherof = "";
  var icon = const Icon(Icons.verified);
  @override
  void sendEmailVerification() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        print("Email verification sent successfully");
      } else {
        print("User is already verified or not signed in");
      }
    } catch (e) {
      print("Error sending email verification: $e");
    }
  }

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
                      builder: (context) => const Teacher_Siginin(),
                    ));
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text("Welcome :-${widget.u_email.toString()}"),
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Show_Student_attendance(),));
              },
              child: const ListTile(
                leading: FaIcon(FontAwesomeIcons.user),
                title: Text("Student Attendent"),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Show_Student(),));
              },
              child: const ListTile(
                leading: FaIcon(FontAwesomeIcons.usersViewfinder),
                title: Text("View Student"),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const Upload_Assignmnet()));

              }, child: const ListTile(
              leading: FaIcon(FontAwesomeIcons.upload),
              title: Text("Upload Assignments"),
            ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const Attendance_Report()));

              }, child: const ListTile(
              leading: FaIcon(FontAwesomeIcons.users),
              title: Text("Attendance Report"),
            ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: users.where("email", isEqualTo: widget.u_email).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<DocumentSnapshot> documents = snapshot.data!.docs;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> data =
                documents[index].data() as Map<String, dynamic>;
                String documentId = documents[index].id;
                teacherof = data['Teacherof'];

                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                        data['photo'],
                        width: 200,
                        height: 200,
                      ),
                      Table(
                        border: TableBorder.all(),
                        children: [
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                                  "APP_ID",
                                  style: TextStyle(fontSize: 24),
                                )),
                            TableCell(
                                child: Text(
                                  documentId,
                                  style: const TextStyle(fontSize: 24),
                                )),
                          ]),
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                                  "Name",
                                  style: TextStyle(fontSize: 24),
                                )),
                            TableCell(
                                child: Text(
                                  data['name'],
                                  style: const TextStyle(fontSize: 24),
                                )),
                          ]),
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                                  "Degree",
                                  style: TextStyle(fontSize: 24),
                                )),
                            TableCell(
                                child: Text(
                                  data['Degree'],
                                  style: const TextStyle(fontSize: 24),
                                )),
                          ]),
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                                  "Email",
                                  style: TextStyle(fontSize: 24),
                                )),
                            TableCell(child: Text(data['email'])),
                          ]),
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                                  "Gender",
                                  style: TextStyle(fontSize: 24),
                                )),
                            TableCell(
                                child: Text(
                                  data['gender'],
                                  style: const TextStyle(fontSize: 24),
                                )),
                          ]),
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                                  "Teacherof",
                                  style: TextStyle(fontSize: 24),
                                )),
                            TableCell(
                                child: Text(
                                  data['Teacherof'],
                                  style: const TextStyle(fontSize: 24),
                                )),
                          ]),
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                                  "Address",
                                  style: TextStyle(fontSize: 24),
                                )),
                            TableCell(
                                child: Text(
                                  data['address'],
                                  style: const TextStyle(fontSize: 24),
                                )),
                          ]),
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                                  "Addharcard No.",
                                  style: TextStyle(fontSize: 24),
                                )),
                            TableCell(
                                child: Text(
                                  data['addharcard'],
                                  style: const TextStyle(fontSize: 24),
                                )),
                          ]),
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                                  "city",
                                  style: TextStyle(fontSize: 24),
                                )),
                            TableCell(
                                child: Text(
                                  data['city'],
                                  style: const TextStyle(fontSize: 24),
                                )),
                          ]),
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                                  "State",
                                  style: TextStyle(fontSize: 24),
                                )),
                            TableCell(
                                child: Text(
                                  data['state'],
                                  style: const TextStyle(fontSize: 24),
                                )),
                          ]),
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                                  "Date Of Birth",
                                  style: TextStyle(fontSize: 24),
                                )),
                            TableCell(
                                child: Text(
                                  data['dob'],
                                  style: const TextStyle(fontSize: 24),
                                )),
                          ]),
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                                  "Date Of Joining",
                                  style: TextStyle(fontSize: 24),
                                )),
                            TableCell(
                                child: Text(
                                  data['doj'],
                                  style: const TextStyle(fontSize: 24),
                                )),
                          ]),
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                                  "Email-Verified",
                                  style: TextStyle(fontSize: 24),
                                )),
                            TableCell(
                                child: (FirebaseAuth.instance.currentUser
                                    ?.emailVerified !=
                                    true)
                                    ? CupertinoButton(
                                    child: const Text("Verify Your Email"),
                                    onPressed: () {
                                      sendEmailVerification();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                            "Email Verification Link Has Been Sent"),
                                        duration: Duration(seconds: 2),
                                      ));
                                    })
                                    : icon),
                          ]),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
