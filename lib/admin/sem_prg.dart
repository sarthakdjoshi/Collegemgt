import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class sem_prg extends StatefulWidget {
  final String name;
  final String id;
  final String photo;

  @override
  State<sem_prg> createState() => _sem_prgState();

  const sem_prg(this.name, this.id, this.photo, {super.key});
}

class _sem_prgState extends State<sem_prg> {
  String Sem = "1"; //dropdown
  List<String> SemOption = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Sem"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(widget.photo),
            ),
            Text(
              "Name : ${widget.name}",
              style: const TextStyle(fontSize: 32),
            ),
            DropdownButton<String>(
              value: Sem,
              onChanged: (String? newValue) {
                setState(() {
                  Sem = newValue!;
                });
              },
              items: SemOption.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(fontSize: 30),
                  ),
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo,shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),

                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection("Students")
                          .doc(widget.id)
                          .update({
                        'CurrentSem': Sem.toString(),
                        "fees": "unpaid",
                        "mobilepass": "no",
                        "mobile_pass_gen_date": "notgenerate",
                        "PresentDate":
                            DateFormat('yyyy-MM-dd').format(DateTime.now()),
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Semester Change")));
                    },
                    child: const Text("Change Sem",style: TextStyle(color: Colors.white),)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
