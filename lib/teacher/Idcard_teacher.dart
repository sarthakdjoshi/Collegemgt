import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Id_Card_Teacher extends StatefulWidget{
final String u_mail;

const Id_Card_Teacher(this.u_mail, {super.key});

  @override
  State<Id_Card_Teacher> createState() => _Id_Card_TeacherState();
}

class _Id_Card_TeacherState extends State<Id_Card_Teacher> {

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar:AppBar(
       title: const Text("Teacher's Id Card"),
       centerTitle: true,
       backgroundColor: Colors.indigoAccent,

     ),
     body:  FutureBuilder<QuerySnapshot>(
       future: FirebaseFirestore.instance.collection('Teachers').where("email",isEqualTo: widget.u_mail).get(),
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
                 child: Center(
                   child: Card(
                     margin: const EdgeInsets.all(16.0),
                     child: Padding(
                       padding: const EdgeInsets.all(16.0),
                       child: Column(
                         mainAxisSize: MainAxisSize.min,
                         children: [
                           const Text("College Name",style: TextStyle(fontSize: 24),),
                           CircleAvatar(
                             radius: 50.0,
                             backgroundImage: NetworkImage(data['photo']) // Replace with your image
                           ),
                           const SizedBox(height: 16.0),
                           Text(
                             'Name:${data['name']}',
                             style: const TextStyle(
                               fontSize: 20.0,
                               fontWeight: FontWeight.bold,
                             ),
                           ),
                           const SizedBox(height: 8.0),
                           Text(
                             'App ID: $documentId',
                             style: const TextStyle(fontSize: 16.0),
                           ),
                           const SizedBox(height: 8.0),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               const Icon(Icons.email),
                               const SizedBox(width: 8.0),
                               Text(data['email'], style: const TextStyle(fontSize: 16.0)),
                             ],
                           ),
                           const SizedBox(height: 16.0),
                           Text(
                             'Stream: ${data['Teacherof']}',
                             style: const TextStyle(fontSize: 16.0),
                           ),
                         const SizedBox(height: 16.0),
                           Text(
                             'Degree: ${data['Degree']}',
                             style: const TextStyle(fontSize: 16.0),
                           ),
                         ],
                       ),
                     ),
                   ),
                 )
               );
             },
           );
         }
       },
     ),
   );
  }
}
