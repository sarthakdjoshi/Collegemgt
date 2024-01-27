import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Attendance_Report extends StatefulWidget{
  @override
  State<Attendance_Report> createState() => _Attendance_ReportState();
}

class _Attendance_ReportState extends State<Attendance_Report> {
  var date=DateFormat('yyyy-MM-dd').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Attendance Report"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection("Students").where("PresentDate",isEqualTo: date).get(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return CircularProgressIndicator();
          }
          else if(snapshot.hasError){
            return Text("$snapshot.hasError");
          }
          else{
            List<DocumentSnapshot> documents = snapshot.data!.docs;
            return ListView.builder(itemCount: documents.length,itemBuilder: (context, index) {
              Map<String, dynamic> data =
              documents[index].data() as Map<String, dynamic>;
              String documentId = documents[index].id;
              index=index+1;
              return Table(
                children: [
              TableRow(children: [
              TableCell(
              child: Text(
                index.toString(),
                style: TextStyle(fontSize: 18),
              )),
              TableCell(
              child: Text(
                data['name'],
                style: TextStyle(fontSize: 18),
              )),
              TableCell(
              child: Text(
              data['Course'],
              style: TextStyle(fontSize: 24),
              )
              ),
              TableCell(child: Text(data['PresentDate']))
              ]),
              const TableRow(children: [
              TableCell(
              child: Divider(height: 20,)
              ),
              TableCell(
              child: Divider(height: 20,)
              ),
              TableCell(
              child: Divider(height: 20,)
              ),
              TableCell(
              child: Divider(height: 20,)
              ),
               ]),
              ],
              );

            },);

          }
        },
      ),
    );
  }
}