import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Show_Student_attendance extends StatefulWidget {
  const Show_Student_attendance({super.key});

  @override
  State<Show_Student_attendance> createState() =>
      _Show_Student_attendanceState();
}

class _Show_Student_attendanceState extends State<Show_Student_attendance> {
  @override
  CollectionReference users = FirebaseFirestore.instance.collection('Students');
  var abc = FirebaseFirestore.instance.collection('Students').get();
  String Course = 'Select Course'; //dropdown
  List<String> options = [
    'Select Course',
    'Bca',
    'B.com',
    'M.com',
    'MSC.IT',
    'Mca',
    'All',
  ];
  var color = Colors.green;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Attendance"),
        centerTitle: true,
        backgroundColor: Colors.purple,
        actions: [
          IconButton(onPressed: (){
            setState(() {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Show_Student_attendance(),));
            });
          }, icon: Icon(Icons.refresh))
        ],
      ),

      body: FutureBuilder<QuerySnapshot>(
        future: abc,
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
                return Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: (MediaQuery.of(context).size.width) * 0.8,
                          child: Row(
                            children: [
                              Expanded(
                                child: DropdownButton<String>(
                                  value: Course,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      Course = newValue!;
                                    });
                                  },
                                  items: options.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        CupertinoButton(
                            child: const Text("Search"),
                            onPressed: () {
                              if (Course.toString() != "Select Course") {
                                abc = FirebaseFirestore.instance
                                    .collection('Students')
                                    .where('Course',
                                        isEqualTo: Course.trim().toString())
                                    .get();

                                setState(() {});
                              }
                              if (Course.toString() == "All") {
                                abc = FirebaseFirestore.instance
                                    .collection('Students')
                                    .get();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Choose Any Course"),
                                  duration: Duration(seconds: 2),
                                ));
                                setState(() {});
                              }
                              setState(() {});
                            })
                      ],
                    ),
                    SingleChildScrollView(
                      child: ListTile(
                        title: Text(data['name']),
                        subtitle: Text(data['Course']),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(data['photo']),
                        ),
                        trailing: CupertinoButton(
                          color: color,
                          onPressed: () {
                            if (data['PresentDate'] ==
                                DateFormat('yyyy-MM-dd')
                                    .format(DateTime.now())) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Already Prenset"),
                                duration: Duration(seconds: 2),
                              ));
                            } else {
                              try {
                                FirebaseFirestore.instance
                                    .collection('Students')
                                    .doc(documentId.toString())
                                    .update({
                                  'Present': 'Yes',
                                  'PresentDate': DateFormat('yyyy-MM-dd')
                                      .format(DateTime.now())
                                });
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      "Prenset Added For${data['name']}"),
                                  duration: Duration(seconds: 2),
                                ));

                                print("Update");
                              } catch (e) {
                                print(e.toString());
                              }
                            }
                          },
                          child: const Text("Present"),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
