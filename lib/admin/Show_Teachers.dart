import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/teacher/profile_Teachers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Show_teacher extends StatefulWidget {
  const Show_teacher({super.key});

  @override
  State<Show_teacher> createState() => _Show_teacherState();
}

class _Show_teacherState extends State<Show_teacher> {
  CollectionReference users = FirebaseFirestore.instance.collection('Teachers');
  var abc = FirebaseFirestore.instance.collection('Teachers').get();
    var search=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teachers List"),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: (MediaQuery.of(context).size.width) * 0.8,
                child: TextField(
                  controller: search,
                  decoration:
                  const InputDecoration(labelText: "Search Name"),
                ),
              ),
              CupertinoButton(
                  child: const Text("Search"),
                  onPressed: () {
                    if (search.text.isEmpty) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                        content: Text("Enter Name"),
                        duration: Duration(seconds: 2),
                      ));
                    } else {
                      abc = FirebaseFirestore.instance
                          .collection('Teachers')
                          .where("name",
                          isEqualTo:
                          search.text.trim().toString())
                          .get();

                      setState(() {});
                      search.clear();
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
                  // Process the documents
                  List<DocumentSnapshot> documents = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      // Access data from each document using documents[index].data()
                      Map<String, dynamic> data =
                          documents[index].data() as Map<String, dynamic>;
                      String documentId = documents[index].id;
                      return SingleChildScrollView(
                        child: ListTile(
                          title: Text(data['name']),
                          subtitle: Text(data['email']),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(data['photo']),
                          ),
                          trailing: CupertinoButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Profile_Teacher(data['email']),));
                            },
                            child: const Text("Show  Profile"),
                          ),
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
