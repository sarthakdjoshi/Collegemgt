import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/student/profile_stud.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student List"),
        centerTitle: true,
        backgroundColor: Colors.purple,
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
                          width: (MediaQuery.of(context).size.width)*0.9,
                          child: TextField(
                            controller: search,
                          ),
                        ),
                        CupertinoButton(
                            child: const Text("Search"),
                            onPressed: () {
                              abc = FirebaseFirestore.instance
                                  .collection('Students')
                                  .where("name",
                                      isEqualTo: search.text.trim().toString())
                                  .get();
                              setState(() {});
                              search.clear();
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
    );
  }
}
