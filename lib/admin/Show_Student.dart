import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms_student/student/profile_stud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Show_Student extends StatefulWidget {
  const Show_Student({super.key});

  @override
  State<Show_Student> createState() => _Show_StudentState();
}

class _Show_StudentState extends State<Show_Student> {
  @override
  void initState() {
    super.initState();
  }

  CollectionReference users = FirebaseFirestore.instance.collection('Students');
  var search = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student List"),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Column(
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
                        items: options
                            .map<DropdownMenuItem<String>>((String value) {
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
                          .where('Course', isEqualTo: Course.trim().toString())
                          .get();

                      setState(() {});
                    }
                    if (Course.toString() == "All") {
                      abc = FirebaseFirestore.instance
                          .collection('Students')
                          .get();
                      setState(() {});
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("No Student Found"),
                        duration: Duration(seconds: 2),
                      ));
                    }
                  })
            ],
          ),
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
              future: abc,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
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
                          SingleChildScrollView(
                            child: ListTile(
                              title: Text(data['name']),
                              subtitle: Text(data['Course']),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(data['photo']),
                              ),
                              trailing: CupertinoButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Profile_Stud(data['email']),
                                      ));
                                },
                                child: const Text("Show  Profile"),
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
          ),
        ],
      ),
    );
  }
}
