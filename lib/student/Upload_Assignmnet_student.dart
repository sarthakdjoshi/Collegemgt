import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/student/Pdfview.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';

class Upload_Assignmnet extends StatefulWidget {
  @override
  State<Upload_Assignmnet> createState() => _Upload_AssignmnetState();

  Upload_Assignmnet();
}

class _Upload_AssignmnetState extends State<Upload_Assignmnet> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Assignments"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection("Pdf").get(),
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
                    SingleChildScrollView(
                      child: ListTile(
                        title: Text(data['name']),
                        subtitle: Text(data['download link']),
                        trailing: CupertinoButton(
                          child: Icon(Icons.pages),
                          onPressed: () {
                            String pdfUrl = data['download link'];
                            String Name = data['name'];

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PdfView(pdfUrl,Name),
                                ));
                          },
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
