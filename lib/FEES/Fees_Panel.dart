import 'package:cms/FEES/Mobile_Pass_Panel.dart';
import 'package:cms/FEES/Stud_fees.dart';
import 'package:cms/FEES/Student_bonafied_panel.dart';
import 'package:cms/FEES/Delete_Student_panel.dart';
import 'package:cms/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Fees_panel extends StatefulWidget {
  const Fees_panel({super.key});

  @override
  State<Fees_panel> createState() => _Fees_panelState();
}

class _Fees_panelState extends State<Fees_panel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fees Managemnet"),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyHomePage(),
                    ));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Column(
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
                            builder: (context) =>
                                const Student_Bonafied_Panel(),
                          ));
                    },
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.certificate,
                          size: 65,
                          color: Colors.red,
                        ),
                        Text(
                          "Bonafide Certificate",
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
                            builder: (context) => const Stud_fees(),
                          ));
                    },
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.moneyBills,
                          size: 65,
                          color: Colors.red,
                        ),
                        Text(
                          "Student Fees",
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
                            builder: (context) =>
                                const Transfer_certificate_panel(),
                          ));
                    },
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.trash,
                          size: 65,
                          color: Colors.red,
                        ),
                        Text(
                          "Delete Student",
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
                            builder: (context) => const Mobile_Pass_Panel(),
                          ));
                    },
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.mobileScreen,
                          size: 65,
                          color: Colors.red,
                        ),
                        Text(
                          "Mobile Pass",
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
        ],
      ),
    );
  }
}
