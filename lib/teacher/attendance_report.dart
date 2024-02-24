import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Attendance_Report extends StatefulWidget {
  const Attendance_Report({super.key});

  @override
  State<Attendance_Report> createState() => _Attendance_ReportState();
}

class _Attendance_ReportState extends State<Attendance_Report> {
  var date = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Attendance Report"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Table(
            border: TableBorder.all(),
            defaultColumnWidth: const FixedColumnWidth(100.0),
            children: const [
              TableRow(children: [
                TableCell(
                    child: Text(
                      "Sr.No",
                      style: TextStyle(fontSize: 18),
                    )),
                TableCell(
                    child: Text(
                      "Name",
                      style: TextStyle(fontSize: 18),
                    )),
                TableCell(
                    child: Text(
                      "Course",
                      style: TextStyle(fontSize: 24),
                    )),
                TableCell(child: Text("PresentDate"))
              ]),
            ],
          ),
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection("Students").get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("$snapshot.hasError");
                } else {
                  List<DocumentSnapshot> documents = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> data =
                          documents[index].data() as Map<String, dynamic>;
                      String documentId = documents[index].id;
                      index = index + 1;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        child: Table(
                          border: TableBorder.all(),
                          defaultColumnWidth: const FixedColumnWidth(100.0),
                          children: [
                            TableRow(children: [
                              TableCell(
                                  child: Text(
                                index.toString(),
                                style: const TextStyle(fontSize: 18),
                              )),
                              TableCell(
                                  child: Text(
                                data['name'],
                                style: const TextStyle(fontSize: 18),
                              )),
                              TableCell(
                                  child: Text(
                                data['Course'],
                                style: const TextStyle(fontSize: 24),
                              )),
                              TableCell(child: Text(data['PresentDate']))
                            ]),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
