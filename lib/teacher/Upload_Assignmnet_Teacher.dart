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
  List<Map<String, dynamic>> pdfdata = [];

  Future<String> UploadFile(String filename, File file) async {
    final refence = FirebaseStorage.instance.ref().child("pdf/$filename.pdf");
    final uploadtask = refence.putFile(file);
    await uploadtask.whenComplete(() {});
    final downlodlink = await refence.getDownloadURL();
    return downlodlink;
  }

  void pickfile() async {
    final pickedfile = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

    if (pickedfile != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please Wait")));
      String? filename = pickedfile.files[0].name;
      File file = File(pickedfile.files[0].path!);
      final downoladlink = await UploadFile(filename, file);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${filename} is Uploaded")));
      FirebaseFirestore.instance.collection("Pdf").add(({
            'name': filename.toString(),
            'download link': downoladlink.toString()
          }));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Your Assignments"),
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
                          child: FaIcon(FontAwesomeIcons.download),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => pickfile(),
        child: FaIcon(FontAwesomeIcons.upload, size: 20),
      ),
    );
  }
}
