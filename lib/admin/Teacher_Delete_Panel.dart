import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Teacher_Delete extends StatefulWidget {
  const Teacher_Delete({super.key});

  @override
  State<Teacher_Delete> createState() => _Teacher_DeleteState();
}

class _Teacher_DeleteState extends State<Teacher_Delete> {
  CollectionReference users = FirebaseFirestore.instance.collection('Teachers');
  var abc = FirebaseFirestore.instance.collection('Teachers').get();
  var search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teacher List"),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: (MediaQuery.of(context).size.width) * 0.8,
                child: TextField(
                  controller: search,
                  decoration: const InputDecoration(labelText: "Search Name"),
                ),
              ),
              CupertinoButton(
                  child: const Text("Search"),
                  onPressed: () {
                    if (search.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Enter Name"),
                        duration: Duration(seconds: 2),
                      ));
                    } else {
                      abc = FirebaseFirestore.instance
                          .collection('Teachers')
                          .where("name",
                              isEqualTo: search.text.trim().toString())
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
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Confirm TO Delete"),
                                    content: const Text(
                                        'Are you sure you want to delete this teacher?'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("NO")),
                                      TextButton(
                                          onPressed: () {
                                            users
                                                .doc(documentId)
                                                .delete()
                                                .then((value) async {
                                              User? user = FirebaseAuth
                                                  .instance.currentUser;
                                              await user?.delete();
                                            });
                                            Navigator.of(context).pop();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "${data['name']} was Deleted",
                                                ),
                                                duration:
                                                    const Duration(seconds: 2),
                                              ),
                                            );
                                          },
                                          child: const Text("Yes")),
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Text("Delete"),
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
