import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Show_teacher extends StatefulWidget {
  const Show_teacher({super.key});

  @override
  State<Show_teacher> createState() => _Show_teacherState();
}

class _Show_teacherState extends State<Show_teacher> {
  CollectionReference users = FirebaseFirestore.instance.collection('Teachers');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teachers List"),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: users.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
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
                        print(documentId);
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
    );
  }
}
