import 'package:cms/FEES/Fees_Panel.dart';
import 'package:cms/admin/Show_Student.dart';
import 'package:cms/admin/Show_Teachers.dart';
import 'package:cms/admin/student_registration.dart';
import 'package:cms/admin/teacher_registration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../main.dart';
import '../FEES/Stud_fees.dart';

class Admin_Panel extends StatefulWidget {
  const Admin_Panel({super.key});

  @override
  State<Admin_Panel> createState() => _Admin_PanelState();
}

class _Admin_PanelState extends State<Admin_Panel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Admin"),
          centerTitle: true,
          backgroundColor: Colors.brown,
          actions: [
            Row(
              children: [
                const Text(
                  "Logout",
                  style: TextStyle(fontSize: 20),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const MyHomePage(title: 'Login')));
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.red,
                    )),
              ],
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 180,
                        width: 100,
                        child: CupertinoButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Second()));
                          },
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.user,
                                size: 65,
                                color: Colors.red,
                              ),
                              Text(
                                "Student Registration",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 25),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 180,
                        width: 100,
                        child: CupertinoButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Teacher_reg()));
                          },
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.user,
                                size: 65,
                                color: Colors.red,
                              ),
                              Text(
                                "Teacher Registration",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 180,
                        width: 100,
                        child: CupertinoButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const Stud_fees(),));
                          },
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.moneyBill1Wave,
                                size: 65,
                                color: Colors.red,
                              ),
                              Text(
                                "Student Fees",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 25),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 180,
                        width: 100,
                        child: CupertinoButton(
                          onPressed: () {},
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.moneyCheck,
                                size: 65,
                                color: Colors.red,
                              ),
                              Text(
                                "Teacher Salary",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 25),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 180,
                        width: 100,
                        child: CupertinoButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const Fees_panel(),));
                          },
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.check,
                                size: 65,
                                color: Colors.red,
                              ),
                              Text(
                                "Students Certificate",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 25),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 180,
                        width: 100,
                        child: CupertinoButton(
                          onPressed: () {
                            print("Teacher Subject");
                          },
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.book,
                                size: 65,
                                color: Colors.red,
                              ),
                              Text(
                                "Teacher Subject",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 180,
                        width: 100,
                        child: CupertinoButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Show_Student()));
                          },
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.usersRectangle,
                                size: 65,
                                color: Colors.red,
                              ),
                              Text(
                                "View Students",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 25),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 180,
                        width: 100,
                        child: CupertinoButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Show_teacher()));
                          },
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.users,
                                size: 65,
                                color: Colors.red,
                              ),
                              Text(
                                "View Teachers",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const BottomAppBar(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "College Admin Panel",
                        style: TextStyle(
                            fontSize: 35,
                            color: Colors.indigo,
                            fontWeight: FontWeight.w900),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}